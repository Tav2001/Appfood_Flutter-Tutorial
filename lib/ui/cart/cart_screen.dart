
import 'package:flutter/material.dart';
import 'package:app_food/ui/orders/orders_screen.dart';
import 'package:provider/provider.dart';

import '../orders/order_manager.dart';
import '../products/top_right_badge.dart';
import 'cart_manager.dart';
import 'cart_item_card.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: <Widget>[
          buildOrder(context),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 255, 237, 205),
      body: Column(
        children: <Widget>[

          const SizedBox(height: 10),
          Expanded(child: buildCartDetails(cart)),
          buildCartSummary(cart, context)
        ]),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
        .map(
          (entry) => CartItemCard(
            productId: entry.key, 
            cardItem: entry.value,
          ),
        )
        .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Total:',
              style: TextStyle(
                  fontSize: 20,
              ),
            ),

            Chip(
              label: Text(
                '\$${cart.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.headline6?.color,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(10),
            ),
            const Spacer(),
            TextButton(
              
              onPressed: cart.totalAmount <= 0
              ? null
              : () {
                context.read<OrdersManager>().addOrder(
                  cart.products,
                  cart.totalAmount,
                );
                cart.clear();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(4),
                shape: 
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                backgroundColor: Color.fromARGB(255, 40, 231, 44),
              ),
              child: const Text(
                  'ORDER NOW',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0,
                  color: Colors.black,
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrder(context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(4),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromARGB(255, 40, 231, 44),

          ),
          child: const Text(
            'ORDERS',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15.0,
              color: Colors.black,

            ),
          ),

      ),
    );
  }
}
