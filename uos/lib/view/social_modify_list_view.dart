import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './../../view_model/social_modify_list_view_model.dart';
import './../view/widget/snsAddHeader.dart';
import './../view/widget/snsAddBody.dart';
import './modal_view.dart';

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


class SocialModifyListView extends GetView<SocialModifyListViewModel> {
  const SocialModifyListView({super.key});

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
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          showCustomModal(
                            context,
                            SnsAddHeader(), // 원하는 타이틀 지정
                            SnsAddDetailBody(), // 원하는 content Widget 지정
                          );
                        },
                        child:
                        Text(tr('add'), style: TextStyle(color: Colors.black)))),
              ],
            ),
          ),
          automaticallyImplyLeading: false),
      body: GetBuilder<SocialModifyListViewModel>(
        init: SocialModifyListViewModel(),
        builder: (_) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                  ))),
          padding: EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: controller.communityList?.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print("+++++++++++++++++++++++++++++++++++++++++++++");
                  print(controller.communityList?[index].content);
                  Get.toNamed('/social/${controller.communityList?[index].idx}');

                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border(
                            top: BorderSide(color: Colors.grey),
                            bottom: BorderSide(color: Colors.grey))),
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width / 2) - 16,
                          child: Text('${controller.communityList?[index].content}'),
                        ),
                        SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 16,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: controller.communityList![index]
                                    .sns!
                                    .map((e) =>
                                // Text(e['social'])
                                Image(
                                    image: AssetImage(
                                        'assets/images/${e?['social']}.png'),
                                    width: 40,
                                    height: 40))
                                    .toList(),
                              ),
                            )),
                      ],
                    )),
              );
            },
          ),
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
