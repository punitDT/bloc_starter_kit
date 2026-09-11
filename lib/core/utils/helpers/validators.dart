import 'package:bloc_starter_kit/core/utils/extensions/string_ext.dart';

/// Reusable form validators.
abstract final class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!value.isEmail) return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (!value.isStrongPassword) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone is required';
    if (!RegExp(r'^[0-9+\- ]{7,15}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }
}
