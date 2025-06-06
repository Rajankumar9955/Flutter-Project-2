class CategoriesModel {
  int? id;
  int? parentId;
  String? categoryName;
  String? categoryImage;
  int? categoryDiscount;
  String? description;
  String? url;
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? parentcategory;

  CategoriesModel(
      {this.id,
      this.parentId,
      this.categoryName,
      this.categoryImage,
      this.categoryDiscount,
      this.description,
      this.url,
      this.metaTitle,
      this.metaDescription,
      this.metaKeywords,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.parentcategory});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryDiscount = json['category_discount'];
    description = json['description'];
    url = json['url'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parentcategory = json['parentcategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    data['category_discount'] = this.categoryDiscount;
    data['description'] = this.description;
    data['url'] = this.url;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['parentcategory'] = this.parentcategory;
    return data;
  }
}
