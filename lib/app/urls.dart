class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static String loginUrl = '$_baseUrl/auth/login';
  static String signUpUrl = '$_baseUrl/auth/signup';
  static String verifyOtpUrl = '$_baseUrl/auth/verify-otp';

  static String getProfileInfoUrl = '$_baseUrl/auth/profile';

  static String getHomeBannerListUrl = '$_baseUrl/slides';
}
