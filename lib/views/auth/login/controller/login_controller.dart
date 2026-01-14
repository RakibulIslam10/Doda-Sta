import 'dart:io';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../core/api/services/auths.dart';

class LoginController extends GetxController {
  /// FORM
  final formKey = GlobalKey<FormState>();

  /// EMAIL
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  final isEmailValid = false.obs;

  /// PASSWORD
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  final isPasswordValid = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;

  /// LOADING
  final isLoading = false.obs;

  /// FIREBASE AUTH
  final firebaseUser = Rxn<User>();

  User? get user => firebaseUser.value;

  @override
  void onInit() {
    super.onInit();

    // logo change in appbar
    // profile image and product  a dd image not showing

    // // //   USER
    // emailController.text = 'dsf26@yopmail.com';
    // passwordController.text = '111111';
    //
    emailController.text = 'd15r@yopmail.com';
    passwordController.text = '111111';
  }

  /// ❌ REMOVE dispose()7
  /// GetX নিজেই lifecycle handle করবে

  /// =======================================
  /// 🔥 LOGIN USING EMAIL + PASSWORD (API)
  /// =======================================
  Future<dynamic> loginProcess() async {
    return await AuthService.loginService(
      isLoading: isLoading,
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  /// =======================================
  /// 🔥 GOOGLE SIGN IN (Android / iOS / Web)
  /// =======================================
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      // Initialize GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Get.snackbar(
          "Cancelled",
          "Google sign-in was cancelled",
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Debug: Check if we have tokens
      if (kDebugMode) {
        print("==========================================");
        print("Google Auth Tokens:");
        print("Access Token: ${googleAuth.accessToken?.substring(0, 20)}...");
        print("ID Token: ${googleAuth.idToken?.substring(0, 20)}...");
        print("==========================================");
      }

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      // Update your observable/state
      firebaseUser.value = userCredential.user;

      // Get Firebase ID Token (এটা backend এ পাঠাতে হবে)
      final firebaseToken = await userCredential.user?.getIdToken();

      if (kDebugMode) {
        print("==========================================");
        print("Firebase User Info:");
        print("UID: ${userCredential.user?.uid}");
        print("Email: ${userCredential.user?.email}");
        print("Display Name: ${userCredential.user?.displayName}");
        print("Firebase Token: ${firebaseToken?.substring(0, 30)}...");
        print("Token Length: ${firebaseToken?.length}");
        print("==========================================");
      }

      // Show success message
      Get.snackbar(
        "Success",
        "Signed in as ${userCredential.user?.displayName ?? 'User'}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Error: ${e.code} - ${e.message}");

      String errorMessage;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage =
              "An account already exists with a different sign-in method";
          break;
        case 'invalid-credential':
          errorMessage = "Invalid credentials. Please try again";
          break;
        case 'operation-not-allowed':
          errorMessage = "Google sign-in is not enabled";
          break;
        case 'user-disabled':
          errorMessage = "This user account has been disabled";
          break;
        case 'user-not-found':
          errorMessage = "No user found with this account";
          break;
        default:
          errorMessage = "Authentication failed: ${e.message}";
      }

      Get.snackbar(
        "Authentication Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );

      firebaseUser.value = null;
      return null;
    } on PlatformException catch (e) {
      debugPrint("Platform Error: ${e.code} - ${e.message}");

      String errorMessage;
      if (e.code == 'sign_in_failed') {
        errorMessage = "Sign-in failed. Please check SHA-1 configuration";
      } else if (e.code == 'network_error') {
        errorMessage = "Network error. Check your internet connection";
      } else {
        errorMessage = "Sign-in failed: ${e.message ?? 'Unknown error'}";
      }

      Get.snackbar(
        "Sign-In Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );

      await FirebaseAuth.instance.signOut();
      firebaseUser.value = null;
      return null;
    } catch (e) {
      debugPrint("Unexpected Error: $e");

      Get.snackbar(
        "Error",
        "An unexpected error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );

      await FirebaseAuth.instance.signOut();
      firebaseUser.value = null;
      return null;
    }
  }

  /// =======================================
  /// 🔥 SIGN OUT (Google + Firebase)
  /// =======================================
  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      firebaseUser.value = null;

      Get.snackbar("Success", "Signed out successfully");
    } catch (e) {
      debugPrint("Sign-Out Error: $e");
      Get.snackbar("Error", "Unable to sign out");
    }
  }

