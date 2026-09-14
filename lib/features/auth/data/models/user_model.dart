import 'package:bloc_starter_kit/features/auth/domain/entities/user.dart';

/// Data Transfer Object for [User].
///
/// Keeps JSON parsing out of the domain entity mapping path while
/// reusing the same exhaustive map-pattern validation.
final class UserModel {
  /// Creates a new DTO.
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatarUrl,
  });

  /// Converts a domain entity to a DTO.
  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        phone: user.phone,
        avatarUrl: user.avatarUrl,
      );

  /// Creates a DTO from a JSON map.
  ///
  /// Throws a [FormatException] when required keys are missing.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final String id,
        'email': final String email,
        'name': final String name,
      } =>
        UserModel(
          id: id,
          email: email,
          name: name,
          phone: json['phone'] as String?,
          avatarUrl: json['avatarUrl'] as String?,
        ),
      _ => throw const FormatException('Failed to load UserModel.'),
    };
  }

  /// Unique identifier.
  final String id;

  /// Email address.
  final String email;

  /// Display name.
  final String name;

  /// Optional phone.
  final String? phone;

  /// Optional avatar URL.
  final String? avatarUrl;

  /// Converts this DTO to a domain entity.
  User toEntity() => User(
        id: id,
        email: email,
        name: name,
        phone: phone,
        avatarUrl: avatarUrl,
      );

  /// Converts this DTO to JSON.
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        if (phone != null) 'phone': phone,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
      };
}
