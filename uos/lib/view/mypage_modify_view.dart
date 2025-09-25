import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isus_members/view_model/mypage_modify_view_model.dart';

import '../domain/api/api_url.dart';
import '../type/emuns.dart';

class MyPageModifyView extends GetView<MyPageModifyViewModel> {
  const MyPageModifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.close,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<MyPageModifyViewModel>(
          init: MyPageModifyViewModel(),
          builder: (controller){
            return Padding(

              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr('profilePic'),
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        controller.pickImage(ImageSource.gallery);
                      },
                      icon:
                      controller.image == null && controller.user?.imgPath != null
                          ? Image(
                        width: 80,
                        height: 80,
                        errorBuilder: (context, object, e) {
                          return Image.asset('assets/images/person.jpg', width: 80, height: 80,);
                        },
                        image: NetworkImage('$serverUrl/user/profile/${controller.user?.imgPath}'),
                        fit: BoxFit.cover,
                      )
                          : (controller.image != null
                          ? Image.file(File(controller.image!.path), fit: BoxFit.cover, width: 80, height: 80,)
                          : Image.asset('assets/images/person.jpg', width: 80, height: 80,)
                      ),
                    ),
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr('nickname'),
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextField(
                        controller: TextEditingController(text: controller.user?.nickname ?? ''),
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
                        ),
                    onChanged: (value){
                          controller.user?.nickname = value;
                          log(controller.user!.nickname.toString());
                    },
                    ),
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr('mail'),
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextField(
                        controller: TextEditingController(text: controller.user?.email ?? ''),
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
                        ),
                      onChanged: (value){
                        controller.user?.email = value;

                      },

                    ),
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr('tell'),
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextField(
                        controller: TextEditingController(text: controller.user?.phone ?? ''),
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
                        ),
                      onChanged: (value){
                        controller.user?.phone = value;

                      },
                    ),
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr('affiliation'),
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextField(
                        controller: TextEditingController(text: controller.user?.affiliation ?? ''),
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
                        ),
                      onChanged: (value){
                        controller.user?.affiliation = value;

                      },
                    ),
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr('dept'),
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextField(
                        controller: TextEditingController(text: controller.user?.dept ?? ''),
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
                        ),
                      onChanged: (value){
                        controller.user?.dept = value;

                      },
                    ),
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr('position'),
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextField(
                        controller: TextEditingController(text: controller.user?.position ?? ''),
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
                        ),
                      onChanged: (value){
                        controller.user?.position = value;

                      },
                    ),
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr('research_field'),
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextField(
                        controller: TextEditingController(text: controller.user?.researchField ?? ''),
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
                        ),
                      onChanged: (value){
                        controller.user?.researchField = value;

                      },
                    ),
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'SNS',
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width) - 32,

                        child:
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Container(
                                      decoration : BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      height: 62,
                                      child: Center(
                                        child: DropdownButton<String>(
                                          value: controller.snsType1,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.black),
                                          underline: Container(
                                            height: 0,
                                          ),
                                          items: snsList
                                              .map<DropdownMenuItem<String>>((dynamic value) {
                                            print(value);
                                            return DropdownMenuItem<String>(
                                              value: value['value'],
                                              child: (value['label'] != 'selCancel' && value['label'] != 'snsSel')
                                                  ? Image(
                                                image: AssetImage(
                                                    'assets/images/${value['label']}.png'),
                                                width: 40,
                                                height: 40,
                                              )
                                                  : Text(tr(value['label'])),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            controller.changeSocial(value, 1);
                                          },
                                        ),
                                      )
                                  ),
                                  Expanded(
                                    child: TextField(
                                        controller: TextEditingController(text: controller.snsUrl1)..selection = TextSelection.fromPosition(
                                            TextPosition(offset: controller.snsUrl1.length)),
                                        onChanged: (value) {
                                          controller.changeUrl(value, 1);
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                )),
                                            hintText:
                                            tr('URL EX : http://isuskor.uos.ac.kr/'),
                                            hintStyle: TextStyle(color: Colors.grey)
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Container(
                                      decoration : BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      height: 62,
                                      child: Center(
                                        child: DropdownButton<String>(
                                          value: controller.snsType2,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.black),
                                          underline: Container(
                                            height: 0,
                                          ),
                                          items: snsList
                                              .map<DropdownMenuItem<String>>((dynamic value) {
                                            print(value);
                                            return DropdownMenuItem<String>(
                                              value: value['value'],
                                              child: (value['label'] != 'selCancel' && value['label'] != 'snsSel')
                                                  ? Image(
                                                image: AssetImage(
                                                    'assets/images/${value['label']}.png'),
                                                width: 40,
                                                height: 40,
                                              )
                                                  : Text(tr(value['label'])),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            controller.changeSocial(value, 2);
                                          },
                                        ),
                                      )
                                  ),
                                  Expanded(
                                    child: TextField(
                                        controller: TextEditingController(text: controller.snsUrl2)..selection = TextSelection.fromPosition(
                                            TextPosition(offset: controller.snsUrl2.length)),
                                        onChanged: (value) {
                                          controller.changeUrl(value, 2);
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                )),
                                            hintText:
                                            tr('URL EX : http://isuskor.uos.ac.kr/'),
                                            hintStyle: TextStyle(color: Colors.grey)
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Container(
                                      decoration : BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      height: 62,
                                      child: Center(
                                        child: DropdownButton<String>(
                                          value: controller.snsType3,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.black),
                                          underline: Container(
                                            height: 0,
                                          ),
                                          items: snsList
                                              .map<DropdownMenuItem<String>>((dynamic value) {
                                            print(value);
                                            return DropdownMenuItem<String>(
                                              value: value['value'],
                                              child: (value['label'] != 'selCancel' && value['label'] != 'snsSel')
                                                  ? Image(
                                                image: AssetImage(
                                                    'assets/images/${value['label']}.png'),
                                                width: 40,
                                                height: 40,
                                              )
                                                  : Text(tr(value['label'])),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            controller.changeSocial(value, 3);
                                          },
                                        ),
                                      )
                                  ),
                                  Expanded(
                                    child: TextField(
                                        controller: TextEditingController(text: controller.snsUrl3)..selection = TextSelection.fromPosition(
                                            TextPosition(offset: controller.snsUrl3.length)),
                                        onChanged: (value) {
                                          controller.changeUrl(value, 3);
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                )),
                                            hintText:
                                            tr('URL EX : http://isuskor.uos.ac.kr/'),
                                            hintStyle: TextStyle(color: Colors.grey)
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Container(
                                      decoration : BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      height: 62,
                                      child: Center(
                                        child: DropdownButton<String>(
                                          value: controller.snsType4,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.black),
                                          underline: Container(
                                            height: 0,
                                          ),
                                          items: snsList
                                              .map<DropdownMenuItem<String>>((dynamic value) {
                                            print(value);
                                            return DropdownMenuItem<String>(
                                              value: value['value'],
                                              child: (value['label'] != 'selCancel' && value['label'] != 'snsSel')
                                                  ? Image(
                                                image: AssetImage(
                                                    'assets/images/${value['label']}.png'),
                                                width: 40,
                                                height: 40,
                                              )
                                                  : Text(tr(value['label'])),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            controller.changeSocial(value, 4);
                                          },
                                        ),
                                      )
                                  ),
                                  Expanded(
                                    child: TextField(
                                        controller: TextEditingController(text: controller.snsUrl4)..selection = TextSelection.fromPosition(
                                            TextPosition(offset: controller.snsUrl4.length)),
                                        onChanged: (value) {
                                          controller.changeUrl(value, 4);
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                )),
                                            hintText:
                                            tr('URL EX : http://isuskor.uos.ac.kr/'),
                                            hintStyle: TextStyle(color: Colors.grey)
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Container(
                                      decoration : BoxDecoration(
                                          border: Border.all(width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      height: 62,
                                      child: Center(
                                        child: DropdownButton<String>(
                                          value: controller.snsType5,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.black),
                                          underline: Container(
                                            height: 0,
                                          ),
                                          items: snsList
                                              .map<DropdownMenuItem<String>>((dynamic value) {
                                            print(value);
                                            return DropdownMenuItem<String>(
                                              value: value['value'],
                                              child: (value['label'] != 'selCancel' && value['label'] != 'snsSel')
                                                  ? Image(
                                                image: AssetImage(
                                                    'assets/images/${value['label']}.png'),
                                                width: 40,
                                                height: 40,
                                              )
                                                  : Text(tr(value['label'])),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            controller.changeSocial(value, 5);
                                          },
                                        ),
                                      )
                                  ),
                                  Expanded(
                                    child: TextField(
                                        controller: TextEditingController(text: controller.snsUrl5)..selection = TextSelection.fromPosition(
                                            TextPosition(offset: controller.snsUrl5.length)),
                                        onChanged: (value) {
                                          controller.changeUrl(value, 5);
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                )),
                                            hintText:
                                            tr('URL EX : http://isuskor.uos.ac.kr/'),
                                            hintStyle: TextStyle(color: Colors.grey)
                                        )),
                                  )
                                ],
                              ),
                            )
                          ],
                        )


                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.patchDetailModify();
                        },

                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll(Color(0xff0D4C99))),
                        child: Text(
                          tr('modi'),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),

                    )
                  ],
                ),
              ),
            );
          },

        ),
      ),
    );
  }
}
