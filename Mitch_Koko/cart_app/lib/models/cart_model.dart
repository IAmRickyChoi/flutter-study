import 'package:flutter/material.dart';
import 'package:cart_app/images.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    ["burger", "4.00", ImagesAssets.burger, Colors.orange],
    ["chicken", "4.00", ImagesAssets.chicken, Colors.yellow],
    ["bentow", "4.00", ImagesAssets.bentow, Colors.brown],
    ["berries", "4.00", ImagesAssets.berries, Colors.red],
  ];

  List _cartItems = [];

  get shopItems => _shopItems;
  get cartItems => _cartItems;

  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }

    return totalPrice.toStringAsFixed(2);
  }
}
