import 'package:flutter/material.dart';
import 'package:online_store/profile.dart';
import 'cart.dart';
import 'product.dart';
import 'orders.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [
    Product('Apple Watch Series 7', '14999 EGP', 'images/applewatch.jpeg'),
    Product('MacBook 2017 Apple design', '35000 EGP', 'images/macbook.jpg'),
    Product('Apple iPhone 13 Pro Max', '38000 EGP', 'images/iphone13.jpeg'),
    Product('Modern Hoodie unisex', '750LE', 'images/hoodie.jpg'),
    Product('Apple Airpods Pro', '6799 EGP', 'images/airpods.jpg'),
    Product('Sunglasses for girls', '600 EGP', 'images/sunglasses1.webp'),
    Product('Sunglasses for girls', '650 EGP', 'images/sunglasses2.webp'),
    Product('Sunglasses for Men', '599 EGP', 'images/sunglasses3.webp'),
    Product('Modern Hoodie for Men', '1200 EGP', 'images/hoodie2.jpeg'),
    Product('AirJordan Midnight color', '2400 EGP', 'images/airjordan.jpg'),
  ];

  List<Product> cartItems = [];

  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item added to cart'),
          duration: Duration(seconds: 1),
        ),
      );
    });
  }

  double getTotalAmount() {
    double total = 0.0;
    for (Product product in cartItems) {
      try {
        total += double.parse(product.price.split(' ')[0]);
      } catch (e) {
        print('Error parsing price for product: ${product.name}');
      }
    }
    return total;
  }

  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool showSearchBar = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Express Store',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                showSearchBar = !showSearchBar;
                searchQuery = '';
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrdersPage(cartItems),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          title: Text('Accessories'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Watches'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Shoes'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Pants'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(cartItems),
                    ),
                  );
                },
              ),
              cartItems.isNotEmpty
                  ? Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cartItems.length.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (showSearchBar)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                if (searchQuery.isNotEmpty &&
                    !product.name
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase())) {
                  return SizedBox.shrink();
                }
                return GestureDetector(
                  onTap: () {
                    addToCart(product);
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            product.price,
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            addToCart(product);
                          },
                          child: Text('Add to Cart'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
