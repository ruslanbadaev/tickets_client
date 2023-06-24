import 'dart:developer';

import 'package:get/get.dart';

import '../../mixins/utils.dart';
import '../../models/concert.dart';

enum PointType { sit, sector, object }

class ConcertsScreenController extends GetxController with Utils {
  final List<ConcertModel> _allConcerts = [];
  List<ConcertModel> get allConcerts => _allConcerts;

  @override
  void onReady() async {
    super.onReady();
    _allConcerts.addAll((await ConcertModel.getAll())!.data);
    log(_allConcerts.toString());
    update();
  }

  Future<void> getAllItems() async {
    _allConcerts.addAll((await ConcertModel.getAll())!.data);
    log(_allConcerts.toString());
    update();
  }
}
