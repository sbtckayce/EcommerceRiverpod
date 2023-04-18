import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/models.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider((ref) =>
    HomeRepository(firebaseFirestore: ref.watch(firebaseFirestoreProvider)));

class HomeRepository {
  final FirebaseFirestore _firebaseFirestore;

  HomeRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  Future<List<CategoryModel>> getCategoriesList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection('categories').get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromMap(e.data()))
          .toList();
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getProductsList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup('products').get();
      List<ProductModel> productsList = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();

      return productsList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getProductsFromCategory(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('categories')
              .doc(id)
              .collection('products')
              .get();

      List<ProductModel> productList = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      return productList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getProductsListSearch(String text) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup('products').get();
      List<ProductModel> productsList = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();

      if (text=='') {
        return productsList;
      } else {
        return productsList
            .where((element) =>
                element.name.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
}
