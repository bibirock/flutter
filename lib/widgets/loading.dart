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
        return ElevatedButton(
          style: style,
          onPressed: isLoading ? null : onPressed,
          child: Container(
              alignment: Alignment.center,
              child: isLoading
                  ? Lottie.asset(
                      'assets/animation/loading.json',
                      fit: BoxFit.fill,
                      width: 100,
                      height: 70,
                    )
                  : child),
        );
      },
    );
  }
}
