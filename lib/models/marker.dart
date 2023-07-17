import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tickets/models/result.dart';
import 'package:tickets/pages/creation/controller.dart';

class MarkerModel {
  final String id;
  final String? concertId;
  final int? x;
  final int? y;
  String name;
  Color color;
  String? price;
  String? createdAt;
  PointType? type;
  MarkerModel({
    required this.id,
    this.concertId,
    required this.name,
    required this.color,
    this.x,
    this.y,
    this.price,
    this.createdAt,
    this.type,
  });

  static Map<String, dynamic> toJson(MarkerModel price) {
    return {
      'id': price.id.toString(),
      'name': price.name.toString(),
      'color': price.color.value.toString(),
      'type': price.type?.name.toString(),
      'price': price.price.toString(),
      'createdAt': price.createdAt.toString(),
      'x': price.x.toString(),
      'y': price.y.toString(),
    };
  }

  // static List<MarkerModel> listFromJson(List<dynamic> list) {
  //   return list.map((json) => MarkerModel.fromJson(json)).toList();
  // }

  static MarkerModel fromJson(Map<String, dynamic> json) {
    // debugPrint(json.toString());
    return MarkerModel(
      id: (json['id']) ?? '?',
      concertId: json['concertId'] ?? '??',
      name: json['name'] ?? '??',
      color: Color((json['color'] is int?) ? (json['color'] ?? 10) : int.tryParse(json['color']) ?? 10),
      type: json['type'] == null ? null : PointType.values.byName(json['type']),
      price: json['price'] ?? '??',
      createdAt: json['createdAt'] ?? '??',
      x: ((json['x'] is int?) || json['x'] == null) ? json['x'] : int.tryParse(json['x']),
      y: ((json['y'] is int?) || json['y'] == null) ? json['y'] : int.tryParse(json['y']),
    );
  }

