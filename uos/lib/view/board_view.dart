import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:isus_members/view_model/board_view_model.dart';

import '../routes/app_pages.dart';

//class SplashView extends StatelessWidget  {//이것도 ok!
class BoardView extends GetView<BoardViewModel> {
  const BoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(onPressed: (){
            Get.toNamed(Routes.BOARD_WRITE);
          }, child: Text(tr('write'), style:  TextStyle(color: Colors.black, fontSize: 16)))
        ],
          centerTitle: true,
          title: Text(tr('board'))),
      body: GetBuilder<BoardViewModel>(
        init: BoardViewModel(),
        builder: (_) => Center(
          child: ListView.builder(
            itemCount: controller.boardList.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${controller.boardList[index].title}', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize:  16
                    ),),
                    SizedBox(width: 5,),
                    DateTime.now().difference(controller.boardList[index].date!).inDays.abs() < 7 ?
                    Image.asset('assets/images/new.png', width: 24,height: 18,) : Container()
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text('${controller.boardList[index].name}', style: TextStyle(color: Colors.grey),),
                    Text(' | ',style: TextStyle(color: Colors.grey)),
                    Text('${DateFormat('yyyy-MM-dd').format(controller.boardList[index].date!)}',style: TextStyle(color: Colors.grey)),
                  ],
                ),
                trailing: IconButton(
                  onPressed: (){
                    Get.toNamed('/board/detail/${controller.boardList[index].idx}');

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
