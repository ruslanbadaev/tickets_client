import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../mixins/utils.dart';
import '../../models/concert.dart';
import '../../models/marker.dart';
import '../../models/result.dart';

enum PointType { sit, sector, object }

class CreationScreenController extends GetxController with Utils {
  MarkerModel? _selectedPrice;
  MarkerModel? _hoveredPrice;
  PointType? _pointType;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<List<MarkerModel>> grid = [];

  List<MarkerModel> prices = [];

  MarkerModel? get selectedPrice => _selectedPrice;
  MarkerModel? get hoveredPrice => _hoveredPrice;
  PointType? get pointType => _pointType;

  @override
  void onReady() {
    super.onReady();
  }

  void getAllMarkersByConcertId(String concertId) async {
    ResultModel? result = await MarkerModel.getAllByConcertId(
      concertId,
      isGrid: false,
    );

    if (result != null) {
      prices.addAll(result.data as List<MarkerModel>);
      log(prices.toString(), name: 'prices');
      update();
    }
  }

  Future<void> getGridByConcertId(String concertId) async {
    List<List<MarkerModel>> xList = [];

    ResultModel? result = await MarkerModel.getGridElements(
      concertId: concertId,
    );
    // ResultModel? result = await MarkerModel.getGridByConcertId(
    //   concertId: concertId,
    // );
    log((result?.data as List<MarkerModel>).length.toString(), name: 'getGridByConcertId R/D');

    List<MarkerModel> allMarkers = result?.data as List<MarkerModel>;

    int maxX = 0;
    int maxY = 0;

    for (var marker in allMarkers) {
      if ((marker.x ?? 0) > maxX) {
        maxX = marker.x!;
      }
      if ((marker.y ?? 0) > maxY) {
        maxY = marker.y!;
      }
    }

    maxX++;
    // maxX++;
    // maxX++;
    maxY++;

    log(maxX.toString(), name: 'maxX');
    log(maxY.toString(), name: 'maxY');
    for (var x = 0; x < maxX; x++) {
      List<MarkerModel> yList = [];
      for (var y = 0; y < maxY; y++) {
        yList.add(
          MarkerModel(
            id: '0',
            name: 'x:$x|y:$y',
            color: Colors.grey,
            x: x,
            y: y,
          ),
        );
      }
      xList.add(yList);
      // yList.clear();
    }

    for (var marker in allMarkers) {
      xList[marker.x!][marker.y!] = marker;
      log(xList[marker.x!][marker.y!].toString(), name: 'xList[marker.x!][marker.y!]');
    }

    log(xList.toString(), name: 'xList');
    // log(xList[0][1].toString(), name: 'xList 0/20');
    // log(xList[1][1].toString(), name: 'xList 5/5');
    log(xList.length.toString(), name: 'xList length');
    if (xList.length > 1) {
      grid = xList;
    }

    update();
  }

  void generateGrid(int x, int y) {
    int incrX = 0;
    grid.clear();
    while (incrX < x) {
      grid.add([]);
      int incrY = 0;
      while (incrY < y) {
        grid[incrX].add(
          MarkerModel(
            id: '0',
            name: 'x:$incrX|y:$incrY',
            color: Colors.grey,
            x: incrX,
            y: incrY,
          ),
        );
        incrY++;
      }
      incrX++;
    }
    update();
  }

  setGridElement(int x, int y, MarkerModel? value) {
    try {
      log('x:$x, y:$y');
      // log(y.toString(), name: 'y');
      // log(x.toString(), name: 'x');
      // log((grid[x][y]?.name).toString(), name: 'grid[x][y]');
      // value?.row = x;
      // value?.column = y;
      debugPrint(grid[x][y].toString());
      debugPrint(value.toString());
      grid[x][y].name = value?.name ?? '?';
      grid[x][y].price = value?.price;
      grid[x][y].color = value?.color ?? Colors.grey;
      grid[x][y].type = value?.type;
      update();
    } catch (e) {
      log(e.toString(), name: 'setGridElement error');
    }
  }

  void saveGridList(String concertId) async {
    log(concertId.toString(), name: 'concertId');
    try {
      List<List<Map<String, dynamic>>> gridForSave = [];
      log(grid.length.toString(), name: 'grid');
      for (List<MarkerModel> list in grid) {
        log(list.length.toString(), name: 'list');
        List<Map<String, dynamic>> gridForSaveY = [];
        for (MarkerModel element in list) {
          log(element.toString(), name: 'element');
          gridForSaveY.add(MarkerModel.toJson(element));
        }
        gridForSave.add(gridForSaveY);
      }
      await MarkerModel.mergeGridList(gridForSave, concertId: concertId).then((value) {
        Get.snackbar('Готово', 'Данные сохранены');
      });

      // MarkerModel.mergeGrid({
      //   'data': jsonEncode({
      //     'data': gridForSave.toString(),
      //   }),
      // }, concertId: concertId);
    } catch (e) {
      log(e.toString(), name: 'saveGridList error');
    }
  }

  void selectPrice(MarkerModel price) {
    _selectedPrice = price;

    update();
  }

  void hoverItem(MarkerModel? price) {
    _hoveredPrice = price;
    update();
  }

  void createPrice(MarkerModel price) {
    MarkerModel.merge(
      {
        'concertId': price.concertId,
        'name': price.name,
        'price': price.price,
        'type': price.type?.name,
        'color': price.color.value,
      },
    );
    prices.add(price);
    nameController.clear();
    priceController.clear();
    _pointType = null;
    selectPrice(price);
    update();
  }

  void removePrice(MarkerModel price) {
    log(price.id, name: 'removePrice id');
    MarkerModel.delete(price.id, toGrid: false);
    prices.remove(price);
    update();
  }

  void selectPointType(PointType type) {
    log(type.toString());
    _pointType = type;
    update();
  }

  void updateConcert(String id, Map<String, dynamic> json) {
    ConcertModel.update(id, json);
    update();
  }
}
