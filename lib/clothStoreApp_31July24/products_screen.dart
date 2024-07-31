import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class ProductsScreen extends StatelessWidget {
  final String category;

  ProductsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView(
        children: [
          ProductItem(
            name: 'Item 1',
            image: 'assets/images/image0.jpg',
            price: 19.99,
          ),
          ProductItem(
            name: 'Item 2',
            image: 'assets/images/image1.jpg',
            price: 29.99,
          ),
          ProductItem(
            name: 'Item 3',
            image: 'assets/images/image2.jpg',
            price: 39.99,
          ),
        ],
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