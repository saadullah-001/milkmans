import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:milkman/core/routing/route_path.dart';
import 'package:milkman/core/utils/assets.dart';
import 'package:milkman/features/auth/presentation/bloc/auth/auth_bloc.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String _otpCode = '';
  bool _isResendLoading = false;
  int _resendCountdown = 0;

  String get _formattedPhoneNumber {
    return widget.phoneNumber.replaceFirst(RegExp(r'^\+920'), '+92');
  }

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startResendCountdown() {
    setState(() {
      _resendCountdown = 60;
    });
    Future.delayed(const Duration(seconds: 1), _tickResendCountdown);
  }

  void _tickResendCountdown() {
    if (!mounted || _resendCountdown <= 0) return;

    setState(() {
      _resendCountdown--;
    });

    if (_resendCountdown > 0) {
      Future.delayed(const Duration(seconds: 1), _tickResendCountdown);
    }
  }

  void _handleVerifyOTP() {
    final otp = _otpCode.trim();
    if (otp.isEmpty || otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
      return;
    }

    context.read<AuthBloc>().add(AuthVerifyOTPEvent(otpCode: otp));
  }

  void _handleResendOTP() async {
    if (_resendCountdown == 0) {
      setState(() {
        _isResendLoading = true;
      });
      context.read<AuthBloc>().add(
        AuthResendOTPEvent(phoneNumber: widget.phoneNumber),
      );
      _startResendCountdown();
      setState(() {
        _isResendLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isSuccess && state.user != null) {
          context.go(RoutePaths.home);
        } else if (state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        } else if (state.correction != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.correction!),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify OTP'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              // const SizedBox(height: 40),
              ClipRRect(
                child: Align(
                  alignment: Alignment.center,
                  widthFactor: 0.8, // crop horizontally
                  heightFactor: 0.5, // crop vertically
                  child: Image.asset(
                    Assets.milkman,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //const SizedBox(height: 40),
              Text(
                'Enter OTP',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'We sent a verification code to\n$_formattedPhoneNumber',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              OtpTextField(
                keyboardType: TextInputType.number,
                fieldWidth: 50,
                fieldHeight: 70,
                //contentPadding: EdgeInsets.all(10),
                numberOfFields: 6,
                borderColor: const Color(0xFF512DA8),
                showFieldAsBox: true,
                onCodeChanged: (String code) {
                  _otpCode = code;
                },
                onSubmit: (String verificationCode) {
                  _otpCode = verificationCode;
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state.isLoading ? null : _handleVerifyOTP,
                      child: state.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Verify OTP'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Didn\'t receive the code? '),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final canResend =
                          _resendCountdown == 0 && !_isResendLoading;
                      return TextButton(
                        onPressed: canResend ? _handleResendOTP : null,
                        child: _resendCountdown > 0
                            ? Text(
                                'Resend in ${_resendCountdown}s',
                                style: const TextStyle(color: Colors.grey),
                              )
                            : _isResendLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Resend OTP'),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
