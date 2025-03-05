class WishListProductResponseModel {
  final int code;
  final String status;
  final String msg;
  final WishListProductData wishListProductData;

  WishListProductResponseModel({
    required this.code,
    required this.status,
    required this.msg,
    required this.wishListProductData,
  });

  factory WishListProductResponseModel.fromJson(Map<String, dynamic> json) {
    return WishListProductResponseModel(
      code: json['code'] ?? 0,
      status: json['status'] ?? '',
      msg: json['msg'] ?? '',
      wishListProductData: WishListProductData.fromJson(json['data'] ?? {}),
    );
  }
}

class WishListProductData {
  final List<WishListProductResult> wishListProductResult;
  final int total;
  final String? firstPage;
  final String? previous;
  final String? next;
  final String? lastPage;

  WishListProductData({
    required this.wishListProductResult,
    required this.total,
    this.firstPage,
    this.previous,
    this.next,
    this.lastPage,
  });

  factory WishListProductData.fromJson(Map<String, dynamic> json) {
    return WishListProductData(
      wishListProductResult: (json['results'] as List?)
              ?.map((item) => WishListProductResult.fromJson(item))
              .toList() ??
          [],
      total: json['total'] ?? 0,
      firstPage: json['first_page'],
      previous: json['previous'],
      next: json['next'],
      lastPage: json['last_page'],
    );
  }
}

class WishListProductResult {
  final String id;
  final WishListProductFinalList wishListProductFinalList;
  final String user;
  final String createdAt;
  final String updatedAt;

  WishListProductResult({
    required this.id,
    required this.wishListProductFinalList,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WishListProductResult.fromJson(Map<String, dynamic> json) {
    return WishListProductResult(
      id: json['_id'] ?? '',
      wishListProductFinalList:
          WishListProductFinalList.fromJson(json['product'] ?? {}),
      user: json['user'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class WishListProductFinalList {
  final String id;
  final String title;
  final String brand;
  final List<String> categories;
  final String slug;
  final String? metaDescription;
  final String description;
  final List<String> photos;
  final List<String> colors;
  final List<String> sizes;
  final List<String> tags;
  final int? regularPrice;
  final int currentPrice;
  final int quantity;
  final String createdAt;
  final String updatedAt;

  WishListProductFinalList({
    required this.id,
    required this.title,
    required this.brand,
    required this.categories,
    required this.slug,
    this.metaDescription,
    required this.description,
    required this.photos,
    required this.colors,
    required this.sizes,
    required this.tags,
    this.regularPrice,
    required this.currentPrice,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WishListProductFinalList.fromJson(Map<String, dynamic> json) {
    return WishListProductFinalList(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      categories:
          (json['categories'] as List?)?.map((e) => e.toString()).toList() ??
              [],
      slug: json['slug'] ?? '',
      metaDescription: json['meta_description'],
      description: json['description'] ?? '',
      photos:
          (json['photos'] as List?)?.map((e) => e.toString()).toList() ?? [],
      colors:
          (json['colors'] as List?)?.map((e) => e.toString()).toList() ?? [],
      sizes: (json['sizes'] as List?)?.map((e) => e.toString()).toList() ?? [],
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      regularPrice: json['regular_price'] as int?,
      currentPrice: json['current_price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
