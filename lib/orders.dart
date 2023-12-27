import 'package:flutter/material.dart';
import 'product.dart';

class OrdersPage extends StatelessWidget {
  final List<Product> orders; // List to store the submitted orders

  OrdersPage(this.orders); // Constructor to receive the orders

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      // Show a message when there are no orders
      return Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
        ),
        body: Center(
          child: Text('You don\'t have any orders yet.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final product = orders[index];
          return ListTile(
            leading: Image.asset(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Text(product.price),
          );
        },
      ),
    );
  }
}