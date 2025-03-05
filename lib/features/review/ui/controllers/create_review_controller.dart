import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/review/data/models/view_review_response_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class CreateReviewController extends GetxController {
  bool _inProgress = false;

  bool get isInProgress => _inProgress;

  ViewReviewResponseModel? _viewReviewResponseModel;

  List<ReviewModel> get reviewList =>
      _viewReviewResponseModel?.data?.reviews ?? [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> createReview(Map<String, dynamic> body) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.createReviewUrl, body);

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
