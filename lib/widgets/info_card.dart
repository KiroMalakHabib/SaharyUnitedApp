import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';

class InfoCard extends StatefulWidget {
  final String title;
  final String content;
  final String iconPath;
  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.iconPath,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8, right: 8),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.neutral,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text.trim(),
            style: AppTextStyles.paragraphMediumLight.copyWith(
              color: AppColors.neutral,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (widget.content.contains('\n')) {
      List<String> bulletPoints = widget.content.split('\n').where((line) => line.trim().isNotEmpty).toList();
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: bulletPoints.map((point) => _buildBulletPoint(point)).toList(),
      );
    } else {
      return Text(
        widget.content,
        style: AppTextStyles.paragraphMediumLight.copyWith(
          color: AppColors.neutral,
        ),
        maxLines: null,
        overflow: TextOverflow.visible,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: AppTextStyles.titleH1Light.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 17),
                _buildContent(),
              ],
            ),
          ),
          SizedBox(width: 15),
          SvgPicture.asset(widget.iconPath, width: 100, height: 100),
        ],
      ),
    );
  }
}