import 'package:flutter/material.dart';
import 'product.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems;

  CartPage(this.cartItems);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double getTotalAmount() {
    double total = 0.0;
    for (Product product in widget.cartItems) {
      // Remove the currency symbol and any non-digit characters
      String priceWithoutCurrency = product.price.replaceAll(RegExp(r'[^\d.]'), '');
      total += double.parse(priceWithoutCurrency);
    }
    return total;
  }

  void removeItem(Product product) {
    setState(() {
      widget.cartItems.remove(product);
    });
  }

  void proceedToCheckout() {
    if (widget.cartItems.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('The cart is empty. Add items to proceed.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutPage(widget.cartItems.cast<Product>()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${widget.cartItems.length} items)'),
      ),
      body: widget.cartItems.isEmpty
          ? Center(
              child: Text('Your cart is empty.'),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final product = widget.cartItems[index];

                return Dismissible(
                  key: Key(product.name),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    removeItem(product);
                  },
                  child: ListTile(
                    leading: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                      width: 60.0,
                      height: 60.0,
                    ),
                    title: Text(product.name),
                    subtitle: Text('\ ${product.price} EGP'),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total Amount: \ ${getTotalAmount()} EGP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                proceedToCheckout();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Proceed to Checkout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}