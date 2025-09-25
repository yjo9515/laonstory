import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:isus_members/view/widget/static_dialog.dart';
import 'package:isus_members/view_model/board_detail_view_model.dart';
import 'package:isus_members/view_model/board_view_model.dart';

class BoardDetailView extends GetView<BoardDetailViewModel> {
  BoardDetailView({super.key});

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
      body: GetBuilder<BoardDetailViewModel>(
          init: BoardDetailViewModel(),
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
                                '${controller.board?.title}',
                                style: context.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${controller.board?.name}',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    ' | ',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  controller.board?.date != null
                                      ? Text(
                                    '${DateFormat('yyyy-MM-dd').format(controller.board!.date!)}',
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
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all<
                                          EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                      )),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: tr('reportBoard'),
                                      content: TextField(
                                    decoration: InputDecoration(
                                      hintText: tr('reportPost')
                                    ),
                                        onChanged: (value){
                                          controller.boardReport = value;
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(tr('cancel'))),
                                        TextButton(
                                            onPressed: () {
                                              controller.postReportBoard(controller.boardReport ?? '');
                                            },
                                            child: Text(tr('complete')))
                                      ],
                                    );
                                  },
                                  icon: Icon(
                                    Icons.report_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              controller.userId ==
                                  controller.board?.userIdx.toString()
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
                                          '/board/edit/${controller.board!.idx}');
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
                                        content: Text(tr('boardDel')),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                controller.deleteBoard(
                                                    controller
                                                        .board?.idx);
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
                      padding: EdgeInsets.all(16),
                      color: Color.fromARGB(255, 246, 246, 246),
                      child: Text(
                          '${controller.board?.content ?? '내용이 존재하지않습니다'}'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 221, 221, 221))),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('comment'),
                            style: TextStyle(
                                color: Color.fromARGB(255, 13, 76, 153),
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                onChanged: (value) {
                                  controller.comment = value;
                                },
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  hintText: tr('commentWrite'),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  constraints: BoxConstraints(maxHeight: 40),
                                  border: OutlineInputBorder(),
                                ),
                              )),
                              TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 13, 76, 153)),
                                ),
                                onPressed: () {
                                  controller
                                      .postBoardComment(controller.comment);
                                },
                                child: Text(
                                  tr('regi'),
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: controller.commentList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: IconButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                      )),
                                      onPressed: () {
                                        Get.defaultDialog(
                                          title: tr('reportUser'),
                                          content: TextField(
                                            decoration: InputDecoration(
                                                hintText: tr('reportPost')
                                            ),
                                            onChanged: (value){
                                              controller.report = value;
                                            },
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text(tr('cancel'))),
                                            TextButton(
                                                onPressed: () {
                                                  controller.postReportUser(controller.report ?? '', index);
                                                },
                                                child: Text(tr('complete')))
                                          ],
                                        );
                                      },

                                      icon: Icon(
                                        Icons.report_outlined,
                                        color: Colors.red,
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        Text(
                                          '${controller.commentList[index].name}',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                        Text(' | ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14)),
                                        Text(
                                            '${DateFormat('yyyy-MM-dd').format(controller.commentList[index].date!)}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14)),
                                      ],
                                    ),
                                    subtitle: controller.patchList[index] ==
                                            true
                                        ? TextField(
                                            onChanged: (value) {
                                              controller.comment = value;
                                            },
                                          )
                                        : Text(
                                            '${controller.commentList[index].content}',
                                            style: TextStyle(fontSize: 16)),
                                    trailing: SizedBox(
                                      width: 130,
                                      child: controller
                                                  .commentList[index].userIdx
                                                  .toString() ==
                                              controller.userId
                                          ? Row(
                                              children: [
                                                controller.patchList[index] ==
                                                        false
                                                    ? TextButton(
                                                        style: ButtonStyle(
                                                            padding:
                                                                MaterialStateProperty
                                                                    .all<
                                                                        EdgeInsets>(
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0,
                                                              vertical: 0),
                                                        )),
                                                        onPressed: () {
                                                          controller
                                                              .togglePatch(
                                                                  index);
                                                        },
                                                        child: Text(
                                                          tr('modi'),
                                                          style: context
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      )
                                                    : TextButton(
                                                        style: ButtonStyle(
                                                            padding:
                                                                MaterialStateProperty
                                                                    .all<
                                                                        EdgeInsets>(
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0,
                                                              vertical: 0),
                                                        )),
                                                        onPressed: () {
                                                          controller
                                                              .patchBoardComment(
                                                                  controller
                                                                      .comment,
                                                                  index);
                                                        },
                                                        child: Text(
                                                          tr('complete'),
                                                          style: context
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                TextButton(
                                                  style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all<EdgeInsets>(
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 0),
                                                  )),
                                                  onPressed: () {
                                                    controller
                                                        .deleteBoardComment(
                                                            index);
                                                  },
                                                  child: Text(
                                                    tr('del'),
                                                    style: context
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Row(),
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromARGB(255, 221, 221, 221),
                                  )
                                ],
                              );
                            }))
                  ],
                ),
              )),
    );
  }
}
