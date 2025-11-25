import 'dart:io';
import 'package:doda_work/core/api/services/auth_service.dart';
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

    /// Default credentials for testing
    emailController.text = 'qeo@yopmail.com';
    passwordController.text = '112233';
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }

  /// ===============================
  /// 🔥 LOGIN USING EMAIL + PASSWORD
  /// ===============================
  Future<dynamic> loginProcess() async {
    return await AuthService.loginService(
      isLoading: isLoading,
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  /// ===============================
  /// 🔥 GOOGLE SIGN IN
  /// ===============================
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn(
        clientId: "621538781171-8f9t0fpop11e2cfg4jc5qc9iukbb1sq5.apps.googleusercontent.com",
        serverClientId: "621538781171-aq5ivgocr6otgp90d5mbhmvicnrn1re1.apps.googleusercontent.com",
        scopes: ['email', 'profile'],
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar("Cancelled", "Google sign-in was cancelled");
        return null;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      firebaseUser.value = userCredential.user;

      Get.snackbar(
        "Success",
        "Signed in as ${userCredential.user?.displayName}",
      );

      return userCredential.user;

    } catch (e) {
      if (kDebugMode) print("Google Sign-In Error: $e");

      await FirebaseAuth.instance.signOut();
      firebaseUser.value = null;

      Get.snackbar("Error", "Google Sign-In failed");
      return null;
    }
  }

  /// ===============================
  /// 🔥 SIGN OUT (Google + Firebase)
  /// ===============================
  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      firebaseUser.value = null;

      Get.snackbar("Success", "Signed out successfully");
    } catch (e) {
      print("Sign-Out Error: $e");
      Get.snackbar("Error", "Sign-out failed");
    }
  }

  /// APPLE AUTH INSTANCE
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ===============================
  /// 🔥 APPLE SIGN IN
  /// ===============================
  static Future<UserCredential?> signInWithApple() async {
    try {
      if (kIsWeb) {
        print("Apple Sign-In not supported on Web.");
        return null;
      }

      if (!Platform.isIOS && !Platform.isMacOS) {
        print("Apple Sign-In only for iOS/macOS.");
        return null;
      }

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      return await _auth.signInWithCredential(oauthCredential);

    } catch (e) {
      print("Apple Sign-In Error: $e");
      return null;
    }
  }

  /// ===============================
  /// 🔥 CURRENT USER (APPLE/GMAIL)
  /// ===============================
  static User? currentUser() => _auth.currentUser;

  /// ===============================
  /// 🔥 SIGN OUT APPLE
  /// ===============================
  static Future<void> signOutApple() async {
    await _auth.signOut();
  }
}
