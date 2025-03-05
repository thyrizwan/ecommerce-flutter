class ViewReviewResponseModel {
  int? code;
  String? status;
  String? message;
  ViewReviewDataModel? data;

  ViewReviewResponseModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory ViewReviewResponseModel.fromJson(Map<String, dynamic> json) {
    return ViewReviewResponseModel(
      code: json['code'],
      status: json['status'],
      message: json['msg'],
      data: json['data'] != null
          ? ViewReviewDataModel.fromJson(json['data'])
          : null,
    );
  }
}

class ViewReviewDataModel {
    List<ReviewModel>? reviews;
  int? totalReviews;
  dynamic firstPage;
  dynamic previousPage;
  int? nextPage;
  int? lastPage;

  ViewReviewDataModel({
    this.reviews,
    this.totalReviews,
    this.firstPage,
    this.previousPage,
    this.nextPage,
    this.lastPage,
  });

  factory ViewReviewDataModel.fromJson(Map<String, dynamic> json) {
    return ViewReviewDataModel(
      reviews: json['results'] != null
          ? List<ReviewModel>.from(
              json['results'].map((x) => ReviewModel.fromJson(x)))
          : null,
      totalReviews: json['total'],
      firstPage: json['first_page'],
      previousPage: json['previous'],
      nextPage: json['next'],
      lastPage: json['last_page'],
    );
  }
}

class ReviewModel {
  String? reviewId;
  ReviewProductModel? product;
  ReviewUserModel? user;
  double? rating;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;

  ReviewModel({
    this.reviewId,
    this.product,
    this.user,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['_id'],
      product: json['product'] != null
          ? ReviewProductModel.fromJson(json['product'])
          : null,
      user:
          json['user'] != null ? ReviewUserModel.fromJson(json['user']) : null,
      rating: json['rating']?.toDouble(),
      comment: json['comment'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      version: json['__v'],
    );
  }
}

class ReviewProductModel {
  String? productId;
  String? title;
  String? slug;
  List<String>? photos;

  ReviewProductModel({
    this.productId,
    this.title,
    this.slug,
    this.photos,
  });

  factory ReviewProductModel.fromJson(Map<String, dynamic> json) {
    return ReviewProductModel(
      productId: json['_id'],
      title: json['title'],
      slug: json['slug'],
      photos: json['photos'] != null ? List<String>.from(json['photos']) : null,
    );
  }
}

class ReviewUserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? avatarUrl;

  ReviewUserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.avatarUrl,
  });

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) {
    return ReviewUserModel(
      userId: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatarUrl: json['avatar_url'],
    );
  }
}
