import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String phoneNumber;
  final String? displayName;
  final String? photoURL;

  const User({
    required this.id,
    required this.phoneNumber,
    this.displayName,
    this.photoURL,
  });

  @override
  List<Object?> get props => [id, phoneNumber, displayName, photoURL];
}
