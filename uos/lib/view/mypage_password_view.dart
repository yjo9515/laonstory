import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:isus_members/view_model/mypage_password_view_model.dart';

class MyPagePasswordView extends GetView<MyPagePasswordViewModel> {
  const MyPagePasswordView({super.key});

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
                    child: Text(tr('accountModi')),
                  ),
                  Spacer(),
                ],
              )),
          automaticallyImplyLeading: false),
      body: GetBuilder<MyPagePasswordViewModel>(
        init: MyPagePasswordViewModel(),
        builder: (controller) => Container(
          decoration: BoxDecoration(),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(tr('nowPass'), style: TextStyle(fontSize: 16),),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)
                ),
                child: TextField(
                  onChanged: (value){
                    controller.password = value;
                  },

                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(child: Text(tr('newPass'), style: TextStyle(fontSize: 16))),
                  Expanded(child: Text(tr('passLength'), style: TextStyle(color: Colors.red, fontSize: 16),)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)
                ),
                child: TextField(
                  onChanged: (value){
                    controller.newPassword = value;
                  },

                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(tr('newPassCheck'), style: TextStyle(fontSize: 16)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey)
                ),
                child: TextField(
                  onChanged: (value){
                    controller.rePassword = value;
                  },

                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                    onPressed: () {
                      controller.passwordModify();
                    },
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff0D4C99)) ),
                    child: Text(tr('complete'), style: TextStyle(color: Colors.white),)
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
