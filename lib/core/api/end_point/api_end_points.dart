class ApiEndPoints {
  static final mainDomain = 'http://10.10.20.52:6002';
  static final baseUrl = '$mainDomain/';

  /// API End Points
  // Auth
  static const login = 'auth/login';
  static const register = 'auth/register';
  static const verifyEmail = 'auth/activate-account';
  static const resendVerification = 'auth/resend-verification';
  static const resetPassword = 'auth/reset-password';
  static const forgotPassword = 'auth/forgot-password';

  //home
  static const banner = 'banner/get';
  static const privacy = 'manage/get-privacy-policy';
  static const terms = 'manage/get-terms-conditions';
  static const allEbookGet = 'ebooks/get';
  static const getAllBookCategory = 'book-categories/get';
  static const singlePost = 'home/book';

  //category

  static const categoryPreview = 'categories/books';
  static const getAllAudioBook = 'audio-books/get';
  static const faqGet = 'manage/get-faq';

  //profile
  static const changePassword = 'user/profile/change-password';
  static const profile = 'user/profile/get';
  static const updateProfile = 'user/profile/update';

  //bookmark
  static const bookMark = 'home/save';
  static const bookMarkData = 'home/saved';
  static const userProgress = 'user-progress/continue';

  static final categoryAll = '${baseUrl}category/active-categories';
  static serviceCreate() => '${baseUrl}service-requests/create';
  static myService({required String status,required int page}) => '${baseUrl}service-requests/my-requests?status=$status&page=$page&limit=20';
}
