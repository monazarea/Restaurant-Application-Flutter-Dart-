import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/bottom_nav_bar.dart';
import 'package:test1/cart_provider.dart';

import 'custom_scaffold.dart';
class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  void incrementQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void decrementQuantity(CartItem item) {
    setState(() {
      if (item.quantity > 0) {
        item.quantity--;
      }
    });
  }
  double getCartTotal() {
    double total = 0.0;
    List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
    for (CartItem item in cartItems) {
      total += item.quantity * item.price;
    }
    return total;
  }

  void showCheckoutDialog(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Checkout'),
            content: Text('Hurray! You have purchased the products'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('OK',style: TextStyle(color: Color.fromARGB(255, 234, 167, 102)),))
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
    return CustomScaffold(
      body: SafeArea(
          child:
          Padding(
            padding:EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CART',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                Expanded(child: ListView.builder(
                  itemCount: cartItems.length,
                    itemBuilder:((context,index){
                      CartItem item = cartItems[index];
                      return Dismissible(
                        key: Key(item.name),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            Provider.of<CartProvider>(context, listen: false).removeFromCart(item);
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          child: Icon(Icons.cancel,color: Colors.white,),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 16.0),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.only(right:16.0 ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                item.image,
                                height: 50,
                                width: 50,),
                              SizedBox(width: 15.0,),
                              Column(
                                children: [
                                  Text(
                                     //productNames[index],
                                    item.name,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  Text(
                                    //'\$${price[index]}'
                                    '\$${item.price}',
                                    style: TextStyle(fontSize: 16,color: Colors.grey),)
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: (){decrementQuantity(item);;},
                                      icon: Icon(Icons.remove),
                                  ),
                                  Text(item.quantity.toString()),
                                  IconButton(
                                      onPressed: (){incrementQuantity(item);},
                                      icon:Icon(Icons.add)),
                        
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    })
                )),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'Cart Toal',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(width: 50.0,),
                      Text(
                        '\$${getCartTotal().toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),

                      )
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(child: ElevatedButton(
                          onPressed: (){showCheckoutDialog();},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          child:Text('Proceed to Checkout',style: TextStyle(color: Colors.white),)))
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
      showBottomNavBar: true,
      initialIndex: 3,
    );
  }
}
