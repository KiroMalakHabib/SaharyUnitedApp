import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';

class PartitionCard extends StatelessWidget {
  final String imageUrl;
  final String text;
  final bool showInternalShadow;
  final VoidCallback? action;

  const PartitionCard({
    super.key,
    required this.imageUrl,
    required this.text,
    this.showInternalShadow = true,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.background900.withAlpha(100),
              blurRadius: 1,
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Container(
                    color: AppColors.background200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
              errorWidget:
                  (context, url, error) => Container(
                    color: AppColors.background200,
                    child: Icon(Icons.error, color: AppColors.error),
                  ),
            ),
            if (showInternalShadow)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.secondary.withAlpha(0),
                        AppColors.secondary.withAlpha(200),
                        AppColors.background900,
                      ],
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                text,
                style: AppTextStyles.paragraphMediumBold.copyWith(
                  color: AppColors.background0,
                ),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
