import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInSignUpResult {
  final User? user;
  final String? message;
  SignInSignUpResult({this.user, this.message});
}

class AuthService {
  static Future<SignInSignUpResult?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    String? pesan;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateProfile(displayName: email);
      await user.reload();
      user = auth.currentUser;
      return SignInSignUpResult(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return SignInSignUpResult(message: "password to weak");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return SignInSignUpResult(message: "email already use");
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<SignInSignUpResult?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SignInSignUpResult(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return SignInSignUpResult(message: "No user found for that email.");
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided.');
        return SignInSignUpResult(message: "Wrong password provided.");
      }
    }

    // return user;
  }

  static Future<SignInSignUpResult?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        return SignInSignUpResult(user: userCredential.user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          return SignInSignUpResult(
              message:
                  "The account already exists with a different credential");
        } else if (e.code == 'invalid-credential') {
          // handle the error here
          return SignInSignUpResult(
              message:
                  "Error occurred while accessing credentials. Try again.");
        }
      } catch (e) {
        // handle the error here
        return SignInSignUpResult(
            message: "Error occurred using Google Sign In. Try again.");
      }
    }

    // return user;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  static Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("gagal");
    }
  }
}
