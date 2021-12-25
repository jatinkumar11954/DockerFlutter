import '../../elements/custom_button.dart';
import 'package:flutter/material.dart';

class SuccessfulPaymentDilaog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: [
        Container(
          width: 0.85 * width,
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
                          SizedBox(height: 40),
                          Text(
                            "Done!",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Your card has been successfully charged",
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          CustomButton(
                            heightRatio: 0.06,
                            widthRatio: 0.55,
                            text: "Track My Order",
                            fn: () => Navigator.of(context)
                                .pushReplacementNamed("/TrackOrderPage"),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                left: 0.3 * width,
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
                      backgroundImage: AssetImage("assets/ok.png"),
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
