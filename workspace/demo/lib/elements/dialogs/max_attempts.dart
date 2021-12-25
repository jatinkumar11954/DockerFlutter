import '../../elements/custom_button.dart';
import 'package:flutter/material.dart';

class MaxAttemptsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: [
        Container(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            "You reached out maximum amount of attempts. Please try later.",
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          CustomButton(
                            heightRatio: 0.06,
                            widthRatio: 0.55,
                            color: Colors.black,
                            text: "Okay",
                            fn: () => Navigator.pushReplacementNamed(
                                context, "/WalkThroughPage"),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.black.withOpacity(0.05),
                            offset: Offset(0.0, 2.0),
                            spreadRadius: 5.0)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      maxRadius: 25,
                      backgroundImage: AssetImage("assets/alert.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
