class BannerModel {
  int id;
  String name;
  String image;
  String description;

  BannerModel(this.id, this.name, this.image, this.description);

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _bannerFromJson(json);
}

BannerModel _bannerFromJson(Map<String, dynamic> json) {
  return BannerModel(
      json['id'], json['name'], json['image'], json['description']);
}
