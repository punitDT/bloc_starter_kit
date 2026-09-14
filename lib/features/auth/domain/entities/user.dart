import 'package:equatable/equatable.dart';

/// Authenticated user entity.
///
/// Pure domain object. Use `UserModel` for JSON serialization.
class User extends Equatable {
  /// Creates a new user.
  const User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatarUrl,
  });

  /// Creates a user from a JSON map.
  ///
  /// Throws a [FormatException] if required keys are missing.
  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final String id,
        'email': final String email,
        'name': final String name,
      } =>
        User(
          id: id,
          email: email,
          name: name,
          phone: json['phone'] as String?,
          avatarUrl: json['avatarUrl'] as String?,
        ),
      _ => throw const FormatException('Failed to load User.'),
    };
  }

  /// Unique user identifier.
  final String id;

  /// Email address used for login.
  final String email;

  /// Display name.
  final String name;

  /// Optional phone number.
  final String? phone;

  /// Optional avatar image URL.
  final String? avatarUrl;

  /// Creates a copy with the given fields replaced.
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  /// Converts this entity to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      if (phone != null) 'phone': phone,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
    };
  }

  @override
  List<Object?> get props => [id, email, name, phone, avatarUrl];
}
