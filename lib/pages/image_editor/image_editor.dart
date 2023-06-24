import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:tickets/pages/image_editor/widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller.dart';
import '../../models/pack.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/lite_loading_screen.dart';
import 'controller.dart';

class ImageEditorScreen extends StatefulWidget {
  final PackModel pack;
  final int currentIndex;
  const ImageEditorScreen({
    Key? key,
    required this.pack,
    required this.currentIndex,
  }) : super(key: key);

  @override
  ImageEditorScreenState createState() => ImageEditorScreenState();
}

class ImageEditorScreenState extends State<ImageEditorScreen> with TickerProviderStateMixin {
  final AppController appController = Get.find();
  PainterController painterController = PainterController();
  bool isLoaded = false;
  ui.Image? image;
  ByteData? pngBytes;
  double? screenWidth;
  @override
  initState() {
    getUiImage();

    super.initState();
  }

  getUiImage() async {
    image = await decodeImageFromList(base64.decode(
      widget.pack.pictures[widget.currentIndex].replaceAll(RegExp(r'\s+'), ''),
    ));

    Future.delayed(const Duration(milliseconds: 100)).then(
      (value) {
        painterController.addImage(image!, Size(screenWidth ?? 300, screenWidth ?? 300));

        // painterController.minScale = 100;
        // painterController.maxScale = 300;
      },
    );

    // await getPNG();
    setState(() {
      isLoaded = true;
    });
  }

  getPNG() async {
    // pngBytes = await image?.toByteData(format: ui.ImageByteFormat.png);
    painterController.addImage(image!);
    // log(pngBytes.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<ImageEditorScreenController>(
      init: ImageEditorScreenController(),
      builder: (controller) {
        return controller.isLoading
            ? const LiteLoadingScreen()
            : CustomScaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.WHITE,
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Image.asset(AppImages.arrow),
                    ),
                  ),
                ),
                backgroundColor: AppColors.DARK,
                body: SafeArea(
                  child: /* SingleChildScrollView(
                    child: */
                      Container(
                    height: screenHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          AppImages.back3,
                        ),
                        opacity: 1,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.WHITE.withOpacity(.8),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 12,
                                    offset: const Offset(5, 7),
                                    color: AppColors.DARK.withOpacity(.4),
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                height: screenWidth,
                                width: screenWidth,
                                child: FlutterPainter(
                                  controller: painterController,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0),
                        Row(
                          children: [
                            if (painterController.freeStyleMode == FreeStyleMode.erase)
                              IconButtonWidget(
                                title: 'Move',
                                subtitle: 'or resize',
                                icon: Image.asset(
                                  AppImages.hand,
                                  height: 42,
                                  width: 42,
                                ),
                                onPressed: () {
                                  painterController.freeStyleMode = FreeStyleMode.none;
                                  painterController.scalingEnabled = true;
                                  setState(() {});
                                },
                              )
                            else
                              IconButtonWidget(
                                title: 'Cut',
                                subtitle: 'manually',
                                icon: Image.asset(
                                  AppImages.scissors1,
                                  height: 42,
                                  width: 42,
                                ),
                                onPressed: () {
                                  painterController.freeStyleStrokeWidth = 35;
                                  painterController.freeStyleMode = FreeStyleMode.erase;
                                  setState(() {});
                                },
                              ),
                            IconButtonWidget(
                              title: 'Cut',
                              subtitle: 'automatically',
                              icon: Image.asset(
                                AppImages.scissors2,
                                height: 42,
                                width: 42,
                              ),
                              onPressed: () {
                                Get.snackbar('Sorry', 'Function in progrees');
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButtonWidget(
                              title: 'Redo',
                              icon: Image.asset(
                                AppImages.redo1,
                                height: 42,
                                width: 42,
                              ),
                              onPressed: () {
                                painterController.redo();
                              },
                            ),
                            IconButtonWidget(
                              title: 'Clear',
                              icon: Image.asset(
                                AppImages.clear,
                                height: 42,
                                width: 42,
                              ),
                              onPressed: () {
                                painterController.clearDrawables();
                                painterController.addImage(image!, Size(screenWidth ?? 300, screenWidth ?? 300));
                                setState(() {});
                              },
                            ),
                            IconButtonWidget(
                              title: 'Undo',
                              icon: RotatedBox(
                                quarterTurns: 3,
                                child: Image.asset(
                                  AppImages.undo,
                                  height: 42,
                                  width: 42,
                                ),
                              ),
                              onPressed: () {
                                painterController.undo();
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButtonWidget(
                              title: 'Save',
                              icon: Image.asset(
                                AppImages.save,
                                height: 42,
                                width: 42,
                              ),
                              onPressed: () async {
                                Uint8List? file = await renderImage(const Size(512, 512));

                                if (file != null) {
                                  final XFile image = XFile.fromData(
                                    Uint8List.fromList(file),
                                    mimeType: 'image/png',
                                  );

                                  final String path = (await getApplicationDocumentsDirectory()).path;

                                  image.saveTo('$path/test.png');

                                  Share.shareXFiles(
                                    [image],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Future<Uint8List?> renderImage(Size size) async {
    final ui.Image renderedImage = await painterController.renderImage(size);
    final Uint8List? byteData = await renderedImage.pngBytes;
    return byteData;
  }
}
