import 'package:flutter/material.dart';

//通过组合自动以widget
class GradientButton extends StatelessWidget {
  final double? width, height;

  final List<Color>? colors;
  final Widget? child;
  final BorderRadius? borderRadius;

  final EdgeInsetsGeometry? childPadding;
  final GestureDragCancelCallback? onPressed;

  GradientButton(
      {this.width,
      this.height,
      this.colors,
      @required this.child,
      this.childPadding,
      this.borderRadius,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    final List<Color> _colors =
        colors ?? [themeData.primaryColor, themeData.primaryColor];
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: themeData.primaryColorDark,
          //_colors.last,
          highlightColor: themeData.primaryColorDark,
          //_colors.last,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: childPadding ?? EdgeInsets.all(12.0),
                child: DefaultTextStyle(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    child: child ?? Container()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
