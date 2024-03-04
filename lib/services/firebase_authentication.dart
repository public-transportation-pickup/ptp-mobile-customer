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
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
