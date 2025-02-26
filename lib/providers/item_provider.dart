import 'dart:async';

import 'package:flutter/material.dart';
import 'package:initiation_project/models/item.dart';
import 'package:initiation_project/services/firebase_service.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _itemsShop = [];

  final List<Item> _itemsCart = [];

  IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Electronics':
        return Icons.devices;
      case 'Clothing':
        return Icons.checkroom;
      case 'Groceries':
        return Icons.local_grocery_store;
      case 'Home':
        return Icons.home;
      case 'Sports':
        return Icons.sports_soccer;
      case 'Books':
        return Icons.menu_book_rounded;
      default:
        return Icons.category;
    }
  }

  List<Item> get itemsShop => _itemsShop;

  List<Item> get itemsCart => _itemsCart;

  // ignore: unused_field
  StreamSubscription? _itemsSubscription;

  List<String> getCategories() {
    return [
      'Electronics',
      'Clothing',
      'Groceries',
      'Home',
      'Sports',
      'Books',
      'Other'
    ];
  }

  ItemProvider() {
    _listenToItems();
  }

  void _listenToItems() {
    _itemsSubscription =
        FirebaseService().listenToCollection('Item').listen((snapshot) {
      _itemsShop =
          snapshot.docs.map((doc) => Item.fromMap(doc.data())).toList();
      notifyListeners();
    });
  }

  void addItemToShop(Item item) {
    FirebaseService().addDocument('Item', item.toMap());
    notifyListeners();
  }

  void removeItemFromShop(Item item) {
    FirebaseService().deleteDocument('Item', item.name);
    notifyListeners();
  }

  Future<void> fetchItemsShop() async {
    final data = await FirebaseService().getDocuments('Item');
    _itemsShop = data.map((item) => Item.fromMap(item)).toList();
    notifyListeners();
  }

  void addItemToCart(Item item) {
    _itemsCart.add(item);
    notifyListeners();
  }

  void removeItemFromCart(Item item) {
    _itemsCart.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _itemsCart.clear();
    notifyListeners();
  }
}
