import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/common/data/model/product_brand_model.dart';
import 'package:ecommerce/features/common/data/model/product_category_model.dart';
import 'package:ecommerce/features/common/data/model/product_list_model.dart';
import 'package:ecommerce/features/wishlist/data/models/wish_list_product_response_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class WishListProductController extends GetxController {
  bool _inProgress = false;
  bool get isInProgress => _inProgress;

  WishListProductResponseModel? _wishListProductListApiResponseModel;

  List<WishListProductFinalList> get productList =>
      _wishListProductListApiResponseModel
          ?.wishListProductData.wishListProductResult
          .map((result) => result.wishListProductFinalList)
          .toList() ??
      [];

  List<ProductListModel> get mappedProductList =>
      productList.map((wishlistItem) {
        return ProductListModel(
          id: wishlistItem.id,
          title: wishlistItem.title,
          brand: ProductBrandModel(
            id: wishlistItem.brand,
            title: wishlistItem.brand,
            slug: '',
            icon: '',
          ),
          categories: wishlistItem.categories
              .map(
                (cat) => ProductCategoryModel(
                    id: cat, title: cat, slug: '', icon: ''),
              )
              .toList(),
          slug: wishlistItem.slug,
          metaDescription: wishlistItem.metaDescription,
          description: wishlistItem.description,
          photos: wishlistItem.photos,
          colors: wishlistItem.colors,
          sizes: wishlistItem.sizes,
          tags: wishlistItem.tags,
          regularPrice: wishlistItem.regularPrice,
          currentPrice: wishlistItem.currentPrice,
          quantity: wishlistItem.quantity,
          createdAt: wishlistItem.createdAt,
          updatedAt: wishlistItem.updatedAt,
        );
      }).toList();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getWishListProductList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.getWishListProductListUrl, isAuth: true);

    if (response.isSuccess) {
      _wishListProductListApiResponseModel =
          WishListProductResponseModel.fromJson(response.responseData);

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
