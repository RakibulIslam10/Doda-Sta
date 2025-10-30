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
  static const providerProfile = 'provider/profile';
  static const userUpdateProfile = 'user/edit-profile';
  static const providerUpdateProfile = 'provider/update-profile';
  static const deleteProfile = 'user/delete-account';

  //bookmark
  static const bookMark = 'home/save';
  static const bookMarkData = 'home/saved';
  static const userProgress = 'user-progress/continue';


  static final getTerms = '${baseUrl}manage/get-terms-conditions';
  static final getPrivacy = '${baseUrl}manage/get-privacy-policy';
  static final updateProviderLicence = '${baseUrl}provider/update-profile';

  static final categoryAll = '${baseUrl}category/active-categories';
  static serviceCreate() => '${baseUrl}service-requests/create';
  static myService({required String status,required int page}) => '${baseUrl}service-requests/my-requests?status=$status&page=$page&limit=20';
  static providerService({required String status,required int page}) => '${baseUrl}provider/potential-requests?providerStatus=$status&page=$page&limit=20';
  static providerChangeStatus() => '${baseUrl}provider/handle-request';
  static notification({required int page}) => '${baseUrl}notification/get-all-notifications?page=$page&limit=20';
}
