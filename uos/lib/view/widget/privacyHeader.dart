import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class PrivacyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close)),
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Text(
                tr('terms'),
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Spacer(),
          ],
        ));
  }
}
