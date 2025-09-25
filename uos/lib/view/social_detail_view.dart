import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../type/emuns.dart';
import './../../view_model/social_modify_view_model.dart';




class SocialDetailView extends GetView<SocialModifyViewModel> {
  const SocialDetailView({super.key});

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
                    child: Text(tr('modi')),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: (){

                      Get.defaultDialog(
                        title: '${tr('community')} ${tr('del')}',
                        content: Text(tr('communityDel')),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(tr('cancel'))),
                          TextButton(
                              onPressed: () {
                                controller.deleteCommunity();
                                Get.back();
                              },
                              child: Text(tr('complete')))
                        ],
                      );

                    }, child: Text(
                      tr('del'),
                      style: TextStyle(color: Colors.red[400], fontSize: 16),
                    ),)
                  ),
                ],
              )),
          automaticallyImplyLeading: false),
      body: GetBuilder<SocialModifyViewModel>(
        init: SocialModifyViewModel(),
        builder: (_) => Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height) - 200,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr('content'),
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    padding: EdgeInsets.only(top: 10),
                    height: 60,
                    child: TextField(
                        controller: TextEditingController(text: controller.snsContent),
                        onChanged: (value) {
                          controller.snsContent = value;
                          controller.change();
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              )),
                        )),
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'sns',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width) - 32,
                  height: 300,
                  child: Column(children: [
                    Row(
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
                                onChanged: (dynamic value) {
                                  print(value);
                                  controller.handleSns('type1', value);

                                },
                              ),
                            )
                        ),
                        Expanded(
                          child: TextField(
                              controller: TextEditingController(text: controller.snsUrl1),
                              onChanged: (value) {
                                controller.snsUrl1 = value;
                                controller.change();
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    )),
                                hintText:
                                tr('URL EX : http://isuskor.uos.ac.kr/'),
                              )),
                        )
                      ],
                    ),
                    Row(
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
                                onChanged: (dynamic value) {
                                  print(value);
                                  controller.handleSns('type2', value);

                                },
                              ),
                            )
                        ),
                        Expanded(
                          child: TextField(
                              controller: TextEditingController(text: controller.snsUrl2),
                              onChanged: (value) {
                                controller.snsUrl2 = value;
                                controller.change();
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    )),
                                hintText:
                                tr('URL EX : http://isuskor.uos.ac.kr/'),
                              )),
                        )
                      ],
                    ),
                    Row(
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
                                onChanged: (dynamic value) {
                                  print(value);
                                  controller.handleSns('type3', value);

                                },
                              ),
                            )
                        ),
                        Expanded(
                          child: TextField(
                              controller: TextEditingController(text: controller.snsUrl3),
                              onChanged: (value) {
                                controller.snsUrl3 = value;
                                controller.change();
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    )),
                                hintText:
                                tr('URL EX : http://isuskor.uos.ac.kr/'),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          var data = {
                            'content': controller.snsContent,
                            'first_social' : controller.snsType1,
                            'first_url' : controller.snsUrl1 ,
                            'second_social' : controller.snsType2,
                            'second_url' : controller.snsUrl2,
                            'third_social' : controller.snsType3,
                            'third_url' : controller.snsUrl3
                          };
                          controller.modifyCommunity(data);
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
                  ]),
                )
              ],
            )),
      ),
    );
  }
}
