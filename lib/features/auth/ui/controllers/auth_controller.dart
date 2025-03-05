import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/auth/model/profile_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  dynamic _tempData = '';

  dynamic get tempData => _tempData;

  ProfileModel? _profileModel;

  ProfileModel? get profileModel => _profileModel;

  bool _shouldNavigate = false;

  bool get shouldNavigate => _shouldNavigate;

  /*
   * Verify the email address of the user.
   * Returns true if the email is successfully verified, otherwise false.
   * Updates the inProgress and errorMessage properties accordingly.
   */
  Future<bool> login(body) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
        await _networkCaller.postRequest(Urls.loginUrl, body);

    if (response.isSuccess) {
      _errorMessage = null;
      await SharedPreferenceHelper.saveToken(
          response.responseData['data']['token'].toString());
      _profileModel =
          ProfileModel.fromJson(response.responseData['data']['user']);
      if (profileModel != null) {
        await SharedPreferenceHelper.saveUserData(profileModel!);
      } else {
        _profileModel = null;
      }
      isSuccess = true;
    } else {
      _tempData = null;
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  /*
   * Sign up a new user with the provided credentials.
   * Returns true if the user is successfully signed up, otherwise false.
   * Updates the inProgress and errorMessage properties accordingly.
   */
  Future<bool> signUp(body) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
        await _networkCaller.postRequest(Urls.signUpUrl, body);

    if (response.isSuccess) {
      _errorMessage = null;
      _tempData = response.responseData;
      await SharedPreferenceHelper.saveEmail(
          response.responseData['data']['email'].toString());
      isSuccess = true;
    } else {
      _tempData = null;
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  /*
   * Verify the user with the provided credentials
   * Returns true if the user is successfully verified, otherwise false.
   * Updates the inProgress and errorMessage properties accordingly.
   */
  Future<bool> verifyOtp(String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    String? email = await SharedPreferenceHelper.getEmail();
    var body = {'email': email, 'otp': otp};

    final NetworkResponse response =
        await _networkCaller.postRequest(Urls.verifyOtpUrl, body);

    if (response.isSuccess) {
      _errorMessage = null;
      _tempData = response.responseData;
      isSuccess = true;
      await SharedPreferenceHelper.saveToken(
          response.responseData['data']['token'].toString());
      await getProfile();
      if (profileModel != null) {
        await SharedPreferenceHelper.saveUserData(profileModel!);
        _shouldNavigate = true;
        await SharedPreferenceHelper.clearEmail();
      } else {
        _shouldNavigate = false;
      }
    } else {
      _tempData = null;
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  /*
   * Get Profile information
   * Returns the user's profile information.
   * Updates the inProgress and errorMessage properties accordingly.
   */

  Future<void> getProfile() async {
    _inProgress = true;
    update();

    final NetworkResponse response =
        await _networkCaller.getRequest(Urls.getProfileInfoUrl, isAuth: true);

    if (response.isSuccess) {
      _errorMessage = null;
      if (response.responseData['data'] != null) {
        _profileModel = ProfileModel.fromJson(response.responseData['data']);
      } else {
        _profileModel = null;
      }
    } else {
      _tempData = null;
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
  }
}
