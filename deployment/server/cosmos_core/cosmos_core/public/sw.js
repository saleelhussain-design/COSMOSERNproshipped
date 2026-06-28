const CACHE_NAME = 'CosmOS-erp-cache-v1';
const ASSETS_TO_CACHE = [
  '/',
  '/assets/CosmOS_core/css/CosmOS.css',
  '/assets/frappe/dist/css/desk.bundle.css'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      return cache.addAll(ASSETS_TO_CACHE);
    })
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request).then(response => {
      return response || fetch(event.request);
    })
  );
});
