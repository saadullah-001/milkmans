part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  const AuthState.initial() : this();

  const AuthState.loading() : this(isLoading: true);

  const AuthState.success(User user)
    : this(user: user, isSuccess: true, isLoading: false);

  const AuthState.failure(String error)
    : this(error: error, isLoading: false, isSuccess: false);

  @override
  List<Object?> get props => [user, isLoading, error, isSuccess];
}
