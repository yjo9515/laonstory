import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:isus_members/view_model/mypage_view_model.dart';
import '../domain/api/api_url.dart';

import '../routes/app_pages.dart';

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

class MypageView extends GetView<MyPageViewModel> {
  const MypageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Text('MyPage'),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Image(
                            image: AssetImage('assets/images/option.png')),
                        onPressed: () {
                          Get.toNamed(Routes.MYPAGE_PASSWORD);
                        },
                      ),
                    ),
                  ],
                )),
            automaticallyImplyLeading: false),
        body: GetBuilder<MyPageViewModel>(
          init: MyPageViewModel(),
          builder: (controller) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 60,
            decoration: BoxDecoration(),
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(),
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child:
                            controller.user?.imgPath != null && controller.user!.imgPath!.isNotEmpty?
                            Image(
                              fit: BoxFit.fill,
                              image:
                            NetworkImage(
                              '$serverUrl/user/profile/${controller.user?.imgPath}',
                            ),
                              errorBuilder: (context, object, e) {
                                return Image.asset('assets/images/person.jpg', width: 80, height: 80,);
                              },
                          ) : Image.asset('assets/images/person.jpg', width: 80, height: 80,),
                        )),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: (MediaQuery.of(context).size.width) / 2,
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                controller.user?.name ?? '',
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                Get.toNamed('/mypage/modify/${controller.user?.idx}');
                              },
                              icon: Image(
                                image: AssetImage('assets/images/modify.png'),
                                width: 24,
                                height: 24,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('name'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(controller.user?.name ?? '')),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('nickname'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(controller.user?.nickname ?? '')),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('mail'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(controller.user?.email ?? '')),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('tell'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(controller.user?.phone ?? '')),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('birth'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: controller.user?.birthday != null ? Text(DateFormat('yyyy-MM-dd').format(controller.user!.birthday!)) : Text('')),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('nation'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(controller.user?.country ?? '')),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('city'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(controller.user?.city ?? '')),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('affiliation'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            Expanded(
                              child: SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      maxLines: null,
                                      controller.user?.affiliation ?? '')),
                            ),)
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('dept'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(controller.user?.dept ?? '')),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('position'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(controller.user?.position ?? '')),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('major'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(controller.user?.major ?? '')),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tr('admission'),
                                    style: TextStyle(color: Colors.black45),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(controller.user?.admission ?? '', softWrap: true,)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width / 3) - (32 / 3),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(width: 1, color: Colors.grey)),
                            ),
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width / 3) - (32 / 3),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('SNS', style: TextStyle(color: Colors.grey),),
                              ),

                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width / 3) - (32 / 3),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(width: 1, color: Colors.grey)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: (MediaQuery.of(context).size.width),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: (controller.user != null && controller.user!.sns!.isNotEmpty && controller.user?.sns != []) ? Row(
                                children: controller.user!.sns
                                    !.map((e) => IconButton(
                                    onPressed: () {
                                      controller.snsPageLink(e?.url);
                                    },
                                    icon: Image(
                                        image: AssetImage(
                                            'assets/images/${e?.social}.png'),
                                        width: 40,
                                        height: 40)))
                                    .toList(),
                              ) : Row(),
                            )),
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(width: 1, color: Colors.grey)),
                              color: Colors.grey[200]),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.grey))),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      child: Image(
                                        image:
                                        AssetImage('assets/images/language.png'),
                                        width: 36,
                                        height: 36,
                                      ),
                                    ),
                                    Text(
                                      tr('language'),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: LangSelectComponent(),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.grey))),
                                height: 60,
                                child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.MYPAGE_PRIVACY);
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          child: Image(
                                            image:
                                            AssetImage('assets/images/terms.png'),
                                            width: 36,
                                            height: 36,
                                          ),
                                        ),
                                        Text(
                                          tr('privacy'),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(),
                                height: 60,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Colors.grey[200]),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(0)))),
                                    onPressed: () {
                                      controller.logout();
                                    },
                                    child: Text(tr('logout'),
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black))),
                              ),
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(width: 1, color: Colors.grey)),
                                    color: Colors.grey[200]),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(),
                                height: 60,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Colors.grey[200]),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(0)))),
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: tr('memberOut'),
                                        content: Text(tr('memberOutText')),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(tr('cancel'))),
                                          TextButton(
                                              onPressed: () {
                                                controller.memberOut();
                                                Get.back();
                                              },
                                              child: Text(tr('complete')))
                                        ],
                                      );
                                    },
                                    child: Text(tr('memberOut'),
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black))),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
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
