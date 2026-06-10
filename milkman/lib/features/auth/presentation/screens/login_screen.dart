import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:milkman/core/routing/route_path.dart';
import 'package:milkman/core/theme/app_colors.dart';
import 'package:milkman/core/theme/extensions/text_ext.dart';
import 'package:milkman/core/widgets/top_header.dart';
import 'package:milkman/features/auth/presentation/bloc/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();
  String? _normalizedPhoneNumber;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      var phoneNumber = _phoneController.text.trim();
      if (phoneNumber.startsWith('0')) {
        phoneNumber = phoneNumber.substring(1);
        phoneNumber = '+92$phoneNumber';
      }
      _normalizedPhoneNumber = phoneNumber;
      context.read<AuthBloc>().add(AuthSendOTPEvent(phoneNumber: phoneNumber));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.themeMode == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final scale = (width / 375).clamp(0.85, 1.25);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.correction != null) {
          context.push(
            '${RoutePaths.otpVerification}/${_normalizedPhoneNumber ?? _phoneController.text.trim()}',
          );
        } else if (state.isSuccess && state.user != null) {
          context.go(RoutePaths.home);
        } else if (state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Positioned.fill(top: 20, child: MilkmanTopHeader(opacity: 0.2)),
                MilkmanTopHeader(),
              ],
            ),

            Expanded(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.05),

                        const Text(
                          "Welcome 👋",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: height * 0.01),

                        const Text(
                          "Login with your phone number",
                          style: TextStyle(color: Colors.grey),
                        ),

                        SizedBox(height: height * 0.05),

                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          cursorColor: AppColors.primary,
                          maxLength: 11,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            // Optional: custom formatter for dash after 4 digits
                          ],

                          decoration: InputDecoration(
                            counterText: "", // hides the length counter
                            border: InputBorder.none, // removes underline/box
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "03XX-XXXXXXX",
                            fillColor: isDark
                                ? AppColors.darkBackground
                                : AppColors.background,
                            hintStyle: TextStyle(
                              fontSize: 20 * scale,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                            // This keeps the hint visible even when typing
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          style: TextStyle(
                            fontSize: 20 * scale,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Phone number is required';
                            }
                            if (value!.length != 11) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                          // onChanged: (value) {
                          //   if (value.length == 11) {
                          //     setState(() {
                          //       length = true;
                          //     });
                          //   }
                          // },
                        ),

                        SizedBox(height: height * 0.035),

                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final int length = _phoneController.text
                                .trim()
                                .length;

                            /// 1️⃣ LOADING STATE (after button press)
                            if (state.isLoading) {
                              return loginButton(
                                context,
                                color: AppColors.primary,
                                isLoading: true,
                              );
                            }

                            /// 2️⃣ ENABLED STATE (valid phone)
                            if (length == 11) {
                              return loginButton(
                                context,
                                color: AppColors.primary,
                                onPressed: _handleLogin,
                              );
                            }

                            /// 3️⃣ DISABLED STATE (default)
                            return loginButton(context, color: Colors.grey);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget loginButton(
  BuildContext context, {
  Color color = AppColors.primary,
  VoidCallback? onPressed,
  bool isLoading = false,
}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  final btnHeight = (height * 0.07).clamp(48.0, 72.0);
  final fontSize = (16 * (width / 375)).clamp(14.0, 18.0);

  return SizedBox(
    height: btnHeight,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text('Continue', style: TextStyle(fontSize: fontSize)),
    ),
  );
}
