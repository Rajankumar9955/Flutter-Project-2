class WishlistModel {
  int? id;
  int? categoryId;
  int? brandId;
  String? productName;
  String? productCode;
  String? productColor;
  String? familyColor;
  String? groupCode;
  int? productPrice;
  String? productWeight;
  int? productDiscount;
  String? discountType;
  int? finalPrice;
  String? productVideo;
  String? description;
  String? washCare;
  String? keywords;
  String? fabric;
  String? pattern;
  String? sleeve;
  String? fit;
  String? occassion;
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  String? isFeatured;
  int? status;
  String? createdAt;
  String? updatedAt;
  Category? category;
  List<Images>? images;

  WishlistModel(
      {this.id,
      this.categoryId,
      this.brandId,
      this.productName,
      this.productCode,
      this.productColor,
      this.familyColor,
      this.groupCode,
      this.productPrice,
      this.productWeight,
      this.productDiscount,
      this.discountType,
      this.finalPrice,
      this.productVideo,
      this.description,
      this.washCare,
      this.keywords,
      this.fabric,
      this.pattern,
      this.sleeve,
      this.fit,
      this.occassion,
      this.metaTitle,
      this.metaDescription,
      this.metaKeywords,
      this.isFeatured,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.images});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    productName = json['product_name'];
    productCode = json['product_code'];
    productColor = json['product_color'];
    familyColor = json['family_color'];
    groupCode = json['group_code'];
    productPrice = json['product_price'];
    productWeight = json['product_weight'];
    productDiscount = json['product_discount'];
    discountType = json['discount_type'];
    finalPrice = json['final_price'];
    productVideo = json['product_video'];
    description = json['description'];
    washCare = json['wash_care'];
    keywords = json['keywords'];
    fabric = json['fabric'];
    pattern = json['pattern'];
    sleeve = json['sleeve'];
    fit = json['fit'];
    occassion = json['occassion'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    isFeatured = json['is_featured'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['product_color'] = this.productColor;
    data['family_color'] = this.familyColor;
    data['group_code'] = this.groupCode;
    data['product_price'] = this.productPrice;
    data['product_weight'] = this.productWeight;
    data['product_discount'] = this.productDiscount;
    data['discount_type'] = this.discountType;
    data['final_price'] = this.finalPrice;
    data['product_video'] = this.productVideo;
    data['description'] = this.description;
    data['wash_care'] = this.washCare;
    data['keywords'] = this.keywords;
    data['fabric'] = this.fabric;
    data['pattern'] = this.pattern;
    data['sleeve'] = this.sleeve;
    data['fit'] = this.fit;
    data['occassion'] = this.occassion;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['is_featured'] = this.isFeatured;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
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
  Parentcategory? parentcategory;

  Category(
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

  Category.fromJson(Map<String, dynamic> json) {
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
    parentcategory = json['parentcategory'] != null
        ? new Parentcategory.fromJson(json['parentcategory'])
        : null;
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
    if (this.parentcategory != null) {
      data['parentcategory'] = this.parentcategory!.toJson();
    }
    return data;
  }
}

class Parentcategory {
  int? id;
  String? categoryName;
  String? url;

  Parentcategory({this.id, this.categoryName, this.url});

  Parentcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['url'] = this.url;
    return data;
  }
}

class Images {
  int? id;
  int? productId;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? fullUrl;

  Images(
      {this.id,
      this.productId,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.fullUrl});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullUrl = json['full_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_url'] = this.fullUrl;
    return data;
  }
}