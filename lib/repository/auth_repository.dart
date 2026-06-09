import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/usermodel.dart';

final AuthRepositoryProvider = Provider<AuthRepository>((ref){
  return AuthRepository(FirebaseAuth.instance);
});

// Auth state ko track karne wala provider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(AuthRepositoryProvider).authStateChange;
});

class AuthRepository {
  final FirebaseAuth _auth;
  AuthRepository(this._auth);

  //checks loginnnn status
  Stream<User?> get authStateChange => _auth.authStateChanges();

  //Signup 
  Future<UserModel> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), 
        password: password.trim()
      );

      User? firebaseUser = userCredential.user;

      if(firebaseUser != null){
        await firebaseUser.updateDisplayName(name.trim());

        return UserModel(
          uid: firebaseUser.uid, 
          email: firebaseUser.email ?? '', 
          name: name.trim()
        );
      }else{
        throw "User is Null!";
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        throw 'Password is too weak. Must use Numericals, Uppercase, LowerCase & Special Characters';
      }else if(e.code == 'email-already-in-use'){
        throw 'User Already exists for thie Email. Please go to Login Screen!';
      }else if(e.code == 'invalid-email'){
        throw 'Email format Invalid || Corrupted';
      }
      throw 'Authentication breach occured.';
    } catch(e){
      throw e.toString();
    }
  }

  //Sign in
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(), 
        password: password.trim()
      );

      User? firebaseUser = userCredential.user;

      if(firebaseUser != null){
        return UserModel(
          uid: firebaseUser.uid, 
          email: firebaseUser.email ?? '', 
          name: firebaseUser.displayName ?? 'Agent'
        );
      }else{
        throw 'Access Denied';
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credentials'){
        throw 'Invalid credentials. Access Denied!';
      }else if(e.code == 'user-disabled'){
        throw 'Account has been deActivated by Admin';
      }
      throw e.message ?? "Decryption System failed.";
    }catch(e){
      throw e.toString();
    }
  }

  //password reset method
  Future<void> sendPasswordReset({required String email}) async {
    try{
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e){
      if(e.code == 'invalid-email'){
        throw "The email format is invalid.";
      }else if(e.code == 'user-not-found'){
        throw 'No Account found for this email';
      }
      throw e.message ?? 'Failed to dispatch recovery link.';
    }catch (e){
      throw e.toString();
    }
  }

  //signout
  Future<void> signOut() async{
    await _auth.signOut();
  }
}