  /// APPLE AUTH INSTANCE
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// =======================================
  /// 🔥 APPLE SIGN IN (iOS / macOS Only)
  /// =======================================
  static Future<UserCredential?> signInWithApple() async {
    try {
      // Platform check
      if (kIsWeb) {
        debugPrint("❌ Apple Sign-In not supported on Web");
        Get.snackbar(
          "Not Supported",
          "Apple Sign-In is not available on web",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return null;
      }

      if (!Platform.isIOS && !Platform.isMacOS) {
        debugPrint("❌ Apple Sign-In only supports iOS/macOS");
        Get.snackbar(
          "Not Supported",
          "Apple Sign-In is only available on iOS/macOS devices",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return null;
      }

      // Request Apple ID credential
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Check if we got the credential
      if (appleCredential.identityToken == null) {
        debugPrint("❌ Apple Sign-In: No identity token received");
        Get.snackbar(
          "Error",
          "Failed to get Apple credentials",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      }

      // Create OAuth credential for Firebase
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(oauthCredential);

      // Debug info
      if (kDebugMode) {
        print("========== APPLE SIGN-IN SUCCESS ==========");
        print("✅ User ID: ${userCredential.user?.uid}");
        print("✅ Email: ${userCredential.user?.email}");
        print("✅ Display Name: ${userCredential.user?.displayName}");

        // Apple provides name only on first sign-in
        if (appleCredential.givenName != null ||
            appleCredential.familyName != null) {
          print("✅ Given Name: ${appleCredential.givenName}");
          print("✅ Family Name: ${appleCredential.familyName}");
        }
        print("==========================================");
      }

      // Update display name if available (only first time)
      if (userCredential.user != null &&
          userCredential.user!.displayName == null &&
          appleCredential.givenName != null) {
        final displayName =
            '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'
                .trim();

        if (displayName.isNotEmpty) {
          await userCredential.user!.updateDisplayName(displayName);
          await userCredential.user!.reload();
        }
      }

      Get.snackbar(
        "Success",
        "Signed in with Apple successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      return userCredential;
    } on SignInWithAppleAuthorizationException catch (e) {
      debugPrint("Apple Authorization Error: ${e.code} - ${e.message}");

      String errorMessage;
      switch (e.code) {
        case AuthorizationErrorCode.canceled:
          errorMessage = "Apple Sign-In was cancelled";
          break;
        case AuthorizationErrorCode.failed:
          errorMessage = "Apple Sign-In failed";
          break;
        case AuthorizationErrorCode.invalidResponse:
          errorMessage = "Invalid response from Apple";
          break;
        case AuthorizationErrorCode.notHandled:
          errorMessage = "Apple Sign-In not handled";
          break;
        case AuthorizationErrorCode.unknown:
          errorMessage = "Unknown error occurred";
          break;
        default:
          errorMessage = "Apple Sign-In error: ${e.message}";
      }

      Get.snackbar(
        "Sign-In Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Error: ${e.code} - ${e.message}");

      String errorMessage;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage =
              "An account already exists with a different sign-in method";
          break;
        case 'invalid-credential':
          errorMessage = "Invalid Apple credentials";
          break;
        case 'operation-not-allowed':
          errorMessage = "Apple Sign-In is not enabled";
          break;
        case 'user-disabled':
          errorMessage = "This user account has been disabled";
          break;
        default:
          errorMessage = "Authentication failed: ${e.message}";
      }

      Get.snackbar(
        "Authentication Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );

      return null;
    } catch (e) {
      debugPrint("Unexpected Apple Sign-In Error: $e");

      Get.snackbar(
        "Error",
        "An unexpected error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );

      return null;
    }
  }

  /// =======================================
  /// 🔥 CURRENT USER
  /// =======================================
  static User? currentUser() => _auth.currentUser;

  /// =======================================
  /// 🔥 SIGN OUT (Apple + Firebase)
  /// =======================================
  static Future<void> signOutApple() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("Apple Sign-Out Error: $e");
    }
  }
}
