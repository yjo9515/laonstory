import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SnsAddHeader extends StatelessWidget {
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

          ],
        ));
  }
}
