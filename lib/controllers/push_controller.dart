// import 'dart:developer';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';

// import '../mixins/cache_manager.dart';
// import '../pages/settings/screens/app_settings.dart';

// class PushController extends GetxController with CacheManager {
//   @override
//   void onInit() {
//     super.onInit();
//     _premissionRequest();
//   }

//   void _premissionRequest() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     print('User granted permission: ${settings.authorizationStatus}');
//     _messagesListener();
//   }

//   void _messagesListener() async {
//     log('_messagesListener');

//     log(' -- - -- - -- -  - - - -  - - - - - - -  - - - - - - - -  - - -setupInteractedMessage');
//     ReceivedAction? receivedAction =
//         await AwesomeNotifications().getInitialNotificationAction(removeFromActionEvents: false);
//     log((receivedAction?.channelKey).toString(), name: 'receivedAction?.channelKey');
//     if (receivedAction?.channelKey == 'basic_channel') {
//       Get.to(AppSettingsScreen());
//     }

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 10,
//           channelKey: 'basic_channel',
//           title: 'AAAAAv',
//           body: 'Simple body',
//           actionType: ActionType.Default,
//         ),
//       );
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');

//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//       }
//     });
//   }
// }
