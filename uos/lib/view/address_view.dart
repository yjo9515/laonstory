import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:isus_members/view_model/address_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../domain/api/api_url.dart';
import '../type/emuns.dart';

class AddressView extends GetView<AddressViewModel> {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = '';
    print(context.locale.toString());
    if (context.locale.toString() == 'ko_KR' || context.locale.toString() == 'ko') {
      lang = 'ko';
    } else {
      lang = 'en';
    }
    return Scaffold(
      appBar: AppBar(
          // title: Obx(() => Text('${controller.selectedIndex.toString()}')),
          title: IconButton(
            icon: Image(
              image: AssetImage('assets/images/logo_mi.png'),
              width: 200,
              height: 26,
            ),
            // icon: Icon(Icons.add),
            iconSize: 10,
            onPressed: () {
              controller.refreshAddress();
            },
          ),
          automaticallyImplyLeading: false),
      body: GetBuilder<AddressViewModel>(
          init: AddressViewModel(),
          builder: (controller) => Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownMenu<String>(
                            controller: controller.contientController,
                            label: Text(tr('continent')),
                            width: 150,
                            inputDecorationTheme:
                            InputDecorationTheme(border: InputBorder.none),
                            // initialSelection: continent[0]['value'],
                            dropdownMenuEntries:
                            lang == 'ko' ?
                            continent
                                .map<DropdownMenuEntry<String>>((Map value) {
                              return DropdownMenuEntry<String>(
                                  value: value['value'], label: value['official_conname_kor']);
                            }).toList() :
                            continent
                                .map<DropdownMenuEntry<String>>((Map value) {
                              return DropdownMenuEntry<String>(
                                  value: value['value'], label: value['official_conname']);
                            }).toList()
                            ,
                            onSelected: (val){
                              controller.continent = val!;
                              controller.continentSearch(val);
                              //
                            },
                          ),
                          controller.countryChk == true ?
                          DropdownMenu<String>(
                            controller: controller.countryController,
                            label: Text(tr('nation')),
                            width: 200,
                            inputDecorationTheme:
                            InputDecorationTheme(border: InputBorder.none),
                            // initialSelection:
                            //     context.deviceLocale.toString() == 'ko_KR'
                            //         ? nation[0]['codename_eng']
                            //         : nation[0]['idx'].toString(),
                            dropdownMenuEntries:
                            lang == 'ko' ?
                                 controller.nationList.map<DropdownMenuEntry<String>>(
                                    (Map value) {
                                  return DropdownMenuEntry<String>(
                                    // value: value['idx'].toString(),
                                      value: value['codename'],
                                      label: value['codename']);
                                }).toList()
                                : controller.nationList.map<DropdownMenuEntry<String>>(
                                    (Map value) {
                                  return DropdownMenuEntry<String>(
                                    // value: value['idx'].toString(),
                                      value: value['codename_eng'] ,
                                      label: value['codename_eng']);
                                }).toList(),
                            onSelected: (val){
                              controller.countrySearch(val);
                            },
                          ) : Container()
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius:
                            BorderRadius.all(Radius.circular(100))),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 32,
                            ),
                            DropdownMenu<String>(
                              controller: controller.filterController,
                              width: 90,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: InputBorder.none),
                              initialSelection: controller.filterValue,
                              dropdownMenuEntries: filter
                                  .map<DropdownMenuEntry<String>>((Map value) {
                                log(tr(value['title']));
                                return DropdownMenuEntry<String>(
                                    value: value['value'],
                                    label: tr(value['title']));
                              }).toList(),
                              onSelected: (val){
                                controller.searchFilter = val!;
                                controller.filterValue = val!;
                                log(val);
                                controller.clearController();
                              },
                            ),

                            Expanded(
                              child: TextField(
                                controller: controller.filterTextController,
                                textAlign: TextAlign.left,
                                onChanged: (value) {
                                  controller.searchText = value;
                                  controller.clearController();
                                },
                                onEditingComplete: (){
                                  controller.search();
                                  FocusScope.of(context).unfocus();
                                },
                                decoration:
                                InputDecoration(border: InputBorder.none),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.search();
                                FocusScope.of(context).unfocus();
                              },
                              icon: Image.asset(
                                'assets/images/search-color.png',
                                width: 24,
                                height: 24,
                              ),
                            )
                          ],
                        )),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: searchTypeList
                            .map((e) =>
                            TextButton(
                                  onPressed: () {

                                    controller.cate = e['title']!;
                                    controller.cateSet();
                                    controller.clearController();
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.zero,
                                    child: Text(
                                        tr('${e['title']}'),
                                      style: context.textTheme.bodyMedium?.copyWith(color: e['title'] == controller.cate ? Colors.blue : Colors.black),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${tr('searchResult')} (${controller.total})${tr('count1')}',
                            style: context.textTheme.titleMedium,
                          ),
                          DropdownMenu<String>(
                            onSelected: (value){
                              controller.handleSort(value);
                              controller.clearController();
                            },
                            width: 140,
                            inputDecorationTheme:
                                InputDecorationTheme(border: InputBorder.none),
                            initialSelection: sortItems[0]['value'],
                            dropdownMenuEntries:
                            sortItems
                                .map<DropdownMenuEntry<String>>((Map value) {

                              return DropdownMenuEntry<String>(
                                  value: value['value'], label: tr(value['label']));
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    controller.total == 0 ?
                    Container()
                    :Expanded(
                      child: Container(
                        color: Color.fromARGB(255, 246, 246, 246),
                        child: ListView.builder(
                            itemCount: (controller.total),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Divider(
                                      height: 0,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ExpansionTile(
                                            title: Row(
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  height: 80,
                                                  child: Image(
                                                    errorBuilder: (context,object,e){
                                                      return Image(
                                                        image : AssetImage('assets/images/person.png')
                                                      );
                                                    },
                                                    image:controller.userList[index].img != null && controller
                                                            .userList[index]
                                                            .img!
                                                            .isNotEmpty && (controller.userList[index].img != '')
                                                        ? NetworkImage(
                                                            '$serverUrl/user/profile/${controller.userList[index].img}')
                                                        : NetworkImage(
                                                        '$serverUrl/user/profile/user_default_image.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:MediaQuery.of(context).size.width - 176,
                                                      child: Text(
                                                        '${controller.userList[index].name}',
                                                        style: context.textTheme
                                                            .titleMedium,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width:MediaQuery.of(context).size.width - 176,
                                                        child:Text(
                                                      '${controller.userList[index].affiliation}',

                                                      style: context
                                                          .textTheme.bodyMedium,
                                                    ) )
                                                    ,
                                                    SizedBox(
                                                      width:MediaQuery.of(context).size.width - 176,
                                                      child: Text(
                                                        '${controller.userList[index].email}',
                                                        style: context
                                                            .textTheme.bodyMedium,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:MediaQuery.of(context).size.width - 176,
                                                      child: Text(
                                                        '${controller.userList[index].phone}',
                                                        style: context
                                                            .textTheme.bodyMedium,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            children: [
                                              Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('name'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].name} (${controller.userList[index].nameEn})' ?? '',
                                                            style: context
                                                                .textTheme.bodyMedium,


                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('nickname'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].nickname??  '-'} ',
                                                     
                                                            style: context
                                                                .textTheme.bodyMedium,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('mail'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        SizedBox(
                                                            width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].email??  '-'} ',
                                                     
                                                            style: context
                                                                .textTheme.bodyMedium,

                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('tell'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].phone??  '-'} ',
                                                     
                                                            style: context
                                                                .textTheme.bodyMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('birth'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].birthday??  '-'} ',
                                                     
                                                            style: context
                                                                .textTheme.bodyMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 30,),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('nation'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Get.locale == Locale('ko') ?
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].country??  '-'} ',
                                                     
                                                            style: context
                                                                .textTheme.bodyMedium,
                                                          ),
                                                        ):SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].countryEn??  '-'} ',

                                                            style: context
                                                                .textTheme.bodyMedium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('city'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Get.locale == Locale('ko') ?
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].city??  '-'} ',
                                                     
                                                            style: context
                                                                .textTheme.bodyMedium,

                                                          ),
                                                        ):
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].cityEn??  '-'} ',

                                                            style: context
                                                                .textTheme.bodyMedium,

                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('affiliation'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].affiliation??  '-'} ',
                                                     
                                                            style: context
                                                                .textTheme.bodyMedium,

                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('dept'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].dept ?? '-'}',
                                                            style: context
                                                                .textTheme.bodyMedium,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('position'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].position??  '-'} ',

                                                            style: context
                                                                .textTheme.bodyMedium,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 30,),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('major'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Get.locale == Locale('ko') ?
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].major??  '-'} ',

                                                            style: context
                                                                .textTheme.bodyMedium,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ):
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].majorEn??  '-'} ',
                                                            style: context
                                                                .textTheme.bodyMedium,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:100,
                                                          child: Text(tr('admission'), style: context.textTheme.labelMedium?.copyWith(color: Colors.grey,fontSize: 16),),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width - 150,
                                                          child: Text(
                                                            '${controller.userList[index].admission??  '-'} ',
                                                     
                                                            style: context
                                                                .textTheme.bodyMedium,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    if(controller.userRole == "ADMIN")
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: TextButton(onPressed: (){
                                                        Get.defaultDialog(
                                                          title: tr('alert'),
                                                          content: Text(tr('reset')),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child: Text(tr('cancel'))),
                                                            TextButton(
                                                                onPressed: () {
                                                                  controller.userPassReset(controller.userList[index].idx);
                                                                  Get.back();
                                                                },
                                                                child: Text(tr('complete')))
                                                          ],
                                                        );
                                                      },
                                                          child: Text('계정초기화', style: TextStyle(
                                                            color : Colors.red,
                                                            decoration: TextDecoration.underline,
                                                            decorationColor: Colors.red,
                                                          ),
                                                              textAlign : TextAlign.left
                                                          )),
                                                    ),

                                                    SizedBox(height: 16,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(width: MediaQuery.of(context).size.width/2 - 50, height: 1,
                                                          color: Colors.grey,
                                                        ),
                                                        Text('SNS', style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey),),
                                                        Container(width: MediaQuery.of(context).size.width/2 - 50, height: 1,
                                                          color: Colors.grey,
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width,
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Row(
                                                          children: [
                                                            for (int i = 0; i < controller.userList[index].sns!.length; i++)
                                                              if (controller.userList[index].sns![i].social == 'facebook')
                                                                IconButton(
                                                                  onPressed: () {
                                                                    launchUrl(Uri.parse(controller.userList[index].sns![i].url.toString()));
                                                                  },
                                                                  icon: Image(
                                                                    image: AssetImage('assets/images/facebook.png'),
                                                                    width: 40,
                                                                    height: 40,
                                                                  ),
                                                                ),
                                                            for (int i = 0; i < controller.userList[index].sns!.length; i++)
                                                            controller.userList[index].sns!.any((e) => e.social == 'naverband')?
                                                            IconButton(onPressed: (){
                                                              launchUrl(Uri.parse(controller.userList[index].sns![i].url.toString()));
                                                            }, icon: Image(
                                                              image: AssetImage('assets/images/naverband.png'),
                                                              width: 40,
                                                              height: 40,
                                                            ),) : Container(),
                                                            for (int i = 0; i < controller.userList[index].sns!.length; i++)
                                                            controller.userList[index].sns!.any((e) => e.social == 'instagram')?
                                                            IconButton(onPressed: (){
                                                              launchUrl(Uri.parse(controller.userList[index].sns![i].url.toString()));
                                                            }, icon: Image(
                                                              image: AssetImage('assets/images/instagram.png'),
                                                              width: 40,
                                                              height: 40,
                                                            ),) : Container(),
                                                            for (int i = 0; i < controller.userList[index].sns!.length; i++)
                                                            controller.userList[index].sns!.any((e) => e.social == 'twitter')?
                                                            IconButton(onPressed: (){
                                                              launchUrl(Uri.parse(controller.userList[index].sns![i].url.toString()));
                                                            }, icon: Image(
                                                              image: AssetImage('assets/images/twitter.png'),
                                                              width: 40,
                                                              height: 40,
                                                            ),) : Container(),
                                                            for (int i = 0; i < controller.userList[index].sns!.length; i++)
                                                            controller.userList[index].sns!.any((e) => e.social == 'youtube')?
                                                            IconButton(onPressed: (){
                                                              launchUrl(Uri.parse(controller.userList[index].sns![i].url.toString()));
                                                            }, icon: Image(
                                                              image: AssetImage('assets/images/youtube.png'),
                                                              width: 40,
                                                              height: 40,
                                                            ),) : Container(),
                                                            for (int i = 0; i < controller.userList[index].sns!.length; i++)
                                                            controller.userList[index].sns!.any((e) => e.social == 'linkedin')?
                                                            IconButton(onPressed: (){
                                                              launchUrl(Uri.parse(controller.userList[index].sns![i].url.toString()));
                                                            }, icon: Image(
                                                              image: AssetImage('assets/images/linkedin.png'),
                                                              width: 40,
                                                              height: 40,
                                                            ),) : Container(),
                                                            for (int i = 0; i < controller.userList[index].sns!.length; i++)
                                                            controller.userList[index].sns!.any((e) => e.social == 'web')?
                                                            IconButton(onPressed: (){
                                                              launchUrl(Uri.parse(controller.userList[index].sns![i].url.toString()));
                                                            }, icon: Image(
                                                              image: AssetImage('assets/images/web.png'),
                                                              width: 40,
                                                              height: 40,
                                                            ),) : Container(),

                                                          ],
                                                        ),
                                                      ),
                                                    )


                                                  ],
                                                )


                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      height: 0,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
