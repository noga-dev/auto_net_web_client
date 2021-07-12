'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "3eafb45e7b2c3520d66622a56c11db66",
"main.dart.js": "544eb67d3cfaf798645f20948b8d2741",
"index.html": "55909253b0532e952d98cc7cbb362ad8",
"/": "55909253b0532e952d98cc7cbb362ad8",
"manifest.json": "31287241cf03ce358f9475d59cdb13d1",
"assets/NOTICES": "1a8f8a921f081ee1e2e3814513d3879a",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/assets/images/logo-black.png": "e7ec3361a8485eb3af41564d5ddf0313",
"assets/assets/images/bg-dark.jpg": "90686883709bcb67055e40d6d4e8e631",
"assets/assets/images/bg-light.jpg": "4191f77ba33a5da4566fccc52a903778",
"assets/assets/images/metamask.png": "0302f73181d8f9f76c95ca1e2a8e07d2",
"assets/assets/images/var/money_bag_q.png": "790f1dfb45a912d1506bfffc91ec1846",
"assets/assets/images/var/equity.png": "72322904081f98441a5b513385031d6c",
"assets/assets/images/var/credit.png": "68bf8e282f28a8a63ae384e986445d8e",
"assets/assets/images/var/reinforcement_learning.png": "f3eaa3cf980310ac8369876ccc653dec",
"assets/assets/images/var/store.png": "f0231425fb2f549a5d3389ad87521fdc",
"assets/assets/images/var/job_growth.png": "fc042a42b21093952aa6b2771ba5f25c",
"assets/assets/images/var/nlp.png": "bb350969bfb7897c8bb4b632bb2a7d48",
"assets/assets/images/var/neural_network.png": "e85ffb233067c7ee4ece4ee63d462159",
"assets/assets/images/var/market_closed.png": "c5fc5ac03fd92b4398cd717c6ce027a9",
"assets/assets/images/var/local_store.png": "4f82141d45236581218f82210ee19fb0",
"assets/assets/images/var/building.png": "d33c352d6cf092f3c4163e45a5c799d7",
"assets/assets/images/var/teddy_shop.png": "9cafb6f681bbeeb08047a7e13c52c8b1",
"assets/assets/images/var/cluster_analysis.png": "57e9e8e4e429f2f04764b0b6c22728e9",
"assets/assets/images/var/bayesian_network.png": "8269ba115eb517eec360ec159fee9f42",
"assets/assets/images/var/money_transfer.png": "808ddaa47ed0a4e804ffa0e1d9e00137",
"assets/assets/images/var/chart_up.png": "c0525c373ae6f58ca8a387a5c146007c",
"assets/assets/images/var/open_box.png": "aaf72878849819e7ffadef6eb4982412",
"assets/assets/images/var/machine_learning.png": "607fe1bad6b2f7af83b75e1abd87d5e5",
"assets/assets/images/var/iot.png": "5371c98009c8c4714b83c30b32934ad7",
"assets/assets/images/logo-white.png": "054612b92d788f09d1bb026407d9eecf",
"assets/assets/images/sun.png": "3fdc85cd8292a22802bae5a806e12a0a",
"assets/assets/images/moon.png": "5ea1082016968e8a9fa3dff477d5f70e",
"assets/assets/images/new_moon.png": "dbeb02c11293089861937b3fa718c4c0",
"assets/assets/anim/shopping-cart.zip": "1200002d9d590f6d6371767490a3c141",
"assets/assets/anim/nlp.zip": "b4f4db8424b98a19891e587d16e03128",
"assets/assets/anim/property.zip": "f46c8a87e37e103adbd5ee0bd455f9b9",
"assets/AssetManifest.json": "5cb31d506a9c103976206bd522bc628d",
"version.json": "e3eed385f7f6b611c9e3bf825784c442",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
