import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final CollectionReference productLog =
      FirebaseFirestore.instance.collection('favorite foods');

  Future<void> addCart(
      // adding using add() function
      {required String productName,
      required double productPrice}) {
    return productLog.add({
      'food_name': productName,
      'cook_name': productPrice,
    });
  }

  // Read all documents
  Stream<QuerySnapshot> getCart() {
    return productLog.snapshots();
  }

  // Update a document
  Future<void> updateCart(
      {required String productName, required Map<String, dynamic> updatedData}) {
    return productLog.doc(productName.toLowerCase()).update(updatedData);
  }

  // Delete a document
  Future<void> deleteCart({required String productName}) {
    return productLog.doc(productName).delete();
  }
}