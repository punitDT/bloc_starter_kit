import 'package:equatable/equatable.dart';

/// Editable user profile entity.
class Profile extends Equatable {
  /// Creates a new profile.
  const Profile({
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.address,
  });

  /// Creates a profile from a JSON map.
  ///
  /// Throws a [FormatException] if required keys are missing.
  factory Profile.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'name': final String name, 'email': final String email} => Profile(
          name: name,
          email: email,
          phone: json['phone'] as String?,
          avatarUrl: json['avatarUrl'] as String?,
          address: json['address'] as String?,
        ),
      _ => throw const FormatException('Failed to load Profile.'),
    };
  }

  /// Display name.
  final String name;

  /// Email address.
  final String email;

  /// Optional phone number.
  final String? phone;

  /// Optional avatar image URL.
  final String? avatarUrl;

  /// Optional postal address.
  final String? address;

  /// Creates a copy with the given fields replaced.
  Profile copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    String? address,
  }) {
    return Profile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
    );
  }

  /// Converts this profile to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      if (phone != null) 'phone': phone,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (address != null) 'address': address,
    };
  }

  @override
  List<Object?> get props => [name, email, phone, avatarUrl, address];
}
