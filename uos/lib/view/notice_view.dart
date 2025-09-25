import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:isus_members/view_model/address_view_model.dart';
import 'package:isus_members/view_model/notice_view_model.dart';

import '../routes/app_pages.dart';

class NoticeView extends GetView<NoticeViewModel> {
  const NoticeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton(onPressed: (){
              Get.toNamed(Routes.NOTICE_WRITE);
            }, child: Text(tr('write'), style:  TextStyle(color: Colors.black, fontSize: 16)))
          ],
          centerTitle: true,
          title: Text(tr('notice'))),
      body: GetBuilder<NoticeViewModel>(
        init: NoticeViewModel(),
        builder: (_) => Center(
          child: ListView.builder(
            itemCount: controller.noticeList.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${controller.noticeList[index].title}', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize:  16
                    ),),
                    SizedBox(width: 5,),
                    DateTime.now().difference(controller.noticeList[index].date!).inDays.abs() < 7 ?
                    Image.asset('assets/images/new.png', width: 24,height: 18,) : Container()
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text('${controller.noticeList[index].name}', style: TextStyle(color: Colors.grey),),
                    Text(' | ',style: TextStyle(color: Colors.grey)),
                    Text('${DateFormat('yyyy-MM-dd').format(controller.noticeList[index].date!)}',style: TextStyle(color: Colors.grey)),
                  ],
                ),
                trailing: IconButton(
                  onPressed: (){
                    Get.toNamed('/notice/detail/${controller.noticeList[index].idx}');

                  },
                  icon: Icon(Icons.chevron_right),
                ),
              );
            },
          ),
          // child: Container(),
        ),
      ),
    );
  }
}
