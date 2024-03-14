class HomeModel{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJason(Map<String,dynamic>json){
    status=json['status'];
    data=HomeDataModel.fromJason(json['data']);
  }
 }

 class HomeDataModel{
  List<BannersData>?banners=[];
  List<ProductsData>?products=[];

  HomeDataModel.fromJason(Map<String,dynamic>json){
    json['banners'].forEach((element){
      banners!.add(BannersData.fromJason(element));
    });
    json['products'].forEach((element){
      products!.add(ProductsData.fromJason(element));
    });
  }
 }

 class BannersData{
  int? id;
  String? image;

  BannersData.fromJason(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];
  }
 }

class ProductsData{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;

  ProductsData.fromJason(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];



  }
}


