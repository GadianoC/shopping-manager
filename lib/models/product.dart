import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String productName;
  final double productPrice;

  const Product({
    super.key,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                productName.toUpperCase(),
              ),
              subtitle: Text('Price: $productPrice'),
            ),
          ),
        ],
      ),
    );
  }
}
