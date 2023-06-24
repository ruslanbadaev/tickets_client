import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controller.dart';
import '../../utils/constants/strings.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import 'controller.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  final String? title;
  const WebviewScreen({
    required this.url,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  WebviewScreensState createState() => WebviewScreensState();
}

class WebviewScreensState extends State<WebviewScreen> with TickerProviderStateMixin {
  final AppController appController = Get.find();

  WebViewController? webViewController;
  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<WebviewScreenController>(
      init: WebviewScreenController(),
      builder: (controller) {
        return controller.isLoading
            ? const LiteLoadingScreen()
            : CustomScaffold(
                appBar: CustomAppBar(
                  titleString: widget.title,
                  backgroundColor: Get.theme.backgroundColor,
                ),
                backgroundColor: Get.theme.backgroundColor,
                body: WebViewWidget(controller: webViewController!),
              );
      },
    );
  }
}
