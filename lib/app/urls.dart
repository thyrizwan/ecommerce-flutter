class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static String loginUrl = '$_baseUrl/auth/login';
  static String signUpUrl = '$_baseUrl/auth/signup';
  static String verifyOtpUrl = '$_baseUrl/auth/verify-otp';

  static String getProfileInfoUrl = '$_baseUrl/auth/profile';

  static String getHomeBannerListUrl = '$_baseUrl/slides';
  static String getCategoryListUrl = '$_baseUrl/categories';

  static String getProductListUrl = '$_baseUrl/products';
  static String getProductListByCategoryUrl(String categoryId) => '$_baseUrl/products?category=$categoryId';

  static String getSingleProductInfoUrl(String productId) =>
      '$_baseUrl/products/id/$productId';

  static String addToCartUrl = '$_baseUrl/cart';
  static String deleteFromCartUrl(String productId) => '$_baseUrl/cart/$productId';
  static String getCartedProductUrl = '$_baseUrl/cart';
  static String addToWishListUrl = '$_baseUrl/wishlist';
  static String getWishListProductListUrl = '$_baseUrl/wishlist';
  static String getReviewListUrl(String productId) => '$_baseUrl/reviews?product=$productId';
  static String createReviewUrl = '$_baseUrl/review';

}
