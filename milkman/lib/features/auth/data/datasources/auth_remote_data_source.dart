import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:milkman/features/auth/data/models/user_model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> logout();

  Future<UserModel?> getCurrentUser();

  Stream<UserModel?> authStateChanges();

  Future<void> sendPasswordResetEmail(String email);

  bool get isAuthenticated;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final fa.FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) throw Exception('User is null after login');
      return UserModel.fromFirebaseUser(user);
    } on fa.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) throw Exception('User is null after registration');

      await user.updateDisplayName(displayName);
      await user.reload();

      return UserModel.fromFirebaseUser(_firebaseAuth.currentUser!);
    } on fa.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on fa.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    });
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on fa.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  String _handleFirebaseAuthException(fa.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password';
      case 'weak-password':
        return 'Password is too weak';
      case 'email-already-in-use':
        return 'Email already in use';
      case 'invalid-email':
        return 'Invalid email';
      default:
        return e.message ?? 'Authentication failed';
    }
  }
}
