import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class PrivacyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 110,
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
    );
  }
}
