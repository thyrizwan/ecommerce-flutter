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
      '$_baseUrl/products/id/67c7c31a623a876bc4767038}';
}
