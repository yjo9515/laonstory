import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import './../../view_model/social_add_view_model.dart';

const snsList = [
  {
    'label': 'snsSel',
    'value': '',
  },
  {
    'label': 'selCancel',
    'value': 'snsSel',
  },
  {
    'label': 'facebook',
    'value': 'facebook',
  },
  {
    'label': 'naverband',
    'value': 'naverband',
  },
  {
    'label': 'instagram',
    'value': 'instagram',
  },
  {
    'label': 'twitter',
    'value': 'twitter',
  },
  {
    'label': 'youtube',
    'value': 'youtube',
  },
  {
    'label': 'linkedin',
    'value': 'linkedin',
  },
  {
    'label': 'web',
    'value': 'web',
  },
];

class SnsAddDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialAddViewModel>(
        init: SocialAddViewModel(),
        builder: (controller) => Center(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height) - 200,
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
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        height: 60,
                        child: TextField(
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
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                height: 62,
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: controller.snsType1,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    hint : Text('선택'),
                                    underline: Container(
                                      height: 0,
                                    ),
                                    items: snsList
                                        .map<DropdownMenuItem<String>>(
                                            (dynamic value) {
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
                                )),
                            Expanded(
                              child: TextField(
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
                                    hintText: tr(
                                        'URL EX : http://isuskor.uos.ac.kr/'),
                                  )),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                height: 62,
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: controller.snsType2,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    hint : Text('선택'),
                                    underline: Container(
                                      height: 0,
                                    ),
                                    items: snsList
                                        .map<DropdownMenuItem<String>>(
                                            (dynamic value) {
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
                                )),
                            Expanded(
                              child: TextField(
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
                                    hintText: tr(
                                        'URL EX : http://isuskor.uos.ac.kr/'),
                                  )),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                height: 62,
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: controller.snsType3,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    hint : Text('선택'),
                                    underline: Container(
                                      height: 0,
                                    ),
                                    items: snsList
                                        .map<DropdownMenuItem<String>>(
                                            (dynamic value) {
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
                                )),
                            Expanded(
                              child: TextField(
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
                                    hintText: tr(
                                        'URL EX : http://isuskor.uos.ac.kr/'),
                                  )),
                            )
                          ],
                        ),
                      ]),
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
                            controller.addCommunity(data);
                          },

                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xff0D4C99))),
                        child: Text(
                          tr('regi'),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),

                    )
                  ],
                ))));
  }
}
