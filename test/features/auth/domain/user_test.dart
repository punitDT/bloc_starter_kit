import 'package:bloc_starter_kit/features/auth/data/models/user_model.dart';
import 'package:bloc_starter_kit/features/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    const json = {
      'id': 'u1',
      'email': 'demo@example.com',
      'name': 'Demo User',
      'phone': '+1 234',
    };

    test('fromJson parses required fields via patterns', () {
      final user = User.fromJson(json);
      expect(user.id, 'u1');
      expect(user.email, 'demo@example.com');
      expect(user.name, 'Demo User');
      expect(user.phone, '+1 234');
    });

    test('fromJson throws FormatException on invalid shape', () {
      expect(() => User.fromJson(const {'bad': true}), throwsFormatException);
    });

    test('toJson round-trips', () {
      final user = User.fromJson(json);
      final out = user.toJson();
      expect(out['id'], 'u1');
      expect(User.fromJson(out), user);
    });

    test('copyWith replaces fields', () {
      const user = User(id: '1', email: 'a@b.c', name: 'A');
      expect(user.copyWith(name: 'B').name, 'B');
    });
  });

  group('UserModel', () {
    test('toEntity and fromEntity map correctly', () {
      const model = UserModel(id: '1', email: 'a@b.c', name: 'A');
      final entity = model.toEntity();
      expect(entity.id, '1');
      expect(UserModel.fromEntity(entity).toJson(), model.toJson());
    });

    test('fromJson throws on bad shape', () {
      expect(
        () => UserModel.fromJson(const {'id': 1}),
        throwsFormatException,
      );
    });
  });
}