  static Future<ResultModel> save(Map<String, dynamic> json, {required bool toGrid}) async {
    try {
      final collection = FirebaseFirestore.instance.collection(toGrid ? 'grid' : 'markers');
      json['createdAt'] = DateTime.now().toString();
      await collection.doc().set(json, SetOptions());

      return ResultModel(
        status: ResultStatus.success,
      );
    } catch (e) {
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  static Future<ResultModel> merge(Map<String, dynamic> json) async {
    try {
      final collection = FirebaseFirestore.instance.collection('markers');
      json['createdAt'] = DateTime.now().toString();
      await collection.doc().set(json, SetOptions(merge: true));

      return ResultModel(
        status: ResultStatus.success,
      );
    } catch (e) {
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  static Future<ResultModel> mergeGrid(Map<String, dynamic> json, {required String concertId}) async {
    try {
      final collection = FirebaseFirestore.instance.collection('grid');
      // json['createdAt'] = DateTime.now().toString();
      await collection.doc('cid_$concertId').set(json, SetOptions(merge: true));

      return ResultModel(
        status: ResultStatus.success,
      );
    } catch (e) {
      log(e.toString(), name: 'mergeGrid error');
      debugPrint(e.toString());
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  static Future<ResultModel> mergeGridList(List<List<Map<String, dynamic>>> xlist, {required String concertId}) async {
    try {
      final collection = FirebaseFirestore.instance.collection('grid');
      // json['createdAt'] = DateTime.now().toString();

      for (var yList in xlist) {
        for (var element in yList) {
          debugPrint(jsonEncode(element).toString());

          element['concertId'] = concertId;
          collection.doc('${concertId}_x${element['x']}y${element['y']} ').set(element, SetOptions(merge: true));
        }
      }
      // await collection.doc('cid_$concertId').set({}, SetOptions(merge: true));

      return ResultModel(
        status: ResultStatus.success,
      );
    } catch (e) {
      log(e.toString(), name: 'mergeGrid error');
      debugPrint(e.toString());
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  static Future<ResultModel?> getAllByConcertId(String concertId, {required bool isGrid}) async {
    try {
      final db = FirebaseFirestore.instance;
      Query<Map<String, dynamic>>? data;
      List<MarkerModel> allResults = [];
      data = db.collection(isGrid ? 'grid' : 'markers').where('concertId', isEqualTo: concertId);

      var documentSnapshots = await data.get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in documentSnapshots.docs) {
        ResultModel result = await MarkerModel.fromFirestore(element, SnapshotOptions());

        if (result.status == ResultStatus.success && result.data != null) {
          try {
            allResults.add((await result.data) as MarkerModel);
            // log((result.data as MarkerModel).toString(), name: 'ppp');
            log(allResults.toString(), name: 'allResults');
          } catch (e) {
            log(e.toString(), name: '11551132');
          }
        } else {
          Get.defaultDialog(content: Text(ResultModel.parseError(result.message)));
        }
      }

      return ResultModel(
        data: allResults,
        status: ResultStatus.success,
      );
    } catch (e) {
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  // static Future<ResultModel?> getAll({required bool toGrid}) async {
  //   try {
  //     final db = FirebaseFirestore.instance;
  //     Query<Map<String, dynamic>>? data;
  //     List<MarkerModel> allResults = [];
  //     data = db.collection(toGrid ? 'вч0' : 'markers').orderBy('createdAt');

  //     var documentSnapshots = await data.get();
  //     for (QueryDocumentSnapshot<Map<String, dynamic>> element in documentSnapshots.docs) {
  //       ResultModel result = await MarkerModel.fromFirestore(element, SnapshotOptions());
  //       if (result.status == ResultStatus.success && result.data != null) {
  //         try {
  //           allResults.add(result.data as MarkerModel);
  //           // log((result.data as MarkerModel).toString(), name: 'ppp');
  //           // log(allResults.toString(), name: 'allResults');
  //         } catch (e) {
  //           log(e.toString(), name: '11551132');
  //         }
  //       } else {
  //         // Get.defaultDialog(content: Text(ResultModel.parseError(result.message)));
  //       }
  //     }

  //     return ResultModel(
  //       data: allResults,
  //       status: ResultStatus.success,
  //     );
  //   } catch (e) {
  //     return ResultModel(
  //       status: ResultStatus.error,
  //       message: e.toString(),
  //     );
  //   }
  // }

  static Future<ResultModel?> getGridElements({required String concertId}) async {
    try {
      final db = FirebaseFirestore.instance;
      Query<Map<String, dynamic>>? data;
      List<MarkerModel> allResults = [];
      data = db.collection('grid').where('concertId', isEqualTo: concertId);

      var documentSnapshots = await data.get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in documentSnapshots.docs) {
        ResultModel result = await MarkerModel.fromFirestore(element, SnapshotOptions());
        if (result.status == ResultStatus.success && result.data != null) {
          try {
            log('------- -------- --------');
            // debugPrint(result.data.toString());
            allResults.add(result.data as MarkerModel);
            // log((result.data as MarkerModel).toString(), name: 'ppp');
            // log(allResults.toString(), name: 'allResults');
          } catch (e) {
            log(e.toString(), name: '11551132');
          }
        } else {
          log('eerrere', name: '11551133211');
          // Get.defaultDialog(content: Text(ResultModel.parseError(result.message)));
        }
      }

      return ResultModel(
        data: allResults,
        status: ResultStatus.success,
      );
    } catch (e) {
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  static Future<ResultModel> get({required bool toGrid}) async {
    try {
      ResultModel? result;
      final db = FirebaseFirestore.instance;
      DocumentReference<Map<String, dynamic>> data;

      data = db.collection(toGrid ? 'grid' : 'markers').doc();

      data.get().then(
        (documentSnapshots) async {
          result = await MarkerModel.fromFirestore(documentSnapshots, SnapshotOptions());

          log(result!.data.toString());
        },
        onError: (e) => print("Error completing: $e"),
      );

      return ResultModel(
        data: result,
        status: ResultStatus.success,
      );
    } catch (e) {
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  // static Future<ResultModel> getGridByConcertId({required String concertId}) async {
  //   try {
  //     ResultModel? result;
  //     final db = FirebaseFirestore.instance;
  //     DocumentReference<Map<String, dynamic>> data;

  //     data = db.collection('grid').doc('cid_$concertId');

  //     data.get().then(
  //       (documentSnapshots) async {
  //         log(concertId, name: 'concertId');
  //         // jsonDecode(value)
  //         final data = documentSnapshots.data();
  //         log(data.toString(), name: 'getGridByConcertId');
  //         result = await MarkerModel.gridFromFirestore(documentSnapshots, SnapshotOptions());

  //         // log(result!.data.toString(), name: 'getGridByConcertId');
  //       },
  //       onError: (e) => print("Error completing: $e"),
  //     );

  //     return ResultModel(
  //       data: result,
  //       status: ResultStatus.success,
  //     );
  //   } catch (e) {
  //     return ResultModel(
  //       status: ResultStatus.error,
  //       message: e.toString(),
  //     );
  //   }
  // }

  static Future<ResultModel> fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) async {
    try {
      final data = snapshot.data();
      log('-0--0-0 -0-0 -0- 0 -0 - 0-');
      log(data.toString(), name: 'lololg');
      // debugPrint(data.toString());
      if (data == null) {
        throw 'MarkerModel fromFirestore';
      }
      data['id'] = snapshot.id;
      return ResultModel(status: ResultStatus.success, data: MarkerModel.fromJson(data)

          // (
          //   // id: data?['id'] ?? '??',
          //   id: snapshot.id,
          //   name: data?['name'] ?? '??',
          //   concertId: 'No',
          //   color: data?['color'] ?? '??',
          //   row: data?['row'] ?? '??',
          //   column: data?['column'] ?? '??',
          // ),
          );
    } catch (e) {
      log(e.toString());
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  // static Future<ResultModel> gridFromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) async {
  //   try {
  //     List<List> result = [];
  //     Map<String, dynamic>? data = snapshot.data();
  //     log(data.toString(), name: 'data.toString()');
  //     log((Map.from(jsonDecode(data?['data']))['data'].runtimeType).toString(), name: 'gridFromFirestore jsonDecode');

  //     for (var element in Map.from(jsonDecode(data?['data']))['data']) {
  //       log(element.toString());
  //     }
  //     // {concertId: ckkAZkTV2biZCWmkrWm2, data: [[{id: 0, …e: null, createdAt: null, row: 10, column: 21}]]}
  //     if (data == null) {
  //       throw 'MarkerModel fromFirestore';
  //     }

  //     return ResultModel(status: ResultStatus.success, data: MarkerModel.fromJson(data)

  //         // (
  //         //   // id: data?['id'] ?? '??',
  //         //   id: snapshot.id,
  //         //   name: data?['name'] ?? '??',
  //         //   concertId: 'No',
  //         //   color: data?['color'] ?? '??',
  //         //   row: data?['row'] ?? '??',
  //         //   column: data?['column'] ?? '??',
  //         // ),
  //         );
  //   } catch (e) {
  //     log(e.toString(), name: 'gridFromFirestore error');
  //     return ResultModel(
  //       status: ResultStatus.error,
  //       message: e.toString(),
  //     );
  //   }
  // }

  static Future<ResultModel> update(String id, Map<String, dynamic> json, {required bool toGrid}) async {
    try {
      log(id.toString());
      final collection = FirebaseFirestore.instance.collection(toGrid ? 'grid' : 'markers');
      await collection.doc(id).update(json);

      return ResultModel(
        status: ResultStatus.success,
      );
    } catch (e) {
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  static Future<ResultModel> delete(String id, {required bool toGrid}) async {
    try {
      log(id.toString());
      final collection = FirebaseFirestore.instance.collection(toGrid ? 'grid' : 'markers');
      await collection.doc(id).delete();

      return ResultModel(
        status: ResultStatus.success,
      );
    } catch (e) {
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  @override
  String toString() {
    return '''
      MarkerModel{
        id: $id, 
        name: $name, 
        concertId: $concertId, 
        x: $x,
        y: $y,
        color: $color,
        price: $price,
        createdAt: $createdAt,
        type: $type,
      }
      ''';
  }
}
