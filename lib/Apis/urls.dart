class Urls {
  
  static const String domain = "https://khrejeen-back.icrcompany.net";

  static const String baseUrl = "$domain/api/v1/";

  static const String storageBaseUrl = "$domain/storage/";

  static const String siginUp = "register";

  static const String login = "login";

  static const String logout = "logout";

  static const String sendVerificationCode = "send/verification-code";

  static const String checkVerificationCode =
      "check/verification-code";

  static const String restPassword = "reset-password";

  static const String profileInfo = "profile";

  static const String changeEmail = "update-email";

  static const String updateProfile = "profile/update";

  static const String changePassword = "change-password";

  static const String contactMessages = "contact-messages";

  static const String sections = "sections";

  static const String librarySections = "sections?type=book_section";

  static const String courses = "sections?type=courses";

  static const String librarySubSections = "sections";

  static const String trainers = "teachers";

  static const String offers = "offers";

  static const String home = "home/mobile";

  static const String infos = "infos";

  static const String payCourse = "student/subs-requests";

  static const String getPaymentsOrders = "student/subs-requests";

  static String oneCourseInfo({required int id, required String additional}) =>
      "sections/$id/lessons?get=1&$additional";

  static String subscribedCourses({required int page}) =>
      "auth/courses?page=$page";

  static String lesson({required int parentId, required int lessonId}) =>
      "sections/$parentId/lessons/$lessonId";

  static const getSections = 'sections';

  static const certificateRequests = 'certificate-requests?get=1';

  static const subscribeInFreeCourse = 'course-student';

  static const studentExams = 'student-exams';

  static getExam({required int id}) => 'exams/$id';

  static const postCertificateRequest = 'certificate-requests';
  static const checkCopun = 'student/subs-requests/coupon-check';

  static  String  notifications ({required int read,required int page}) => 'notifications?page=$page&mark_read=$read';
}
