import '../../elements/custom_button.dart';
import '../../helpers/hex_color.dart';
import 'package:flutter/material.dart';

class DeleteAccountDialog extends StatelessWidget {
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
                            "You are going to delete your account",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("You won't be able to restore your data"),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                heightRatio: 0.055,
                                widthRatio: 0.25,
                                color: Colors.black,
                                text: "Cancel",
                                fn: () => Navigator.pop(context),
                              ),
                              SizedBox(width: 10),
                              CustomButton(
                                heightRatio: 0.055,
                                widthRatio: 0.25,
                                color: HexColor("#D97474"),
                                text: "Delete",
                                fn: () => Navigator.pop(context),
                              ),
                            ],
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
