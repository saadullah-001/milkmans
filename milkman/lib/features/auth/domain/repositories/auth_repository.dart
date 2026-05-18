import 'package:milkman/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> loginWithPhoneNumber({required String phoneNumber});

  Future<User> verifyOTP({required String otpCode});

  Future<void> sendOTP({required String phoneNumber});

  Future<void> resendOTP({required String phoneNumber});

  Future<void> logout();

  Future<User?> getCurrentUser();

  Stream<User?> authStateChanges();

  bool get isAuthenticated;
}
