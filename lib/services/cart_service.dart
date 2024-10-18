import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final CollectionReference referenceProductLog =
      FirebaseFirestore.instance.collection('favorite foods');

  Future<void> addCart(
      // adding using add() function
      {required String productName,
      required double productPrice}) {
    return referenceProductLog.add({
      'product_name': productName,
      'product_price': productPrice,
    });
  }

  // Read all documents
  Stream<QuerySnapshot> getCart() {
    return referenceProductLog.snapshots();
  }

  // Update a document
  Future<void> updateCart(
      {required String productName,
      required Map<String, dynamic> updatedData}) {
    return referenceProductLog
        .doc(productName.toLowerCase())
        .update(updatedData);
  }

  // Delete a document
  Future<void> deleteCart({required String productName}) {
    return referenceProductLog.doc(productName).delete();
  }
}
