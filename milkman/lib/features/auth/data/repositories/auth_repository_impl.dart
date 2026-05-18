import 'package:milkman/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:milkman/features/auth/domain/entities/user.dart';
import 'package:milkman/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User> loginWithPhoneNumber({required String phoneNumber}) async {
    return await _remoteDataSource.loginWithPhoneNumber(
      phoneNumber: phoneNumber,
    );
  }

  @override
  Future<void> logout() async {
    return await _remoteDataSource.logout();
  }

  @override
  Future<User?> getCurrentUser() async {
    return await _remoteDataSource.getCurrentUser();
  }

  @override
  Stream<User?> authStateChanges() {
    return _remoteDataSource.authStateChanges();
  }

  @override
  Future<void> sendOTP({required String phoneNumber}) async {
    return await _remoteDataSource.sendOTP(phoneNumber: phoneNumber);
  }

  @override
  Future<void> resendOTP({required String phoneNumber}) async {
    return await _remoteDataSource.resendOTP(phoneNumber: phoneNumber);
  }

  @override
  Future<User> verifyOTP({required String otpCode}) async {
    return await _remoteDataSource.verifyOTP(otpCode: otpCode);
  }

  @override
  bool get isAuthenticated => _remoteDataSource.isAuthenticated;
}
