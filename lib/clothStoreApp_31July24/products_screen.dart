import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class ProductsScreen extends StatelessWidget {
  final String category;

  ProductsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    List<ProductItem> products = [];

    if (category == "Men's Wear") {
      products = [
        ProductItem(name: 'Shirt', image: 'assets/images/image0.jpg', price: 19.99),
        ProductItem(name: 'Jeans', image: 'assets/images/image1.jpg', price: 29.99),
        ProductItem(name: 'Suit', image: 'assets/images/image2.jpg', price: 39.99),
      ];
    } else if (category == "Women's Wear") {
      products = [
        ProductItem(name: 'Shirt', image: 'assets/images/image3.jpg', price: 19.99),
        ProductItem(name: 'Jeans', image: 'assets/images/image4.jpg', price: 29.99),
        ProductItem(name: 'Suit', image: 'assets/images/image5.jpg', price: 39.99),
      ];
    } else if (category == "Kid's Wear") {
      products = [
        ProductItem(name: 'Shirt', image: 'assets/images/image5.jpg', price: 19.99),
        ProductItem(name: 'Jeans', image: 'assets/images/image6.jpg', price: 29.99),
        ProductItem(name: 'Suit', image: 'assets/images/image8.jpg', price: 39.99),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView(
        children: products,
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String image;
  final double price;

  ProductItem({required this.name, required this.image, required this.price});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(image),
        radius: 25,
      ),
      title: Text(name),
      subtitle: Text('\$${price.toStringAsFixed(2)}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              name: name,
              image: image,
              price: price,
            ),
          ),
        );
      },
    );
  }
}