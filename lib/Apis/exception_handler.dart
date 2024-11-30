import 'package:dio/dio.dart';

String exceptionsHandle({
  required DioException error,
}) {
  String message = "حدث خطأ ما ):";
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      message = 'الخادم غير متاح';
      break;
    case DioExceptionType.sendTimeout:
      message = 'انتهت مهلة الاتصال';
      break;
    case DioExceptionType.receiveTimeout:
      message = 'الخادم غير متاح ):';
      break;
    case DioExceptionType.badResponse:
      if (error.response?.statusCode == 503) {
        message = "الخادم غير متوفر حالياً ):";
        break;
      }

      if (error.response?.statusCode == 500) {
        message = "حدث خطأ في المخدّم ):";
        break;
      }

      if (error.response?.statusCode == 401) {
        message = error.response?.data['message'];
        break;
      }

      message = error.response?.data['message'];

      break;
    case DioExceptionType.cancel:
      message = 'تم إلغاء الطلب';
      break;
    case DioExceptionType.unknown:
      message = 'تحقق من اتصالك بالإنترنت';

      break;
    case DioExceptionType.badCertificate:
      message = 'خطأ في الشهادة';

      break;
    case DioExceptionType.connectionError:
      message = 'خطأ في الاتصال';

      break;
  }

  return message;
}
