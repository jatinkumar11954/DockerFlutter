
import 'package:flutter/material.dart';

import '../main.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function fn;
  final Color color;
  final double heightRatio;
  final double widthRatio;
  final Color textColor;
  final double borderRadius;
  final TextStyle textStyle;

  CustomButton(
      {@required this.text,
      @required this.fn,
      this.color,
      this.heightRatio,
      this.textColor,
      this.widthRatio,
      this.borderRadius = 15.0,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: (heightRatio != null ? heightRatio : 0.085) *
              MediaQuery.of(context).size.height,
          width: (widthRatio != null ? widthRatio : 0.8) *
              MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: color != null ? color : primaryColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: Text(
              text,
              style: textStyle != null
                  ? textStyle
                  : Theme.of(context).textTheme.headline6.copyWith(
                        color: textColor != null ? textColor : Colors.white,
                      ),
            ),
          ),
        ),
        Positioned.fill(
            child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15.0),
            onTap: fn,
          ),
        ))
      ],
    );
  }
}
