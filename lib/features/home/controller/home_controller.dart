import 'package:e_commerce/features/home/repository/home_repository.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider = Provider(
    (ref) => HomeController(homeRepository: ref.watch(homeRepositoryProvider)));

final getCategoriesListProvider = FutureProvider<List<CategoryModel>>((ref) {
  final homeController = ref.watch(homeControllerProvider);
  return homeController.getCategoriesList();
});
final getProductsListProvider = FutureProvider<List<ProductModel>>((ref) {
  final homeController = ref.watch(homeControllerProvider);
  return homeController.getProductsList();
});
final getProductListFromCategoryProvider =
    FutureProvider.family<List<ProductModel>, String>((ref, id) {
  final homeController = ref.watch(homeControllerProvider);
  return homeController.getProductsListFromCategory(id);
});
final getProductsListSearchProvider = FutureProvider.family<List<ProductModel>,String>((ref,text) {
  final homeController = ref.watch(homeControllerProvider);
  return homeController.getProductsListSearch(text);
});

class HomeController {
  final HomeRepository _homeRepository;

  HomeController({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  Future<List<CategoryModel>> getCategoriesList() async {
    return await _homeRepository.getCategoriesList();
  }

  Future<List<ProductModel>> getProductsList() async {
    return await _homeRepository.getProductsList();
  }
  Future<List<ProductModel>> getProductsListSearch(String text) async {
    return await _homeRepository.getProductsListSearch(text);
  }

  Future<List<ProductModel>> getProductsListFromCategory(String id) async {
    return await _homeRepository.getProductsFromCategory(id);
  }
}
