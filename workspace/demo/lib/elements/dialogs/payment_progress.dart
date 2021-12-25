import 'dart:async';

import '../../elements/dialogs/successful_payment.dart';
import 'package:flutter/material.dart';


class PaymentProgressDialog extends StatefulWidget {
  @override
  _PaymentProgressDialogState createState() => _PaymentProgressDialogState();
}

class _PaymentProgressDialogState extends State<PaymentProgressDialog> {
  Color get primaryColor => null;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => SuccessfulPaymentDilaog(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SimpleDialog(
      elevation: 0,
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
                    width: 0.8 * width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Text(
                            "Payment is in progress",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text("Please wait a few moments")
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
                      padding: const EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation(primaryColor),
                      )),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
