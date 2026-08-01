/** Cache API bindings required by flutter_gemma on web. */
window.cacheHas = async (cacheName, url) => {
  try { return !!(await (await caches.open(cacheName)).match(url)); }
  catch (_) { return false; }
};

window.cacheGetBlobUrl = async (cacheName, url) => {
  try {
    const response = await (await caches.open(cacheName)).match(url);
    if (!response) return null;
    const data = await response.arrayBuffer();
    return URL.createObjectURL(new Blob([data], {type: 'application/octet-stream'}));
  } catch (_) { return null; }
};

window.cachePut = async (cacheName, url, data) => {
  const cache = await caches.open(cacheName);
  await cache.put(url, new Response(data, {
    headers: {'Content-Type': 'application/octet-stream'},
  }));
};

window.cacheDelete = async (cacheName, url) =>
  (await caches.open(cacheName)).delete(url);
window.cacheDeleteCache = async (cacheName) => caches.delete(cacheName);
window.cacheGetAllKeys = async (cacheName) =>
  (await (await caches.open(cacheName)).keys()).map((request) => request.url);
window.storageRequestPersistent = async () =>
  navigator.storage?.persist ? navigator.storage.persist() : false;
window.storageGetQuota = async () => {
  const estimate = await navigator.storage.estimate();
  return {usage: estimate.usage || 0, quota: estimate.quota || 0};
};
window.blobUrlRevoke = (url) => URL.revokeObjectURL(url);
window.createBlob = (data) => new Blob([data], {type: 'application/octet-stream'});

console.log('[Khipu Cache] Helper cargado');
