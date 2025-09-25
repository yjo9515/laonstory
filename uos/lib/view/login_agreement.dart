import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PrivacyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar : AppBar(
      title: Container(
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
              Spacer()
            ],
          )),
    ) , body: Container(
        width: MediaQuery.of(context).size.width,
        height: 600,
        decoration: BoxDecoration(),
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(tr('preTerms')),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(tr('terms1')),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(tr('terms2')),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(tr('terms3')),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(tr('terms4')),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(tr('terms5')),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(tr('terms6')),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(tr('terms7')),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(tr('terms8')),
            ),
          ],
        )),
    ) ;
  }
}
