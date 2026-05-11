import 'package:json_annotation/json_annotation.dart';
import 'package:milkman/features/auth/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.photoURL,
    super.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromFirebaseUser(dynamic firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoURL: firebaseUser.photoURL,
      isEmailVerified: firebaseUser.emailVerified,
    );
  }
}
