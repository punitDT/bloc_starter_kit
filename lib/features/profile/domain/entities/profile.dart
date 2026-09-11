import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.address,
  });

  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final String? address;

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

  @override
  List<Object?> get props => [name, email, phone, avatarUrl, address];
}
