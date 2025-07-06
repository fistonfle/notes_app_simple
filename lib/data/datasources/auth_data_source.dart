import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';

abstract class AuthDataSource {
  Future<User?> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FirebaseAuthDataSource implements AuthDataSource {
  FirebaseAuthDataSource({required this.firebaseAuth});
  
  final firebase_auth.FirebaseAuth firebaseAuth;

  @override
  Future<User?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
    );
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user == null) {
        throw Exception('Sign in failed');
      }
      
      return User(
        id: credential.user!.uid,
        email: credential.user!.email ?? '',
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(_getErrorMessage(e.code));
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user == null) {
        throw Exception('Account creation failed');
      }
      
      return User(
        id: credential.user!.uid,
        email: credential.user!.email ?? '',
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(_getErrorMessage(e.code));
    } catch (e) {
      throw Exception('Account creation failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password is too weak';
      case 'email-already-in-use':
        return 'An account already exists for this email';
      case 'invalid-email':
        return 'The email address is invalid';
      case 'user-not-found':
        return 'No user found for this email';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'too-many-requests':
        return 'Too many requests. Try again later';
      default:
        return 'Authentication failed';
    }
  }
}
