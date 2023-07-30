'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "da77dd2080d8bcd8f0ddaf6292e32187",
"index.html": "9ce9f1ffcbb47f7ecb14a92208fa87f5",
"/": "9ce9f1ffcbb47f7ecb14a92208fa87f5",
"main.dart.js": "70949587b781351d2a86f42632c75ca3",
"flutter.js": "1cfe996e845b3a8a33f57607e8b09ee4",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "6511e06f51b1984a8ef238dece84d9dd",
"assets/AssetManifest.json": "8cbf206f0db45b7b1b45ad65fc998f67",
"assets/NOTICES": "5e1769580b0a8df600d843c4aff9ffdf",
"assets/FontManifest.json": "e3637cec141ff037b4151edf1c0411cb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/fluttericon/lib/fonts/Octicons.ttf": "7242d2fe9e36eb4193d2bc7e521779bf",
"assets/packages/fluttericon/lib/fonts/Maki.ttf": "9ecdcd7d24a2461a55d532b86b2740bd",
"assets/packages/fluttericon/lib/fonts/Brandico.ttf": "791921e9b25210e2551b6eda3f86c733",
"assets/packages/fluttericon/lib/fonts/Entypo.ttf": "58edfaf27b1032ea4778b69297c02b5a",
"assets/packages/fluttericon/lib/fonts/Fontelico.ttf": "3a1e1cecf0a3eae6be5cba3677379ba2",
"assets/packages/fluttericon/lib/fonts/Iconic.ttf": "34e12214307f5f7cf7bc62086fbf55a3",
"assets/packages/fluttericon/lib/fonts/LineariconsFree.ttf": "276b1d61e45eb9b2dde9482545d9e3ac",
"assets/packages/fluttericon/lib/fonts/RpgAwesome.ttf": "99232001effca5cf2b5aa92cc3f3e892",
"assets/packages/fluttericon/lib/fonts/Typicons.ttf": "3386cae1128e52caf268508d477fb660",
"assets/packages/fluttericon/lib/fonts/FontAwesome.ttf": "799bb4e5c577847874f20bd0e9b38a9d",
"assets/packages/fluttericon/lib/fonts/Zocial.ttf": "c29d6e34d8f703a745c6f18d94ce316d",
"assets/packages/fluttericon/lib/fonts/WebSymbols.ttf": "4fd66aa74cdc6e5eaff0ec916ac269c6",
"assets/packages/fluttericon/lib/fonts/Linecons.ttf": "2d0ac407ed11860bf470cb01745fb144",
"assets/packages/fluttericon/lib/fonts/FontAwesome5.ttf": "221b27a41202ddd33990e299939e4504",
"assets/packages/fluttericon/lib/fonts/Elusive.ttf": "23f24df0388819e94db2b3c19841841c",
"assets/packages/fluttericon/lib/fonts/MfgLabs.ttf": "09daa533ea11600a98e3148b7531afe3",
"assets/packages/fluttericon/lib/fonts/Meteocons.ttf": "8b9c7982496155bb39c67eaf2a243731",
"assets/packages/fluttericon/lib/fonts/ModernPictograms.ttf": "5046c536516be5b91c15eb7795e0352d",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/ic_scissors3.png": "b297dac2e438f612cb79fd65647f9fd0",
"assets/assets/images/smiles3.png": "e61245599ed0703f421fa16c7e102dce",
"assets/assets/images/ic_notebook.png": "194fa0ad2f8836e4f264ee76d643b382",
"assets/assets/images/smiles2.png": "cecedb13c3d0631ab66f3d06651ed086",
"assets/assets/images/ic_scissors2.png": "da15f1222c39c823d84a19fec5d0e8c9",
"assets/assets/images/smiles1.png": "badd2fadc857fdd61b156c7513d38940",
"assets/assets/images/ic_scissors1.png": "9d0a06351de483418cc6dc564f02f1ed",
"assets/assets/images/ic_hand.png": "3f8904f9c3be877121766d772262e04a",
"assets/assets/images/smiles5.png": "9e86efc6c4e6cc04a1ea5bf550ae7411",
"assets/assets/images/ic_redo1.png": "ae8c09ceef529997ce2faf4cbdf98bd5",
"assets/assets/images/ic_scissors4.png": "811bc0ada895e4078231c4e53b867d5c",
"assets/assets/images/smiles4.png": "481efb774623aca6f92b4f9635fbcfae",
"assets/assets/images/smiles6.png": "99232b15ef6dc93a636e9f22aba1967f",
"assets/assets/images/ic_home.png": "da2cc9ef10532faab506c15f21b4ad58",
"assets/assets/images/ic_clear.png": "28d7cca267f7f7d01ebe2f793f8b81d9",
"assets/assets/images/back2.png": "ff7198e0550b52487acc9d4a18289d5f",
"assets/assets/images/art4.png": "e0e56a4fccbed76e02b5b6058e55b79f",
"assets/assets/images/back3.png": "c17f1214d24e71c1715f0779eb980ca8",
"assets/assets/images/back1.png": "935d17cd0c0160e8f35f4d4989e7b2ac",
"assets/assets/images/ic_arrow2.png": "69e5fa246701139980d5372d13d47ab2",
"assets/assets/images/back4.png": "cf378942c019bfa7e057d5f9dee3567d",
"assets/assets/images/ic_arrow.png": "95fe62a435023dbf252a0834d6b984ce",
"assets/assets/images/ic_save1.png": "e6120c21cda44456d813ba4adf5662ab",
"assets/assets/images/art2.png": "7949e811ddc945deab8e23de2c3a008e",
"assets/assets/images/ic_settings.png": "a7f54797d913fa14429d708d2a756942",
"assets/assets/images/art3.png": "244528df26a5d94fd41de99132495266",
"assets/assets/images/ic_save.png": "44d32d0b8762ac2d2a68afa00a7c0d24",
"assets/assets/images/empty_screen.png": "485cf78a589e853579d80c937d0f4c3a",
"assets/assets/images/ic_arrow1.png": "50db6ec8ef90108a951aae487c25164f",
"assets/assets/images/art1.png": "df77be04bd49ecff18898f6a9fb70316",
"assets/assets/images/ic_redo.png": "e41420457f0bb7f9b2b56ee10719a085",
"assets/assets/images/ic_app_icon.png": "f698fa27290af0b29b4865d2fb2d5f8c",
"assets/assets/images/sticker1.png": "2910be7c2a5fa4efd802d6bd597c9cad",
"assets/assets/images/ic_notebook1.png": "1ef301d19d1a2dd01222420382797b19",
"assets/assets/images/art.png": "a8506a1b56961732c15b885d9fb94082",
"assets/assets/images/sticker3.png": "2c339bfa8c3ebe1be6f428bbfe7ba480",
"assets/assets/images/sticker2.png": "19800f10c9b70ef3f5dab7c099970ea9",
"assets/assets/images/ic_notebook2.png": "d6859507d6eed79670a510468fc54747",
"assets/assets/images/empty_screen1.png": "80875f7107efc468b5c4a80734007895",
"assets/assets/images/sticker6.png": "8f4fba96c8dc35c0b9a16dc2409ba6a6",
"assets/assets/images/transparent.png": "9d2846307376c6d8bdbd463ee2f7ffa6",
"assets/assets/images/sticker.png": "c62fe9e78bfc1ef2896f5219a5052fc5",
"assets/assets/images/back.png": "ec09936b7a40cbb4737b00c8a29f0bd7",
"assets/assets/images/ic_undo.png": "8506ea2eb4a90cf4ca0a09829bd93867",
"assets/assets/images/sticker5.png": "02c579d67d16734546e10cf5a7a73264",
"assets/assets/images/sticker4.png": "df535cdddf7ac36b794ce68215d58ca1",
"assets/assets/images/smiles.png": "aa84fe42c46922d4c4328c6a1973f0a3",
"assets/assets/animations/party_5.json": "ccf07a962dc8575c1b361aa95226c918",
"assets/assets/animations/cat_play.json": "736f6ed9399cfba741c7a0d98a71262c",
"assets/assets/animations/point_5.json": "a01dceaf636f97f9170fffc89813a4b5",
"assets/assets/animations/error.json": "7c1d698ef18c56931b9b9e28780e5be2",
"assets/assets/animations/dark_theme.json": "65b4ac6d9e0365e2e9ca70fa4bcfe63d",
"assets/assets/animations/point_4.json": "d8fa43feb45e0bfb49bfaf132071bae2",
"assets/assets/animations/cat_social.json": "ef2c9b86b2735ecb8cb93437e08a7160",
"assets/assets/animations/cat_1.json": "816d3f1d6e0071b3f8d71168f1bc51e6",
"assets/assets/animations/party_4.json": "cbe9ce2009e6e701c414d2c1e3844474",
"assets/assets/animations/cat_box.json": "d8d449d4308de38163ecb2c523e2145b",
"assets/assets/animations/point_3.json": "4f8e7f95ac124f3c079f68728b352ea9",
"assets/assets/animations/party_3.json": "0db4b0e818c5b40b5c0e15ab3b86110c",
"assets/assets/animations/cat_happy.json": "4f65d6fcecc62e50ce2313e03b04be0f",
"assets/assets/animations/cat_cyber.json": "05502b038a4eaed3cfb7be7240eab29c",
"assets/assets/animations/cat_search.json": "159ad97b169f6630302230da9087fb6b",
"assets/assets/animations/party_2.json": "12569268a49e589c6b75848960491108",
"assets/assets/animations/point_2.json": "4ceb4364db6fef5b7673f82abdf9c865",
"assets/assets/animations/sunset.json": "162be87328e9bf7988114db5e39e46ec",
"assets/assets/animations/point_1.json": "4ec1cff0d45d0003bdbed41391c525a8",
"assets/assets/animations/map_1.json": "7958a8c809fc98a841df84e19860cbf0",
"assets/assets/animations/party_1.json": "b32136f4e369df9037b2936ee095602b",
"assets/assets/animations/cat_sleep.json": "bb7b8fad8028cfce6a55b78a40f6904c",
"assets/assets/animations/lama.json": "87d8bb27736e48cc0cdeb7e75e9540f4",
"assets/assets/animations/cat_rock.json": "1a40351dd19398c31ac67e6ea198fbf9",
"assets/assets/animations/cat_walk.json": "76c3df2230a9742c7201e3b76410f5bb",
"assets/assets/animations/light_theme.json": "812e904e0d55978403cce98cdf2e0b8a",
"assets/assets/animations/walker_1.json": "6c11736b8c1775b0dcfefab3c4234edc",
"assets/assets/animations/point_6.json": "b6eb9d893e47fd6549c57754ba296459",
"assets/assets/animations/party_6.json": "5c87862f8f5c032f372e96babc282f26",
"assets/assets/animations/cat_hide.json": "b5f1c86d60a5a8027d90b0fd8d3801b8",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
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
