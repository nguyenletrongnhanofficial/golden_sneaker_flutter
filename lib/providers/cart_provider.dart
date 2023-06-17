import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/models/hives/cart.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> _carts = [];

  List<Cart> get carts => _carts;

  bool isExist = false;

  getAllShoeInCart() async {
    var box = await Hive.openBox<Cart>('cartBox');
    _carts = box.values.toList();
    notifyListeners();
  }

  Future<void> addShoeInCart(Cart cart) async {
    var box = await Hive.openBox<Cart>('cartBox');
    box.add(cart);
    notifyListeners();
  }

  Future<void> removeShoeInCart(int index) async {
    var box = await Hive.openBox<Cart>('cartBox');
    box.deleteAt(index);
    notifyListeners();
  }

  Future<void> updateShoeInCart(Cart cart, int index) async {
    var box = await Hive.openBox<Cart>('cartBox');
    box.putAt(index, cart);
    notifyListeners();
  }

  Future<void> checkProduct(int id) async {
    await getAllShoeInCart();
    isExist = _carts.where((element) => element.id == id).isNotEmpty;
  }
}
