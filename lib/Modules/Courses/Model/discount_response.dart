class DiscountResponse {
  final String? errorMessage;
  final num? couponDiscountPercentage, afterDiscount, beforeDiscount;

  DiscountResponse(
      {required this.errorMessage,
      required this.couponDiscountPercentage,
      required this.afterDiscount,
      required this.beforeDiscount});

  factory DiscountResponse.fromJson(Map<String, dynamic> json) =>
      DiscountResponse(
          errorMessage: json['data']['error_message'],
          couponDiscountPercentage: json['data']['coupon_discount_percentage'],
          afterDiscount: json['data']['result'],
          beforeDiscount: json['data']['section_price']);
}
