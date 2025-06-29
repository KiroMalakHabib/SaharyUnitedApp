import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_icons_path.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/theme/app_color_theme_extention.dart';
import 'package:sahary_united_company_for_powers/theme/app_text_theme_extention.dart';

class ToastService {
  static final ToastService _instance = ToastService._internal();
  factory ToastService() => _instance;
  static double screenWidth = 0;

  late FToast _fToast;

  ToastService._internal();

  void init(BuildContext context) {
    _fToast = FToast();
    _fToast.init(context);
    screenWidth = MediaQuery.of(context).size.width;
  }

  void showToast({
    required String message,
    String? imagePath,
    Color? backgroundColor,
    Color? textColor,
    double? toastWidth,
    double? leftPadding,
    double? leftPaddingRatio,
    int? duration,
    IconData? iconData,
    double? iconWeight,
  }) {
    Widget toast = Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (_fToast.context != null ? Theme.of(_fToast.context!).colorScheme.text600 : AppColors.text600),
        borderRadius: BorderRadius.circular(8),
      ),
      width: toastWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (imagePath != null) ...[
            Image.asset(
              imagePath,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
          ],
          if (iconData != null) ...[
            Icon(iconData,
                size: 22,
                weight: iconWeight,
                color: _fToast.context != null ? Theme.of(_fToast.context!).colorScheme.text0 : AppColors.text600),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              message,
              style: _fToast.context != null
                  ? Theme.of(_fToast.context!)
                      .textTheme
                      .paragraphLargeMedium
                      .copyWith(color: Theme.of(_fToast.context!).colorScheme.text0)
                  : AppTextStyles.paragraphLargeMedium.copyWith(color: AppColors.text0),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );

    _fToast.removeQueuedCustomToasts();
    _fToast.showToast(
      child: toast,
      positionedToastBuilder: (context, child, gravity) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final bottomPadding = MediaQuery.of(context).padding.bottom;

        return Stack(
          children: [
            Positioned(
              bottom: 115 + keyboardHeight + bottomPadding,
              left: 18,
              right: 18,
              child: child,
            ),
          ],
        );
      },
      toastDuration: Duration(seconds: duration ?? 4),
    );
  }

  void dismissToast() {
    _fToast.removeCustomToast();
  }

  void showSuccessToast([String? message]) {
    showToast(
      message: message ?? Texts.dataSavedSuccessfully,
      backgroundColor: _fToast.context != null ? Theme.of(_fToast.context!).colorScheme.success : AppColors.success,
      iconData: Symbols.check_rounded,
      iconWeight: 900,
    );
  }

  // Predefined toast for error
  void showNetworkErrorToast() {
    showToast(
      message: Texts.failedInternetConnectionTryAgain,
      iconData: Symbols.wifi_off,
    );
  }

  void showServerErrorToast([String? message]) {
    showToast(
      message: message ?? Texts.somethingWentWrongTryAgain,
      backgroundColor: _fToast.context != null ? Theme.of(_fToast.context!).colorScheme.error : AppColors.error,
      iconData: Symbols.warning,
    );
  }

  void showTimeOutExceptionToast() {
    showToast(
      message: Texts.connectionTimeout,
      //backgroundColor: AppColors.error,
      imagePath: AppIconsPath.networkTimeoutOutline,
      toastWidth: 390,
    );
  }
}
