import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:milkman/app/app.dart';
import 'package:milkman/features/auth/data/models/user_model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithPhoneNumber({required String phoneNumber});

  Future<UserModel> verifyOTP({required String otpCode});

  Future<void> logout();

  Future<UserModel?> getCurrentUser();

  Stream<UserModel?> authStateChanges();

  Future<void> sendOTP({required String phoneNumber});

  Future<void> resendOTP({required String phoneNumber});

  bool get isAuthenticated;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final fa.FirebaseAuth _firebaseAuth;
  String? _verificationId;
  int? _resendToken;

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> loginWithPhoneNumber({required String phoneNumber}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),

        // Triggered when verification is completed automatically
        verificationCompleted: (fa.PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },

        // Triggered when verification fails
        verificationFailed: (fa.FirebaseAuthException e) {
          throw _handleFirebaseAuthException(e);
        },

        // Triggered when code is sent to the user
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
        },

        // Triggered when code auto-retrieval times out
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );

      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('User sign in failed');
      }
      return UserModel.fromFirebaseUser(user);
    } on fa.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<UserModel> verifyOTP({required String otpCode}) async {
    try {
      if (_verificationId == null) {
        throw Exception('Verification ID not found. Please request OTP first.');
      }

      final credential = fa.PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpCode,
      );

      await _firebaseAuth.signInWithCredential(credential);

      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('User sign in failed');
      }
      return UserModel.fromFirebaseUser(user);
    } on fa.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<void> sendOTP({required String phoneNumber}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),

        // Triggered when verification is completed automatically
        verificationCompleted: (fa.PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },

        // Triggered when verification fails
        verificationFailed: (fa.FirebaseAuthException e) {
          throw _handleFirebaseAuthException(e);
        },

        // Triggered when code is sent to the user
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
        },

        // Triggered when code auto-retrieval times out
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } on fa.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<void> resendOTP({required String phoneNumber}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        forceResendingToken: _resendToken,

        // Triggered when verification is completed automatically
        verificationCompleted: (fa.PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },

        // Triggered when verification fails
        verificationFailed: (fa.FirebaseAuthException e) {
          throw _handleFirebaseAuthException(e);
        },

        // Triggered when code is sent to the user
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
        },

        // Triggered when code auto-retrieval times out
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } on fa.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on fa.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    });
  }

  @override
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  String _handleFirebaseAuthException(fa.FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'Invalid phone number';
      case 'missing-phone-number':
        return 'Phone number is required';
      case 'too-many-requests':
        return 'Too many requests. Please try again later';
      case 'invalid-verification-code':
        return 'Invalid verification code';
      case 'session-expired':
        return 'Verification session expired. Please try again';
      default:
        return e.message ?? 'Authentication failed';
    }
  }
}
