import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    required this.url,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, _) => Container(
          color: context.colorScheme.surfaceContainerHighest,
        ),
        errorWidget: (context, url, error) => ColoredBox(
          color: context.colorScheme.surfaceContainerHighest,
          child: Icon(Icons.broken_image, color: context.colorScheme.outline),
        ),
      ),
    );
    return image;
  }
}
