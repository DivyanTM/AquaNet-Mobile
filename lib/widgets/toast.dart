import 'package:flutter/material.dart';

enum ToastType { success, error, warning }

void showCustomToast(BuildContext context, String message, ToastType type) {
  final icon = {
    ToastType.success: Icons.check_circle_outline,
    ToastType.error: Icons.error_outline,
    ToastType.warning: Icons.warning_outlined,
  }[type];

  final color = {
    ToastType.success: Colors.green,
    ToastType.error: Colors.redAccent,
    ToastType.warning: Colors.orangeAccent,
  }[type];

  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (_) => Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: color!.withOpacity(0.95),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
