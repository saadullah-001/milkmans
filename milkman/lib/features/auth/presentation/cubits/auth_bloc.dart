import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:milkman/features/auth/domain/entities/user.dart';
import 'package:milkman/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState.initial()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthLogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.loginWithEmail(
        email: event.email,
        password: event.password,
      );
      emit(AuthState.success(user));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onRegister(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.registerWithEmail(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
      );
      emit(AuthState.success(user));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.logout();
      emit(const AuthState.initial());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }
}
