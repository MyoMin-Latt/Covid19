class CountriesOb {
  String? country;
  String? slug;
  String? iSO2;

  CountriesOb({this.country, this.slug, this.iSO2});

  CountriesOb.fromJson(Map<String, dynamic> json) {
    country = json['Country'];
    slug = json['Slug'];
    iSO2 = json['ISO2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Country'] = country;
    data['Slug'] = slug;
    data['ISO2'] = iSO2;
    return data;
  }
}
