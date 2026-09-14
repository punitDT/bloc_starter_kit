import 'package:bloc_starter_kit/core/utils/extensions/string_ext.dart';

/// Reusable form validators.
///
/// Pass localized strings from `context.l10n` so messages respect the
/// active locale. Defaults are English for tests and non-UI call sites.
abstract final class Validators {
  /// Validates an email field.
  static String? validateEmail(
    String? value, {
    String requiredMessage = 'Email is required',
    String invalidMessage = 'Enter a valid email',
  }) {
    if (value == null || value.isEmpty) return requiredMessage;
    if (!value.isEmail) return invalidMessage;
    return null;
  }

  /// Validates a password field.
  static String? validatePassword(
    String? value, {
    String requiredMessage = 'Password is required',
    String weakMessage = 'Password must be at least 8 characters',
  }) {
    if (value == null || value.isEmpty) return requiredMessage;
    if (!value.isStrongPassword) return weakMessage;
    return null;
  }

  /// Validates a required text field.
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  /// Validates a phone field.
  static String? validatePhone(
    String? value, {
    String requiredMessage = 'Phone is required',
    String invalidMessage = 'Enter a valid phone number',
  }) {
    if (value == null || value.isEmpty) return requiredMessage;
    if (!RegExp(r'^[0-9+\- ]{7,15}$').hasMatch(value)) {
      return invalidMessage;
    }
    return null;
  }
}
