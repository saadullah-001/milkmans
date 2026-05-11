import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:milkman/features/auth/domain/entities/user.dart';
import 'package:milkman/features/auth/domain/repositories/auth_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository _authRepository;

  SessionCubit(this._authRepository)
    : super(const SessionState.unauthenticated()) {
    _init();
  }

  void _init() {
    _authRepository.authStateChanges().listen((user) {
      if (user != null) {
        emit(SessionState.authenticated(user));
      } else {
        emit(const SessionState.unauthenticated());
      }
    });
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
