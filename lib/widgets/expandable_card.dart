import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final String content;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? contentColor;
  final Color? iconColor;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const ExpandableCard({
    super.key,
    required this.title,
    required this.content,
    this.backgroundColor,
    this.titleColor,
    this.contentColor,
    this.iconColor,
    this.titleStyle,
    this.contentStyle,
    this.padding,
    this.borderRadius,
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.background0,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
        border: Border.all(color: AppColors.background0),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withAlpha(100),
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleExpansion,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style:
                          widget.titleStyle ??
                          AppTextStyles.paragraphLargeMedium.copyWith(
                            color: widget.titleColor ?? Colors.black87,
                          ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: widget.iconColor ?? AppColors.secondary,
                      size: 24,
                      weight: 900,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          SizeTransition(
            sizeFactor: _expandAnimation,
            axisAlignment: -1,
            child: Container(
              width: double.infinity,
              padding:
                  widget.padding ?? const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Text(
                    widget.content,
                    style:
                        widget.contentStyle ??
                        AppTextStyles.paragraphLargeMedium_2.copyWith(
                          color: widget.contentColor ?? AppColors.secondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
