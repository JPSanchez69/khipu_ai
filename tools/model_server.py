"""Servidor HTTP local con CORS y Range para un modelo LiteRT-LM grande."""

from __future__ import annotations

import argparse
import os
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer


class ModelHandler(SimpleHTTPRequestHandler):
    def end_headers(self) -> None:
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Headers", "Range, Content-Type")
        self.send_header("Access-Control-Expose-Headers", "Accept-Ranges, Content-Length, Content-Range")
        self.send_header("Accept-Ranges", "bytes")
        super().end_headers()

    def do_OPTIONS(self) -> None:  # noqa: N802
        self.send_response(204)
        self.send_header("Access-Control-Allow-Methods", "GET, HEAD, OPTIONS")
        self.end_headers()

    def send_head(self):
        path = self.translate_path(self.path)
        if os.path.isdir(path):
            return super().send_head()
        try:
            file = open(path, "rb")
        except OSError:
            self.send_error(404, "Archivo no encontrado")
            return None

        size = os.fstat(file.fileno()).st_size
        start, end = 0, size - 1
        range_header = self.headers.get("Range")
        if range_header and range_header.startswith("bytes="):
            try:
                raw_start, raw_end = range_header[6:].split("-", 1)
                if raw_start:
                    start = int(raw_start)
                if raw_end:
                    end = min(int(raw_end), size - 1)
                if start > end or start >= size:
                    raise ValueError
            except ValueError:
                file.close()
                self.send_error(416, "Rango no valido")
                return None
            self.send_response(206)
            self.send_header("Content-Range", f"bytes {start}-{end}/{size}")
        else:
            self.send_response(200)

        self.send_header("Content-Type", "application/octet-stream")
        self.send_header("Content-Length", str(end - start + 1))
        self.end_headers()
        file.seek(start)
        self._range_remaining = end - start + 1
        return file

    def copyfile(self, source, outputfile) -> None:
        remaining = getattr(self, "_range_remaining", None)
        if remaining is None:
            return super().copyfile(source, outputfile)
        while remaining:
            chunk = source.read(min(1024 * 1024, remaining))
            if not chunk:
                break
            outputfile.write(chunk)
            remaining -= len(chunk)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--directory", required=True)
    parser.add_argument("--port", type=int, default=8765)
    args = parser.parse_args()
    handler = lambda *a, **kw: ModelHandler(*a, directory=args.directory, **kw)
    ThreadingHTTPServer(("127.0.0.1", args.port), handler).serve_forever()


if __name__ == "__main__":
    main()
