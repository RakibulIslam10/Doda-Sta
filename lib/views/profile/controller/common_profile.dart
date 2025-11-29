// import '../model/provider_profile_model.dart';
// import '../model/user_profile_model.dart';
//
// class CommonProfile {
//   final String? name;
//   final String? email;
//   final String? profileImage;
//   final String? phoneNumber;
//   final double? rating;       // Provider-specific
//   final int? totalReviews;    // Provider-specific
//
//   CommonProfile({
//     this.name,
//     this.email,
//     this.profileImage,
//     this.phoneNumber,
//     this.rating,
//     this.totalReviews,
//   });
//
//   // From User profile
//   factory CommonProfile.fromUser(UserData user) {
//     return CommonProfile(
//       name: user.name,
//       email: user.email,
//       profileImage: user.profileImage,
//       phoneNumber: user.phoneNumber,
//     );
//   }
//
//   // From Provider profile
//   factory CommonProfile.fromProvider(ProviderData provider) {
//     return CommonProfile(
//       name: provider.authId?.name,
//       email: provider.authId?.email,
//       profileImage: null, // if provider has image key, use it
//       rating: provider.rating,
//       totalReviews: provider.totalReviews,
//     );
//   }
//
//   // ✅ Make sure this method exists
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'email': email,
//       'profileImage': profileImage,
//       'phoneNumber': phoneNumber,
//       'rating': rating,
//       'totalReviews': totalReviews,
//     };
//   }
// }
