import 'package:doda_work/core/api/services/api.dart';
import 'package:doda_work/core/api/services/auth_service.dart';
import 'package:doda_work/core/api/services/auths.dart';
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/views/auth/login/model/login_model.dart' hide User;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // email
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  final isEmailValid = false.obs;

  // password
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  final isPasswordValid = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.text = 'qeo@yopmail.com';
    passwordController.text = '112233';
  }

  RxBool isLoading = false.obs;

  // login APi
  loginProcess() async {
    return await AuthService.loginService(
      isLoading: isLoading,
      email: emailController.text,
      password: passwordController.text,
    );
  }


  // google logi section
  // Observable user
  var firebaseUser = Rxn<User>();

  // Getter for convenience
  User? get user => firebaseUser.value;

  /// Sign in with Google and get user info
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

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      firebaseUser.value = userCredential.user;



      Get.snackbar("Success", "Signed in as ${userCredential.user?.displayName}");

      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print("Google Sign-In Error: $e");
      }
      await FirebaseAuth.instance.signOut();
      firebaseUser.value = null;
      Get.snackbar("Error", "Google Sign-In failed");
      return null;
    }
  }
  /// Sign out from Firebase and Google
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

}
