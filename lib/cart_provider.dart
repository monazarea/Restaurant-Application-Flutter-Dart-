import 'package:flutter/material.dart';

class CartItem{
  String name;
  double price;
  int quantity;
  String image;
  CartItem({required this.name,required this.price,required this.quantity,required this.image});
}
class CartProvider with ChangeNotifier{
  List<CartItem>cartItems = [];

  void addToCart(CartItem item){
    cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    notifyListeners();
  }

}
