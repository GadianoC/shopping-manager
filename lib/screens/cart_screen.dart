import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple/models/product.dart';
import 'package:simple/services/cart_service.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartService productLog = CartService();
  final TextEditingController _textEditingControllerProductName =
      TextEditingController();
  final TextEditingController _textEditingControllerProductPrice =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    void onSubmit() {
      productLog.addCart(
        productName: _textEditingControllerProductName.text,
        productPrice: double.parse(_textEditingControllerProductPrice.text),
      );
      _textEditingControllerProductName.clear();
      _textEditingControllerProductPrice.clear();
      Navigator.pop(context);
    }

    final InputDecoration _inputDecoration = const InputDecoration(
      border: OutlineInputBorder(),
    );

    void dialogBox() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Product'),
            icon: Icon(
              Icons.shopping_cart,
              size: 50,
            ),
            content: SizedBox(
              height: screenH * .150,
              width: screenW * .001,
              child: Column(
                children: [
                  submitProductName(onSubmit, _inputDecoration),
                  const SizedBox(
                    height: 15,
                  ),
                  submitProductPrice(onSubmit, _inputDecoration),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                child: const Icon(Icons.send),
                onPressed: () => onSubmit(),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      floatingActionButton: showDialogBoxButton(dialogBox),
      body: StreamBuilder(
        stream: productLog.getCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const RefreshProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Product in List'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              String productName = document['product_name'];
              double productPrice = document['product_price'];

              return Product(
                productName: productName,
                productPrice: productPrice,
              );
            },
          );
        },
      ),
    );
  }

  FloatingActionButton showDialogBoxButton(void dialogBox()) {
    return FloatingActionButton(
      onPressed: () => dialogBox(),
      child: const Icon(Icons.add),
    );
  }

  TextField submitProductPrice(
      void onSubmit(), InputDecoration _inputDecoration) {
    return TextField(
      controller: _textEditingControllerProductPrice,
      onSubmitted: (_) => onSubmit(),
      decoration: _inputDecoration.copyWith(hintText: 'Product Price'),
    );
  }

  TextField submitProductName(
      void onSubmit(), InputDecoration _inputDecoration) {
    return TextField(
      controller: _textEditingControllerProductName,
      onSubmitted: (_) => onSubmit(),
      decoration: _inputDecoration.copyWith(hintText: 'Product Name'),
    );
  }
}
