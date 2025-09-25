import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

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
                  tr('privacyPolicy'),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Spacer()
            ],
          )),
        automaticallyImplyLeading: false
    ) ,
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 600,
            decoration: BoxDecoration(),
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('privacyPolicy')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policyTitle1')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policyContent1')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policySubTitle1')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policySubContent1')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policySubTitle2')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policySubContent2')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policySubTitle3')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policyTitle2')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policySubTitle4')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policySubContent4')),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tr('policySubTitle5')),
                ),
              ],
            )),
      ),
    ) ;
  }
}
