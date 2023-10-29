import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/spaces.dart';

showTopMessage({
  required String message,
  String? title,
  IconData? iconPath,
  Color? color,
  VoidCallback? onClose,
  Duration duration = const Duration(seconds: 5),
}) {
  BotToast.showCustomNotification(
      duration: duration,
      onClose: onClose,
      backButtonBehavior: BackButtonBehavior.close,
      toastBuilder: (_) {
        return Container(
          width: 600,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colorBlack.withOpacity(0.1),
                blurRadius: 3.0,
                // has the effect of softening the shadow
                spreadRadius: 2.0,
                // has the effect of extending the shadow
                offset: const Offset(
                  0.0, // horizontal, move right
                  4.0, // vertical, move down
                ),
              ),
            ],
            color: color ?? colorPrimary,
            border: Border.all(color: colorTransparent),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          margin: const EdgeInsets.all(16),
          height: title != null ? 56 + 40 : 56,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spaces.horizontal15(),
              if (iconPath != null)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: colorWhite,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Icon(
                    iconPath,
                    color: colorWhite,
                    size: 16.0,
                  ),
                ),
              if (iconPath != null) Spaces.horizontal15(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(
                        title,
                        style: const TextStyle(color: colorWhite),
                      ),
                    if (title != null) Spaces.vertical10(),
                    Text(
                      message,
                      style: const TextStyle(color: colorWhite),
                    ),
                  ],
                ),
              ),
              Spaces.horizontal15(),
              _buildCloseButton(),
            ],
          ),
        );
      });
}

/// Shows the given [message] with an [Resources.images.ic_check] icon next
/// to it. Indicates operation has succeeded.
void showTopSuccessMessage({
  required String message,
  Duration duration = const Duration(seconds: 5),
}) {
  showTopMessage(
    message: message,
    iconPath: Icons.check_rounded,
    duration: duration,
    color: colorAccent,
  );
}

/// Shows the given [message] with an [Icons.error] next to it in
/// [Colors.red]. Indicates operation has failed.
void showTopErrorMessage({
  required String message,
  Duration duration = const Duration(seconds: 5),
}) {
  showTopMessage(
    message: message,
    iconPath: Icons.error,
    duration: duration,
    color: colorRed,
  );
}

Widget _buildCloseButton() {
  return Material(
    color: colorTransparent,
    child: InkWell(
      splashColor: colorTransparent,
      highlightColor: colorTransparent,
      hoverColor: colorTransparent,
      onTap: () {
        BotToast.cleanAll();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(
          Icons.close,
          color: colorWhite,
          size: 16.0,
        ),
      ),
    ),
  );
}