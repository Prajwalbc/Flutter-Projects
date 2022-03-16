import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  //String here is productId
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return num.parse(total.toStringAsFixed(2));
  }

  void addItem(String productId, String title, double price) {
    _items.update(
      productId,
      (existingCI) => CartItem(
        id: existingCI.id,
        title: existingCI.title,
        price: existingCI.price,
        quantity: existingCI.quantity + 1,
      ),
      ifAbsent: () => CartItem(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeOne(String productId, String title, double price) {
    _items.update(
      productId,
      (existingCI) => CartItem(
        id: existingCI.id,
        title: existingCI.title,
        price: existingCI.price,
        quantity: existingCI.quantity - 1,
      ),
    );
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
