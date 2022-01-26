class CountryOb {
  String? iD;
  String? country;
  String? countryCode;
  String? province;
  String? city;
  String? cityCode;
  String? lat;
  String? lon;
  int? confirmed;
  int? deaths;
  int? recovered;
  int? active;
  String? date;

  CountryOb(
      {this.iD,
      this.country,
      this.countryCode,
      this.province,
      this.city,
      this.cityCode,
      this.lat,
      this.lon,
      this.confirmed,
      this.deaths,
      this.recovered,
      this.active,
      this.date});

  CountryOb.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    country = json['Country'];
    countryCode = json['CountryCode'];
    province = json['Province'];
    city = json['City'];
    cityCode = json['CityCode'];
    lat = json['Lat'];
    lon = json['Lon'];
    confirmed = json['Confirmed'];
    deaths = json['Deaths'];
    recovered = json['Recovered'];
    active = json['Active'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Country'] = country;
    data['CountryCode'] = countryCode;
    data['Province'] = province;
    data['City'] = city;
    data['CityCode'] = cityCode;
    data['Lat'] = lat;
    data['Lon'] = lon;
    data['Confirmed'] = confirmed;
    data['Deaths'] = deaths;
    data['Recovered'] = recovered;
    data['Active'] = active;
    data['Date'] = date;
    return data;
  }
}
