class ApiEndPoints {
  static final mainDomain = 'http://10.10.20.52:6002';
  static final baseUrl = '$mainDomain/';

  /// API End Points
  // Auth
  static const login = 'auth/login';
  static const register = 'auth/register';
  static const verifyEmail = 'auth/activate-account';
  static const resendOtpCode = 'auth/activation-code-resend';
  static const resetPassword = 'auth/reset-password';
  static const forgotPassword = 'auth/forgot-password';
  static const providerRegister = 'provider/provider-register';

  //home
  static const banner = 'banner/get';
  static const privacy = 'manage/get-privacy-policy';
  static const terms = 'manage/get-terms-conditions';
  static const allEbookGet = 'ebooks/get';
  static const getAllBookCategory = 'book-categories/get';
  static const singlePost = 'home/book';

  //category

  static const categoryPreview = 'categories/books';
  static const serviceCategory = 'category/active-categories';
  static const getAllAudioBook = 'audio-books/get';
  static const faqGet = 'manage/get-faq';

  //profile
  static const changePassword = 'auth/change-password';
  static const userProfile = 'user/profile';
  static const userUpdateProfile = 'user/edit-profile';
  static const providerUpdateProfile = 'provider/update-profile';
  static const deleteProfile = 'user/delete-account';

  //bookmark
  static const bookMark = 'home/save';
  static const bookMarkData = 'home/saved';
  static const userProgress = 'user-progress/continue';
}
