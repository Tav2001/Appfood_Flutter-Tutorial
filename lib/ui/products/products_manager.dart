import 'package:flutter/foundation.dart';

import '../../models/auth_token.dart';
import '../../models/products.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _items = [];

  final ProductsService _productsService;

  ProductsManager([AuthToken? authToken])
      : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _productsService.fetchProducts(filterByUser);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Product? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _productsService.deleteProduct(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Product product) async {
    final savedStatus = product.isFavorite;
    product.isFavorite = !savedStatus;

    if (!await _productsService.saveFavoriteStatus(product)) {
      product.isFavorite = savedStatus;
    }
  }

  // final List<Product> _items = [
  //   Product(
  //     id: 'p1',
  //     title: 'Pizza',
  //     description: 'The combination of vegetables and mushrooms makes a perfect dish!',
  //     price: 109.99,
  //     imageUrl: 'https://yt.cdnxbvn.com/medias/uploads/143/143142-cach-lam-pizza.jpg',
  //     // isFavorite: true,
  //   ),
  //   Product(
  //     id: 'p2',
  //     title: 'Fried Chicken',
  //     description: 'Fresh chicken is breaded and fried in hot oil to create a crispy crust!',
  //     price: 49.99,
  //     imageUrl: 'https://image-us.eva.vn/upload/2-2019/images/2019-05-24/ga-ran-ngon-gion-rum-voi-cach-lam-sieu-don-gian-tai-nha-ga-ran-5-1558681921-279-width489height499.jpg',
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'French fries',
  //     description: 'Feeling crispy from the first bite!',
  //     price: 19.99,
  //     imageUrl: 'https://img.meta.com.vn/Data/image/2020/03/04/cach-lam-khoai-tay-chien-bang-noi-chien-khong-dau-3.jpg',
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'Hot Dog',
  //     description: 'Sausage made from fresh meat and deep-fried with breadcrumbs!',
  //     price: 49.99,
  //     imageUrl: 'https://img-global.cpcdn.com/recipes/fde9700a3668555d/680x482cq70/hotdog-xuc-xich-phomai-han-qu%E1%BB%91c-sieu-to-kh%E1%BB%95ng-l%E1%BB%93-recipe-main-photo.jpg',
  //     isFavorite: true,
  //   ),
  //   Product(
  //     id: 'p7',
  //     title: 'Hamburger',
  //     description: 'Smoked meat and vegetables. It is the perfect combination that makes a great dish!',
  //     price: 59.99,
  //     imageUrl: 'https://afamilycdn.com/150157425591193600/2020/12/5/xac-5-mon-an-nhanh-duoc-ua-chuong-nhat-the-gioif413cea463-16071362188141792796206.jpg',
  //     isFavorite: true,
  //   ),
  //   Product(
  //     id: 'p8',
  //     title: 'Gimbap',
  //     description: 'White rice with sausage and vegetables wrapped in seaweed leaves!',
  //     price: 79.99,
  //     imageUrl: 'https://cdn.tgdd.vn/2020/11/CookProduct/gimpapne%CC%80-1200x676.jpg',
  //     isFavorite: true,
  //   ),
  // ];

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
