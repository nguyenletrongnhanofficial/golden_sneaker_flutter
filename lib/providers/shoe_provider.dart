import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import '/models/hives/shoe.dart';
import 'package:dio/dio.dart';
import '/configs/config.dart';

class ShoeProvider extends ChangeNotifier {
  List<Shoe> _shoes = [];

  List<Shoe> get shoes => _shoes;
  Future<void> getAllProductsServerandSaveLocal() async {
    var box = await Hive.openBox<Shoe>('shoeBox');

    if (box.isEmpty) {
      try {
        final dio = Dio();
        final response =
            await dio.get(baseUrl).timeout(const Duration(microseconds: 50));
        var list = response.data as List<dynamic>;
        List<Shoe> data = list.map((e) => Shoe.fromJson(e)).toList();
        for (int i = 0; i < data.length; i++) {
          await box.add(data[i]);
        }
      } catch (e) {
        //s##When onrender.com is set to save but not active,
        //it will require some time to start running.
        //Therefore, if data cannot be retrieved within 50 microseconds,
        //I will fetch the available data instead!
        String jsonString =
            await rootBundle.loadString('assets/data/data_when_offline.json');
        List<dynamic> jsonData = jsonDecode(jsonString);
        List<Shoe> data = jsonData.map((e) => Shoe.fromJson(e)).toList();

        for (int i = 0; i < data.length; i++) {
          await box.add(data[i]);
        }
      }
    }
    await getAllShoesLocal();
    notifyListeners();
  }

  Future<void> updateShoeLocal(Shoe shoe, int index) async {
    var box = await Hive.openBox<Shoe>('shoeBox');
    box.putAt(index, shoe);
    notifyListeners();
  }

  getAllShoesLocal() async {
    var box = await Hive.openBox<Shoe>('shoeBox');
    _shoes = box.values.toList();
    notifyListeners();
  }
}
