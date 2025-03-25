import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/providers/loading_provider.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle? style;

  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LoadingService().isLoading,
      builder: (context, isLoading, _) {
        final ButtonStyle effectiveStyle = style ?? ElevatedButton.styleFrom();
        return ElevatedButton(
          style: effectiveStyle,
          onPressed: isLoading ? null : onPressed,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (true) {
                // 在載入狀態下，使用與原按鈕相同的 constraints 來顯示動畫
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Lottie.asset(
                    'assets/animation/loading.json',
                    fit: BoxFit.contain,
                  ),
                );
              }
              // 非載入狀態下顯示原按鈕內容
              return child;
            },
          ),
        );
      },
    );
  }
}
