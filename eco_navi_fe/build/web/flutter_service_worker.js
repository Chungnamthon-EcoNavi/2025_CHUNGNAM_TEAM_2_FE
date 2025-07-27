'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "1ff9c664731d339b55ec584fb333ab67",
"assets/AssetManifest.bin.json": "0eaffde45a382d0a58981d9f5a635032",
"assets/AssetManifest.json": "38582ee1c7c55161c4b74417c4d2b86c",
"assets/assets/config/membershp_table.json": "f8a8574509659b64d380664943bed000",
"assets/assets/config/page_routing_table.json": "c785e578e26d8a8147bce52729434c63",
"assets/assets/fonts/Pretendard/Pretendard-Black.woff": "ffac9e667a7d8415953e5982a9ab1d51",
"assets/assets/fonts/Pretendard/Pretendard-Bold.woff": "bd94b933c6839371baa27f7950ef3784",
"assets/assets/fonts/Pretendard/Pretendard-ExtraBold.woff": "b065213da09db107d456c842bcff59ad",
"assets/assets/fonts/Pretendard/Pretendard-ExtraLight.woff": "a8765fcee2563360f3f8117835300c3d",
"assets/assets/fonts/Pretendard/Pretendard-Light.woff": "0fcba49d32bb9e4b3738d28bedb1bdd2",
"assets/assets/fonts/Pretendard/Pretendard-Medium.woff": "4750a6d12c26201887eee28ae55ed037",
"assets/assets/fonts/Pretendard/Pretendard-Regular.woff": "f897fa3ff216e4be74648184144780b1",
"assets/assets/fonts/Pretendard/Pretendard-SemiBold.woff": "e02072832a9d8ef22f3d1d08bb917f9d",
"assets/assets/fonts/Pretendard/Pretendard-Thin.woff": "bf79f0289a1950ddb6cbca0c709b77df",
"assets/assets/png/filter.png": "49e020b8d0513d4261e7b620bb8c602c",
"assets/assets/png/microphone.png": "ce30b499bd6fcc4881d3a16301c44523",
"assets/assets/png/notice.png": "bcd233c1224692ffc7731ff0e9843dc8",
"assets/assets/svg/bag.svg": "2fe9e2bd1922b031336c638789194195",
"assets/assets/svg/bell.svg": "23d16e68da9a84faebb2bd1e6c93d296",
"assets/assets/svg/chevron-down.svg": "500c5453f33536e09809c82b1dfe7b6c",
"assets/assets/svg/chevron-left.svg": "7695d8fd9812370c5a71bd2b818341b6",
"assets/assets/svg/chevron-up.svg": "ae96f44ab8a82f58724c6c193f0fe8f6",
"assets/assets/svg/currency-coin-rubel.svg": "4a0fcf810f896ea6568beca4ebe9a4f7",
"assets/assets/svg/dot-vertical.svg": "f782212ffa88958e22ae2b3519eba36b",
"assets/assets/svg/eco_navi_logo.svg": "dbf1b8b9fd01ec379ce7f3d352f5824a",
"assets/assets/svg/eco_navi_text_logo.svg": "64a00da6008d7db02228079de499d4dc",
"assets/assets/svg/favourite.svg": "1df37dc765d7bb86c8636c1c36354d2d",
"assets/assets/svg/frame.svg": "8965bdef438799be28a32a8949bad2b0",
"assets/assets/svg/heart.svg": "3f7d4472eb2f889f623d502144c8d503",
"assets/assets/svg/home.svg": "d090c83005d98053424276ce1af16eb3",
"assets/assets/svg/image-question.svg": "5bfe32ad4c1664a890bc1017be9a1170",
"assets/assets/svg/map.svg": "34a3d8f7b918d2c66dfe9fb151c32b4b",
"assets/assets/svg/marker.svg": "2eee466e0ee989c5a10b96c30fe688ab",
"assets/assets/svg/notice.svg": "12316d09d8de96b28aef7e07405b1ad1",
"assets/assets/svg/profile.svg": "6bf4aae102fd7d20f3d2da30bc557ebd",
"assets/assets/svg/star.svg": "664360fe34c80d9a6006f2a08d3190a9",
"assets/assets/svg/target.svg": "45c7a05ad9e0843099af9f08c51de782",
"assets/assets/svg/ticket.svg": "7a288c302cc8e32c1a2cd01f7d092150",
"assets/assets/svg/tmp_box.svg": "f34416f3afa5a69a4f9f960d71b1d85c",
"assets/assets/svg/trip_origin.svg": "ddc9aa99284e27bb1c12e99c82e08c68",
"assets/FontManifest.json": "2e5c6333b5c77f34b1f35a6ebc03e28a",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/NOTICES": "5edfee27fdf098393ba768c4a59ac1d2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "2a9630df4b18f20e0f4f22f5fce74236",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "ea495857fae20c9a643d2f556dce793a",
"/": "ea495857fae20c9a643d2f556dce793a",
"main.dart.js": "d3f604cb8d95afd134f2190a6ab0162a",
"manifest.json": "a363549daa2905bb07a4ca607df60955",
"version.json": "388751e5ba3abf29364361dc74cc29af"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
