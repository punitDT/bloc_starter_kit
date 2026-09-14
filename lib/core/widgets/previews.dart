import 'package:bloc_starter_kit/core/theme/app_spacing.dart';
import 'package:bloc_starter_kit/core/widgets/buttons/primary_button.dart';
import 'package:bloc_starter_kit/core/widgets/buttons/secondary_button.dart';
import 'package:bloc_starter_kit/core/widgets/inputs/app_text_field.dart';
import 'package:bloc_starter_kit/core/widgets/layout/max_width_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// Primary button preview (light).
@Preview(name: 'PrimaryButton', group: 'Buttons')
Widget primaryButtonPreview() {
  return const Scaffold(
    body: Center(
      child: PrimaryButton(onPressed: null, label: 'Login'),
    ),
  );
}

/// Secondary button preview.
@Preview(name: 'SecondaryButton', group: 'Buttons')
Widget secondaryButtonPreview() {
  return const Scaffold(
    body: Center(
      child: SecondaryButton(onPressed: null, label: 'Register'),
    ),
  );
}

/// Text field preview.
@Preview(name: 'AppTextField', group: 'Inputs')
Widget appTextFieldPreview() {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: AppTextField(
        controller: TextEditingController(),
        label: 'Email',
        prefixIcon: const Icon(Icons.email_outlined),
      ),
    ),
  );
}

/// Constrained form layout preview.
@Preview(name: 'MaxWidthContainer', group: 'Layout')
Widget maxWidthContainerPreview() {
  return const Scaffold(
    body: MaxWidthContainer(
      child: Text('Constrained content'),
    ),
  );
}
