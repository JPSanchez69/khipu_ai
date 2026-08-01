/** OPFS streaming helper required by flutter_gemma on web. */
window.flutterGemmaOPFS = {
  async isModelCached(filename) {
    try {
      const root = await navigator.storage.getDirectory();
      await root.getFileHandle(filename);
      return true;
    } catch (_) {
      return false;
    }
  },

  async getCachedModelSize(filename) {
    try {
      const root = await navigator.storage.getDirectory();
      const handle = await root.getFileHandle(filename);
      return (await handle.getFile()).size;
    } catch (_) {
      return null;
    }
  },

  async downloadToOPFS(url, filename, authToken, onProgress, abortSignal) {
    let reader = null;
    let writable = null;
    try {
      const headers = authToken ? {Authorization: `Bearer ${authToken}`} : {};
      const response = await fetch(url, {headers, signal: abortSignal || undefined});
      if (!response.ok) throw new Error(`HTTP ${response.status}: ${response.statusText}`);

      const contentLength = Number(response.headers.get('content-length') || 0);
      const estimate = await navigator.storage.estimate();
      const available = (estimate.quota || 0) - (estimate.usage || 0);
      if (contentLength && estimate.quota && contentLength > available) {
        throw new Error(
          `Espacio insuficiente: se necesitan ${(contentLength / 1e9).toFixed(2)} GB`,
        );
      }

      const root = await navigator.storage.getDirectory();
      const handle = await root.getFileHandle(filename, {create: true});
      writable = await handle.createWritable();
      reader = response.body.getReader();
      let received = 0;
      let lastProgress = -1;
      while (true) {
        if (abortSignal?.aborted) throw new DOMException('Download aborted', 'AbortError');
        const {done, value} = await reader.read();
        if (done) break;
        await writable.write(value);
        received += value.length;
        if (contentLength) {
          const progress = Math.round((received / contentLength) * 100);
          if (progress !== lastProgress) {
            lastProgress = progress;
            onProgress(progress);
          }
        }
      }
      await writable.close();
      writable = null;
      onProgress(100);
      return true;
    } catch (error) {
      try { await reader?.cancel(); } catch (_) {}
      try { await writable?.abort(); } catch (_) {}
      if (error.name === 'AbortError') {
        try {
          const root = await navigator.storage.getDirectory();
          await root.removeEntry(filename);
        } catch (_) {}
      }
      console.error('[Khipu OPFS] Falló la instalación:', error);
      throw error;
    }
  },

  async getStreamReader(filename) {
    const root = await navigator.storage.getDirectory();
    const handle = await root.getFileHandle(filename);
    return (await handle.getFile()).stream().getReader();
  },

  async getReadableStream(filename) {
    const root = await navigator.storage.getDirectory();
    const handle = await root.getFileHandle(filename);
    return (await handle.getFile()).stream();
  },

  async deleteModel(filename) {
    const root = await navigator.storage.getDirectory();
    await root.removeEntry(filename);
  },

  async getStorageStats() {
    const estimate = await navigator.storage.estimate();
    return {usage: estimate.usage || 0, quota: estimate.quota || 0};
  },

  async clearAll() {
    const root = await navigator.storage.getDirectory();
    let count = 0;
    for await (const [name, handle] of root.entries()) {
      if (handle.kind === 'file') {
        await root.removeEntry(name);
        count++;
      }
    }
    return count;
  },
};

console.log('[Khipu OPFS] Helper cargado');
