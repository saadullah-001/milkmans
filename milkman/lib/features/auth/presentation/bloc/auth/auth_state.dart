part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isSuccess;
  final String? correction;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
    this.correction,
  });

  const AuthState.initial() : this();

  const AuthState.loading() : this(isLoading: true);

  const AuthState.success(User user)
    : this(user: user, isSuccess: true, isLoading: false);

  const AuthState.correction(String correction)
    : this(correction: correction, isLoading: false, isSuccess: false);

  const AuthState.failure(String error)
    : this(error: error, isLoading: false, isSuccess: true);

  @override
  List<Object?> get props => [user, isLoading, error, isSuccess, correction];
}
