class CategoryListModel {
  String? sId;
  String? title;
  String? slug;
  String? description;
  String? icon;
  Null parent;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryListModel(
      {this.sId,
      this.title,
      this.slug,
      this.description,
      this.icon,
      this.parent,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    icon = json['icon'];
    parent = json['parent'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['icon'] = icon;
    data['parent'] = parent;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
