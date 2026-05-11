part of 'session_cubit.dart';

class SessionState extends Equatable {
  final User? user;
  final bool isAuthenticated;

  const SessionState({this.user, required this.isAuthenticated});

  const SessionState.authenticated(User user)
    : this(user: user, isAuthenticated: true);

  const SessionState.unauthenticated()
    : this(user: null, isAuthenticated: false);

  @override
  List<Object?> get props => [user, isAuthenticated];
}
