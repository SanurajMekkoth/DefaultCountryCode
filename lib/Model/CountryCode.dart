import 'dart:convert';

List<CountryCode> countryCodeFromJson(String str) => List<CountryCode>.from(
    json.decode(str).map((x) => CountryCode.fromJson(x)));

String countryCodeToJson(List<CountryCode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryCode {
  CountryCode({
    this.name,
    this.dialCode,
    this.code,
  });

  String? name;
  String? dialCode;
  String? code;

  factory CountryCode.fromJson(Map<String, dynamic> json) => CountryCode(
        name: json["name"],
        dialCode: json["dial_code"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dial_code": dialCode,
        "code": code,
      };
}
