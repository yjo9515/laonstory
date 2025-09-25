import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:isus_members/view_model/board_detail_view_model.dart';

import '../view_model/notice_detail_view_model.dart';

class NoticeDetailView extends GetView<NoticeDetailViewModel> {
  NoticeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 76, 153),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<NoticeDetailViewModel>(
          init: NoticeDetailViewModel(),
          builder: (_) => SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      color: Color.fromARGB(255, 13, 76, 153),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${controller.notice?.title}',
                                style: context.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${controller.notice?.name}',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    ' | ',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  controller.notice?.date != null
                                      ? Text(
                                    '${DateFormat('yyyy-MM-dd').format(controller.notice!.date!)}',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  )
                                      : Text('')
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              controller.userStatus == 'ADMIN'
                                  ? Row(
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty
                                            .all<EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                        )),
                                    onPressed: () {
                                      Get.toNamed(
                                          '/notice/edit/${controller.notice!.idx}');
                                    },
                                    child: Text(
                                      tr('modi'),
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    '|',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty
                                            .all<EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                        )),
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: tr('alert'),
                                        content: Text(tr('noticeDel')),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                controller.deleteNotice(
                                                    controller
                                                        .notice?.idx);
                                              },
                                              child: Text(tr('yes'))),
                                          TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(tr('no')))
                                        ],
                                      );
                                    },
                                    child: Text(
                                      tr('del'),
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                                  : Row(),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 180,
                      padding: EdgeInsets.all(16),
                      color: Color.fromARGB(255, 246, 246, 246),
                      child: Text(
                          '${controller.notice?.content ?? '내용이 존재하지않습니다'}'),
                    ),
                  ],
                ),
              )),
    );
  }
}
