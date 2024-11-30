import 'package:talents/Modules/Certificate/Model/certificate_order.dart';

class CertificateResponse {
  final List<CertificateOrder> data;

  CertificateResponse({
    required this.data,
  });

  factory CertificateResponse.fromJson(Map<String, dynamic> json) =>
      CertificateResponse(
        data: List<CertificateOrder>.from(
          json["data"].map(
            (x) => CertificateOrder.fromJson(x),
          ),
        ),
      );
}
