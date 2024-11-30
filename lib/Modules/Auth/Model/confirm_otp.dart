class ConfirmOTP {
  Data? data;
  int? code;

  ConfirmOTP({this.data, this.code});

  ConfirmOTP.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }
}

class Data {
  String? code;
  bool? isValid;

  Data({this.code, this.isValid});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    isValid = json['is_valid'];
  }
}
