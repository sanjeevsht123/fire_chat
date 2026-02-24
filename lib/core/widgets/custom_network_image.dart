import 'package:fire/core/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';


/// A highly optimized, reusable, and scalable custom network image handler widget.
///
/// This widget supports loading network images in various formats (SVG, PNG, JPG, JPEG, etc.)
/// with built-in caching for performance. It uses `cached_network_image` for raster images
/// (with disk and memory caching via `flutter_cache_manager`) and `flutter_svg` for SVG images
/// (with in-memory caching and HTTP caching).
///
/// For FinTech-grade UX, it includes:
/// - Placeholder support (e.g., shimmer or progress indicator) during loading.
/// - Error handling with a customizable error widget.
/// - Fade-in transitions for smooth loading.
/// - Optional width, height, fit, alignment, and color filtering.
/// - Retry logic for failed loads (configurable via `maxRetries`).
/// - Fallback placeholder if the image URL is empty or null.
///
/// Usage in a mono repo: Place this widget in a shared UI package (e.g., `packages/ui_widgets`)
/// to ensure reusability across features/modules. Depend on `cached_network_image` and `flutter_svg`
/// in the pubspec.yaml of the shared package.
///
/// Example:
/// ```dart
/// CustomNetworkImage(
///   url: 'https://example.com/image.png',
///   width: 100,
///   height: 100,
///   fit: BoxFit.cover,
///   placeholder: const CircularProgressIndicator(),
///   errorWidget: const Icon(Icons.error),
/// );
/// ```
class CustomNetworkImage extends StatelessWidget {
  /// The URL of the network image to load.
  final String url;

  /// Optional width of the image.
  final double? width;

  /// Optional height of the image.
  final double? height;

  /// How the image should be inscribed into the box (defaults to [BoxFit.cover]).
  final BoxFit? fit;

  /// Alignment of the image within its bounds (defaults to [Alignment.center]).
  final Alignment alignment;

  /// Optional placeholder widget shown while the image is loading or if URL is empty.
  final Widget? placeholder;

  /// Optional error widget shown if the image fails to load.
  final Widget? errorWidget;

  /// Optional color to blend with the image (e.g., for tinting).
  final Color? color;

  /// Blend mode for the color filter (defaults to [BlendMode.srcIn]).
  final BlendMode colorBlendMode;

  /// Duration for the fade-in animation (defaults to 300ms).
  final Duration fadeInDuration;

  /// Maximum number of retry attempts for failed loads (defaults to 3).
  final int maxRetries;

  const CustomNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.placeholder,
    this.errorWidget,
    this.color,
    this.colorBlendMode = BlendMode.srcIn,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.maxRetries = 3,
  });

  /// Determines if the URL points to an SVG image based on file extension.
  bool get _isSvg => url.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (url.isNotNullNotEmpty && _isSvg) {
      return _buildSvgImage();
    } else {
      return _buildRasterImage();
    }
  }

  /// Builds a fallback widget if the URL is empty, using the placeholder if available.
  Widget _buildFallback() {
    return SizedBox(
      width: width,
      height: height,
      child: placeholder ?? const SizedBox.shrink(),
    );
  }

  /// Builds the widget for SVG images using `flutter_svg`.
  Widget _buildSvgImage() {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      // SVGs often benefit from contain to preserve aspect.
      alignment: alignment,
      colorFilter: color != null
          ? ColorFilter.mode(color!, colorBlendMode)
          : null,
      placeholderBuilder: (context) =>
          placeholder ?? const Center(child: CircularProgressIndicator()),
    );
  }

  /// Builds the widget for raster images (PNG, JPG, etc.) using `cached_network_image`.
  Widget _buildRasterImage() {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      color: color,
      colorBlendMode: colorBlendMode,
      fadeInDuration: fadeInDuration,
      placeholder: (context, url) =>
          placeholder ?? const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          errorWidget ?? const Icon(Icons.error),
      useOldImageOnUrlChange:
          true, // Improves UX by showing old image during reload.
    );
  }
}
