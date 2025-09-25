import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:isus_members/domain/model/social_model.dart';
import 'package:isus_members/routes/app_pages.dart';

import '../view_model/social_view_model.dart';
import './modal_view.dart';

class SocialView extends GetView<SocialViewModel> {
  const SocialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: GetBuilder<SocialViewModel>(
            init: SocialViewModel(),
            builder: (controller) => Center(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(tr('community')),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child:
                      controller.role == 'ADMIN' ?
                      Container(
                          width: 36,
                          height: 36,
                          child: IconButton(
                            icon: Image(
                                image: AssetImage('assets/images/modify.png'),
                                width: 36,
                                height: 36),
                            onPressed: () {
                              Get.toNamed(Routes.SOCIAL_MODIFY_LIST);
                            },
                          )) : Container(),
                    ),
                  ],
                )),
          ),
          automaticallyImplyLeading: false),
      body: GetBuilder<SocialViewModel>(
        init: SocialViewModel(),
        builder: (_) => SingleChildScrollView(
          child: Center(
              child: Column(
                // decoration: BoxDecoration(color: Colors.grey[200]),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Image(
                              image: AssetImage('assets/images/logo.png'),
                              width: 200,
                              height: 80),
                          Center(
                            child: Column(
                              children: [

                                Center(
                                  child: TextButton(
                              onPressed: () {
                          controller.homePageMove();
                          },
                              child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        tr('homepage'),
                                        style:
                                        TextStyle(color: Colors.black),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                      )
                                    ],
                                  ))),

                                ),

                                Center(
                                  child: TextButton(
                                      onPressed: () {
                                        controller.homePageEnMove();
                                      },
                                      child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                tr('homepageEn'),
                                                style:
                                                TextStyle(color: Colors.black),
                                              ),
                                              Icon(
                                                Icons.chevron_right,
                                              )
                                            ],
                                          ))),
                                ),
                                SizedBox(height: 20),
                                Text(tr('createBy')),
                                SizedBox(height: 20),
                                Text(tr('thankYou')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                color: Colors.grey,
                              ))),
                      padding: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: controller.communityList.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                        '${controller.communityList[index].content}'),
                                  ),
                                  SizedBox(
                                      width: (MediaQuery.of(context).size.width / 2) -
                                          16,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: controller
                                              .communityList[index].sns!
                                              .map((e) => IconButton(
                                              onPressed: () {
                                                controller.snsPageLink(e?['url']);
                                              },
                                              icon: Image(
                                                  image: AssetImage(
                                                      'assets/images/${e?['social']}.png'),
                                                  width: 40,
                                                  height: 40)))
                                              .toList(),
                                        ),
                                      )),
                                ],
                              ));
                        },
                      ),
                    ),
                  ])),
        ),
      ),
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
