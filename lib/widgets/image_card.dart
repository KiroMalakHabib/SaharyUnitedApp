import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';

class ImageCard extends StatefulWidget {
  final String imageUrl;
  final VoidCallback? action;
  final String? title;
  final String? subTitle;

  const ImageCard({
    super.key,
    required this.imageUrl,
    this.title,
    this.subTitle,
    this.action,
  });

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool get hasText => widget.title != null || widget.subTitle != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background0,
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: hasText ? 7 : 10,
              child: SizedBox(
                width: double.infinity,
                child:
                    widget.imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          fit: BoxFit.contain,
                          placeholder:
                              (context, url) => Container(
                                color: Colors.grey[100],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                color: AppColors.neutral200,
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: AppColors.neutral300,
                                  size: 50,
                                ),
                              ),
                          fadeInDuration: Duration(milliseconds: 300),
                          fadeOutDuration: Duration(milliseconds: 100),
                        )
                        : Container(
                          color: AppColors.neutral200,
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.neutral300,
                            size: 50,
                          ),
                        ),
              ),
            ),
            if (hasText)
              Container(
                height: 60,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: AppColors.background0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.title != null && widget.title!.isNotEmpty)
                      Text(
                        widget.title!,
                        style: AppTextStyles.paragraphMediumBold.copyWith(
                          color: AppColors.secondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (widget.subTitle != null && widget.subTitle!.isNotEmpty)
                      Text(
                        widget.subTitle!,
                        style: AppTextStyles.paragraphSmallMedium.copyWith(
                          color: AppColors.secondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
