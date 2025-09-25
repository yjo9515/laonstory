import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isus_members/view_model/login_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import './modal_view.dart';
import './widget/privacyHeader.dart';
import './widget/privacyBody.dart';

const langTypeList = [
  {
    'label': "KO",
    'value': "ko",
  },
  {
    'label': "EN",
    'value': "en",
  },
];

class LoginView extends GetView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<LoginViewModel>(
        init: LoginViewModel(),
        builder: (controller) => Container(
          child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 40)),
                    Align(
                      alignment: Alignment.topRight,
                      child: LangSelectComponent(),
                    ),
                    Spacer(),
                    Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 202,
                      height: 70,
                    ),
                    Spacer(),
                    Container(
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: tr('id'),
                            ),
                            onChanged: (value){
                              controller.id = value;
                              controller.change();
                            },
                          ),
                          TextField(
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.grey)),
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: tr('pw'),
                              ),
                              obscureText: true,
                            onChanged: (value){
                              controller.password = value;
                              controller.change();
                            },
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            margin: EdgeInsets.only(top: 10),
                            child: FilledButton(
                                onPressed: () {
                                  controller.login(controller.id, controller.password,controller.loginStatus, controller.termStatus);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll(Color(0xff0D4C99)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero)),
                                ),
                                child: Text(tr('login'))),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: controller.loginStatus,
                              onChanged: (value) {
                                controller.loginStatus = value!;
                                controller.change();
                              },
                            ),
                            Text(
                              tr('saveLoginInfo'),
                              style: context.textTheme.bodySmall,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: controller.termStatus,
                              onChanged: (value) {
                                controller.termStatus = value!;
                                controller.change();
                              },
                            ),
                            Text(
                              tr('termsAgree'),
                              style: context.textTheme.bodySmall,
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Column(children: [
                        Text(tr('accountForget')),
                        Text(tr('officeTel'))
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 80),
                      child: TextButton(
                        child: Text(tr('termsView')),
                        onPressed: () {
                          showCustomModal(
                            context,
                            PrivacyHeader(),
                            PrivacyBody(),
                          );
                        },
                      ),
                    ),
                    Spacer()
                  ],
                ),
              )),
        )),
    );
  }
}

class LangSelectComponent extends StatefulWidget {
  const LangSelectComponent({super.key});

  @override
  State<LangSelectComponent> createState() => _LangSelectComponentState();
}

class _LangSelectComponentState extends State<LangSelectComponent> {
  String? dropdownValue = langTypeList[0]['value'];

  @override
  Widget build(BuildContext context) {
    var lang = '';
    print(context.locale.toString());
    if (context.locale.toString() == 'ko_KR' || context.locale.toString() == 'ko') {
      lang = 'ko';
    } else {
      lang = 'en';
    }

    return DropdownMenu<String>(
      width: 100,
      inputDecorationTheme: InputDecorationTheme(border: InputBorder.none),
      initialSelection: lang,
      onSelected: (String? value) async {
        // This is called when the user selects an item.
        print(value);
        if (value == 'ko') {
          await EasyLocalization.of(context)!.setLocale(Locale('ko'));
          // context.setLocale(Locale('ko'));
          Get.updateLocale(Locale('ko'));
        } else {
          await EasyLocalization.of(context)!.setLocale(Locale('en'));
          // context.setLocale(Locale('en'));
          Get.updateLocale(Locale('en'));
        }
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          langTypeList.map<DropdownMenuEntry<String>>((Map value) {
        return DropdownMenuEntry<String>(
            value: value['value'], label: value['label']);
      }).toList(),
    );
  }
}

Future<void> showCustomModal(
    BuildContext context, Widget title, Widget content) async {
  await showFullDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomModal(title: title, content: content);
    },
  );
}
