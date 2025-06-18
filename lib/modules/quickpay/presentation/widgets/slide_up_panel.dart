import 'package:flutter/material.dart';

slideUpPanel(
  context,
  screen, {
  bool canDismiss = true,
  VoidCallback? onDismiss,
}) async {
  await showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    context: context,
    isDismissible: canDismiss,
    enableDrag: canDismiss,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ScrollConfiguration(
          behavior: RemoveScrollGlow(),
          child: SingleChildScrollView(
            child: Container(
              child: screen,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.70,
              ),
            ),
          ),
        ),
      );
    },
  );
  if (onDismiss != null) {
    onDismiss();
  }
}

class RemoveScrollGlow extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
