import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddToWishListController extends GetxController {
    bool _inProgress = false;
  bool get isInProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addToMyWishList(Map<String, dynamic> body) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
    await Get.find<NetworkCaller>().postRequest(Urls.addToWishListUrl, body);

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}