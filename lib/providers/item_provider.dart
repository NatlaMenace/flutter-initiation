import 'package:flutter/material.dart';
import 'package:initiation_project/models/item.dart';
import 'package:initiation_project/services/firebase_service.dart';

class ItemProvider with ChangeNotifier {
  final List<Item> _itemsShop = [
    Item(name: 'MacBook', price: 999.99, category: 'Electronics'),
    Item(name: 'T-Shirt', price: 19.99, category: 'Clothing'),
    Item(name: 'Apple', price: 0.99, category: 'Groceries'),
    Item(name: 'Sofa', price: 499.99, category: 'Home'),
    Item(name: 'Football', price: 29.99, category: 'Sports'),
    Item(name: 'Novel', price: 14.99, category: 'Books'),
  ];

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

  void addItem(Item item) {
    FirebaseService().addDocument('Item', item.toMap());
    _itemsShop.add(item);
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
