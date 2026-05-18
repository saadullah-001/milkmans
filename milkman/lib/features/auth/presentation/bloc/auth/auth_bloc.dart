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
    on<AuthLogoutEvent>(_onLogout);
    on<AuthSendOTPEvent>(_onSendOTP);
    on<AuthResendOTPEvent>(_onResendOTP);
    on<AuthVerifyOTPEvent>(_onVerifyOTP);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.loginWithPhoneNumber(
        phoneNumber: event.phoneNumber,
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

  Future<void> _onSendOTP(
    AuthSendOTPEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.sendOTP(phoneNumber: event.phoneNumber);
      emit(const AuthState.correction('OTP sent successfully'));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onResendOTP(
    AuthResendOTPEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.resendOTP(phoneNumber: event.phoneNumber);
      emit(const AuthState.correction('OTP resent successfully'));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onVerifyOTP(
    AuthVerifyOTPEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.verifyOTP(otpCode: event.otpCode);
      emit(AuthState.success(user));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }
}
