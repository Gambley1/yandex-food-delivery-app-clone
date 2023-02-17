import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papa_burger/src/restaurant.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

enum CacheImageType {
  bigImage,
  smallImage,
}

enum InkEffect {
  withEffect,
  noEffect,
}

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    required this.imageType,
    required this.inkEffect,
    this.width = 100,
    this.height = 100,
    this.bottom = 0,
    this.left = 20,
    this.top = 20,
    this.right = 0,
    this.radius = kDefaultBorderRadius,
    this.sizeXMark = 18,
    this.sizeSimpleIcon = 32,
  });

  final String imageUrl;
  final double height,
      width,
      top,
      left,
      right,
      bottom,
      sizeXMark,
      sizeSimpleIcon,
      radius;
  final CacheImageType imageType;
  final InkEffect inkEffect;

  @override
  Widget build(BuildContext context) {
    return imageType == CacheImageType.smallImage
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            cacheManager: CacheManager(
              Config(
                'smallmageCacheKey',
                stalePeriod: const Duration(
                  days: 1,
                ),
              ),
            ),
            imageBuilder: (context, imageProvider) => inkEffect == InkEffect.noEffect ? Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ) : Ink(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => ShimmerLoading(
              radius: kDefaultBorderRadius,
              width: width,
              height: height,
            ),
            errorWidget: (context, url, error) {
              // logger.d(error.toString());
              return Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    radius,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: left,
                      top: top,
                      child: CustomIcon(
                        icon: FontAwesomeIcons.circleXmark,
                        type: IconType.simpleIcon,
                        size: sizeXMark,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomIcon(
                        icon: FontAwesomeIcons.images,
                        type: IconType.simpleIcon,
                        size: sizeSimpleIcon,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : CachedNetworkImage(
            imageUrl: imageUrl,
            cacheManager: CacheManager(
              Config(
                'bigImageCacheKey',
                stalePeriod: const Duration(
                  days: 1,
                ),
              ),
            ),
            imageBuilder: (context, imageProvider) => ShadowOverlay(
              shadowHeight: 100,
              shadowWidth: 800,
              shadowColor: Colors.cyan.shade400,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            placeholder: (context, url) => const ShimmerLoading(),
            placeholderFadeInDuration: const Duration(seconds: 2),
            errorWidget: (context, url, error) {
              // logger.d(error.toString());
              return const Center(
                child: KText(
                  text: 'Error',
                ),
              );
            },
          );
  }
}
