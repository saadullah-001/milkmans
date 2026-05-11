import 'package:milkman/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:milkman/features/auth/domain/entities/user.dart';
import 'package:milkman/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User> loginWithEmail({
    required String email,
    required String password,
  }) async {
    return await _remoteDataSource.loginWithEmail(
      email: email,
      password: password,
    );
  }

  @override
  Future<User> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    return await _remoteDataSource.registerWithEmail(
      email: email,
      password: password,
      displayName: displayName,
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
  Future<void> sendPasswordResetEmail(String email) async {
    return await _remoteDataSource.sendPasswordResetEmail(email);
  }

  @override
  bool get isAuthenticated => _remoteDataSource.isAuthenticated;
}
