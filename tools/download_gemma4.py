"""Download Gemma 4 E2B LiteRT-LM artifact (gated HF repo)."""
from __future__ import annotations

import os
import sys
from pathlib import Path

REPO = "litert-community/gemma-4-E2B-it-litert-lm"
FILE = "gemma-4-E2B-it.litertlm"
OUT = Path.home() / ".litert-lm" / "models" / "gemma-4-E2B-it"


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    token = os.environ.get("HUGGINGFACE_TOKEN") or os.environ.get("HF_TOKEN")
    if not token:
        print(
            "DOWNLOAD_FAIL MissingToken: set HUGGINGFACE_TOKEN or HF_TOKEN "
            "(repo gated; accept Gemma license on HF first)."
        )
        return 2
    try:
        from huggingface_hub import hf_hub_download
    except ImportError:
        print("DOWNLOAD_FAIL ImportError: pip install huggingface_hub")
        return 3

    path = hf_hub_download(
        repo_id=REPO,
        filename=FILE,
        local_dir=str(OUT),
        token=token,
    )
    p = Path(path)
    print("DOWNLOADED", p)
    print("SIZE", p.stat().st_size)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
