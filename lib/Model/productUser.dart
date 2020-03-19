class ProductUser {
  String email;
  String voteDate;

  ProductUser({this.email, this.voteDate});
}

class ProductData {
  String name;
  String voteDate;
  List<ProductUser> productUser;

  ProductData({this.name, this.voteDate, this.productUser});
}