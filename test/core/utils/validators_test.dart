import 'package:bloc_starter_kit/core/utils/helpers/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    test('email accepts l10n overrides', () {
      expect(
        Validators.validateEmail(
          null,
          requiredMessage: 'REQ',
          invalidMessage: 'INV',
        ),
        'REQ',
      );
      expect(
        Validators.validateEmail('bad', invalidMessage: 'INV'),
        'INV',
      );
      expect(Validators.validateEmail('a@b.co'), isNull);
    });

    test('password and phone', () {
      expect(Validators.validatePassword('short'), isNotNull);
      expect(Validators.validatePassword('StrongPass123'), isNull);
      expect(Validators.validatePhone('123'), isNotNull);
      expect(Validators.validatePhone('+1 234 567 890'), isNull);
    });
  });
}
