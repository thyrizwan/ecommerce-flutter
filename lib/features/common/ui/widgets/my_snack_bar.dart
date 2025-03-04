import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBar {
  static void show({
    required String title,
    String? message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message ?? "Something went wrong!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: _getBackgroundColor(type),
      colorText: Colors.white,
      icon: _getIcon(type),
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      duration: duration,
    );
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return Colors.blue;
      case SnackBarType.other:
      default:
        return Colors.grey;
    }
  }

  static Icon _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const Icon(Icons.check_circle, color: Colors.white);
      case SnackBarType.error:
        return const Icon(Icons.error, color: Colors.white);
      case SnackBarType.warning:
        return const Icon(Icons.warning, color: Colors.white);
      case SnackBarType.info:
        return const Icon(Icons.info, color: Colors.white);
      case SnackBarType.other:
      default:
        return const Icon(Icons.notifications, color: Colors.white);
    }
  }
}

enum SnackBarType { success, error, warning, info, other }
