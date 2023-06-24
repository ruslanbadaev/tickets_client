import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../mixins/utils.dart';
import '../../models/marker.dart';
import '../../models/price.dart';

enum PointType { sit, sector, object }

class CreationScreenController extends GetxController with Utils {
  MarkerModel? _selectedPrice;
  MarkerModel? _hoveredPrice;
  PointType? _pointType;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<List<MarkerModel?>> grid = [];

  List<MarkerModel> prices = [];

  MarkerModel? get selectedPrice => _selectedPrice;
  MarkerModel? get hoveredPrice => _hoveredPrice;
  PointType? get pointType => _pointType;

  @override
  void onReady() {
    super.onReady();
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
            row: incrX,
            column: incrY,
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
      grid[x][y]?.name = value?.name ?? '?';
      grid[x][y]?.price = value?.price;
      grid[x][y]?.color = value?.color ?? Colors.grey;
      grid[x][y]?.type = value?.type;
      update();
    } catch (e) {
      log(e.toString(), name: 'setGridElement error');
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
    prices.add(price);
    nameController.clear();
    priceController.clear();
    _pointType = null;
    selectPrice(price);
    update();
  }

  void removePrice(MarkerModel price) {
    prices.remove(price);
    update();
  }

  void selectPointType(PointType type) {
    log(type.toString());
    _pointType = type;
    update();
  }
}
