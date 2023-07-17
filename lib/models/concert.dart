import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'result.dart';

class ConcertModel {
  final String id;
  final String name;
  final String place;
  final DateTime? createdAt;
  final String? row;
  final String? column;
  final List? grid;
  final List? prices;

  ConcertModel({
    required this.id,
    required this.name,
    required this.place,
    required this.createdAt,
    required this.row,
    required this.column,
    required this.grid,
    required this.prices,
  });

  static Future<ResultModel> save(Map<String, dynamic> json) async {
    try {
      final collection = FirebaseFirestore.instance.collection('concerts');

      await collection.doc().set(json);

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

  static Future<ResultModel?> getAll() async {
    try {
      final db = FirebaseFirestore.instance;
      Query<Map<String, dynamic>>? data;
      List<ConcertModel> allResults = [];
      data = db.collection("concerts").limit(100).orderBy('createdAt');

      var documentSnapshots = await data.get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in documentSnapshots.docs) {
        ResultModel result = await ConcertModel.fromFirestore(element, SnapshotOptions());
        if (result.status == ResultStatus.success && result.data != null) {
          try {
            allResults.add(result.data as ConcertModel);
            // log((result.data as ConcertModel).toString(), name: 'ppp');
            // log(allResults.toString(), name: 'allResults');
          } catch (e) {
            log(e.toString(), name: '11551132');
          }
        } else {
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

  static Future<ResultModel> get() async {
    try {
      ResultModel? result;
      final db = FirebaseFirestore.instance;
      DocumentReference<Map<String, dynamic>> data;

      data = db.collection("concerts").doc('EGCMwS1dZDlpo2QN1GLc');

      data.get().then(
        (documentSnapshots) async {
          result = await ConcertModel.fromFirestore(documentSnapshots, SnapshotOptions());

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

  static Future<ResultModel> fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) async {
    try {
      final data = snapshot.data();
      log(data.toString());
      return ResultModel(
        status: ResultStatus.success,
        data: ConcertModel(
          // id: data?['id'] ?? '??',
          id: snapshot.id,
          name: data?['name'] ?? '??',
          place: data?['place'] ?? '??',
          createdAt: DateTime.tryParse((data?['createdAt'] ?? '')),
          row: data?['row'].toString(),
          column: data?['column'].toString(),
          grid: data?['grid'],
          prices: data?['prices'],
        ),
      );
    } catch (e) {
      log(e.toString());
      return ResultModel(
        status: ResultStatus.error,
        message: e.toString(),
      );
    }
  }

  static Future<ResultModel> update(String id, Map<String, dynamic> json) async {
    try {
      log(id.toString());
      final collection = FirebaseFirestore.instance.collection('concerts');
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

  static Future<ResultModel> delete(String id) async {
    try {
      log(id.toString());
      final collection = FirebaseFirestore.instance.collection('concerts');
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
      ConcertModel{
        id: $id, 
        name: $name, 
        place: $place,
        createdAt: $createdAt,
        row: $row,
        column: $column,
      }
      ''';
  }
}
