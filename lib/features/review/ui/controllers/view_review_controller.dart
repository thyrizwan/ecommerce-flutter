import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/review/data/models/view_review_response_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class ViewReviewController extends GetxController {
  bool _inProgress = false;

  bool get isInProgress => _inProgress;

  ViewReviewResponseModel? _viewReviewResponseModel;

  List<ReviewModel> get reviewList =>
      _viewReviewResponseModel?.data?.reviews ?? [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getReviewList(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.getReviewListUrl(productId), isAuth: true);

    if (response.isSuccess) {
      _viewReviewResponseModel =
          ViewReviewResponseModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
