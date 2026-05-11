import 'package:milkman/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> loginWithEmail({
    required String email,
    required String password,
  });

  Future<User> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> logout();

  Future<User?> getCurrentUser();

  Stream<User?> authStateChanges();

  Future<void> sendPasswordResetEmail(String email);

  bool get isAuthenticated;
}
