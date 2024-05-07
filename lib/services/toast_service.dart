import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:toastification/toastification.dart';

enum ToastType { success, error, info }

abstract class Toast {
  void showMessage({required BuildContext context, required String title, required String message, required ToastType type});
}

@Singleton(as: Toast)
class Toastify implements Toast {
  @override
  void showMessage({required BuildContext context, required String title, required String message, required ToastType type}) {
    toastification.show(
      context: context,
      type: type == ToastType.info
          ? ToastificationType.info
          : (type == ToastType.success)
              ? ToastificationType.success
              : ToastificationType.error,
      title: Text(title),
      description: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 6),
    );
  }
}
