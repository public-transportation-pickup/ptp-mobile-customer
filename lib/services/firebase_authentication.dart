import 'package:capstone_ptp/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication {
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
      final String? authKey = await authResult.user?.getIdToken(false);
      if(authKey == null) {
        throw Exception('Auth Key is null');
      } else {
        final result =  await ApiService.login(authKey);
      }
        

      // Return the user details
      return authResult.user;
    } catch (error) {
      print("Error during Google Sign In: $error");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
