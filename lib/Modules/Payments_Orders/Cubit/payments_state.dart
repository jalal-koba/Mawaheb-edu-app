abstract class PaymentsState {}

final class PaymentsInitialState extends PaymentsState {}

final class ChangeTabState extends PaymentsState {}
final class PaymentsOrdersLoadingState extends PaymentsState {}
final class PaymentsOrdersSuccess extends PaymentsState {}
final class PaymentsOrdersErrorState extends PaymentsState {
  final String message;
  PaymentsOrdersErrorState( {required this.message});
}



