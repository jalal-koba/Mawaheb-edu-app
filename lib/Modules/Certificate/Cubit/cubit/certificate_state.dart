part of 'certificate_cubit.dart';

@immutable
sealed class CertificateState {}

final class CertificateInitialState extends CertificateState {}

final class CertificateLoadingState extends CertificateState {}

final class CertificateSuccessState extends CertificateState {}

final class CertificateErrorState extends CertificateState {
  final String message;

  CertificateErrorState({required this.message});
}



final class PostCertificateLoadingState extends CertificateState {}

final class PostCertificateSuccessState extends CertificateState {}

final class PostCertificateErrorState extends CertificateState {
  final String message;

 PostCertificateErrorState({required this.message});
}
