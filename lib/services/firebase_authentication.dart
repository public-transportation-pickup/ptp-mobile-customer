import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import 'api_services/authentication_api.dart';
import 'local_variables.dart';

class FirebaseAuthentication {
  // CHECK LOG
  var checkLog = Logger(printer: PrettyPrinter());

  // Initiation Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger Google Sign In
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        // User canceled the Google Sign In process
        return null;
      }

      // Obtain GoogleSignInAuthentication
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Create GoogleAuthCredential using GoogleSignInAuthentication
      final OAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in with Google Auth Credential
      final UserCredential authResult =
          await _auth.signInWithCredential(googleAuthCredential);

      final String? authKey = await authResult.user?.getIdToken(true);

      // Print log Auth key token from Firebase
      checkLog.i('Authkey Token: ${authKey?.substring(0, 800)}');
      checkLog.i('Continue key: ${authKey?.substring(800)}');

      LocalVariables.authkeyGoogle = authKey;
      LocalVariables.displayName = authResult.user?.displayName;
      LocalVariables.currentEmail = authResult.user?.email;
      LocalVariables.photoURL = authResult.user?.photoURL;
      LocalVariables.uid = authResult.user?.uid;

      // Call login system api
      await AuthenticationApi.login(authKey!);

      return authResult.user;
    } catch (error) {
      checkLog.e("Error during Google Sign In: $error");
      throw ("Đăng nhập với Google thất bại!\nVui lòng thử lại.");
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // Check if email is verified
      if (userCredential.user!.emailVerified) {
        // Obtain the authentication token
        final String? authKey = await userCredential.user?.getIdToken(true);
        // Print log Auth key token from Firebase
        checkLog.i('Authkey Token: ${authKey?.substring(0, 800)}');
        checkLog.i('Continue key: ${authKey?.substring(800)}');

        // Set user information into local variables
        LocalVariables.authkeyGoogle = authKey;
        LocalVariables.displayName = userCredential.user?.displayName;
        LocalVariables.currentEmail = userCredential.user?.email;
        LocalVariables.photoURL = userCredential.user?.photoURL;
        LocalVariables.uid = userCredential.user?.uid;

        // Call login system API
        await AuthenticationApi.login(authKey!);

        checkLog.d('User signed in: ${userCredential.user!.uid}');

        return userCredential.user;
      } else {
        // If email is not verified, delete the account and throw an error
        //await userCredential.user!.delete();
        throw 'Vui lòng xác thực email để có thể tiếp tục đăng nhập.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ("Email không tồn tại.");
      } else if (e.code == 'wrong-password') {
        throw ("Sai mật khẩu.");
      } else if (e.code == 'invalid-email') {
        throw ("Email không hợp lệ.");
      } else if (e.code == 'network-request-failed') {
        throw ("Không có kết nối mạng Internet.");
      } else {
        throw ("Error during Google Sign In: $e");
      }
    }
  }

  Future<User?> createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      return userCredential.user;
    } catch (error) {
      // Handle error during account creation
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          throw 'Email đã được sử dụng.';
        } else if (error.code == 'invalid-email') {
          throw 'Email không hợp lệ.';
        } else if (error.code == 'weak-password') {
          throw 'Mật khẩu phải có tối thiểu 6 ký tự.';
        } else {
          throw 'Tạo tài khoản thất bại: $error';
        }
      } else {
        rethrow;
      }
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      checkLog.e("Reset password error: $error");
      rethrow;
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw 'No user currently signed in.';
      }
    } catch (error) {
      checkLog.e("Error during password update: $error");
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
