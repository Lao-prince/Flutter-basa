import 'package:flutter/material.dart';
import 'menu_item.dart';

class CartManager extends ChangeNotifier {
  final List<MenuItem> _items = [];

  List<MenuItem> get items => _items;

  void addItem(MenuItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(MenuItem item) {
    _items.remove(item);
    notifyListeners();
  }

  int get itemCount => _items.length;

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);
}
