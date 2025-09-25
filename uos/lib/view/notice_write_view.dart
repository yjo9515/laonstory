import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:isus_members/view_model/board_detail_view_model.dart';
import 'package:isus_members/view_model/board_write_view_model.dart';

import '../view_model/board_edit_view_model.dart';
import '../view_model/notice_write_view_model.dart';

class NoticeWriteView extends GetView<NoticeWriteViewModel> {
  NoticeWriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.close,),
        ),
      ),

      body: SingleChildScrollView(
        child: GetBuilder<NoticeWriteViewModel>(
            init: NoticeWriteViewModel(),
            builder: (_) => SafeArea(
              minimum: EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr('title'),
                      style: TextStyle(fontSize: 16,color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    controller: controller.titleController,
                    onChanged: (value){
                      controller.title = value;
                    },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        constraints: BoxConstraints(maxHeight:40),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            )),
                      )),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr('content'),
                      style: TextStyle(fontSize: 16,color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child:TextField(
                        controller: controller.contentController,
                        onChanged: (value){
                          controller.content = value;
                        },
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: null,
                      expands: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              )),
                          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              )),
                        ))
                  ),
                  SizedBox(height: 50,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 13, 76, 153)),
                      ),
                      onPressed: (){
                            controller.postWriteNotice();
                      },
                      child: Text(tr('complete'), style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}