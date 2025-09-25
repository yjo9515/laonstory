import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:isus_members/view/address_view.dart';
import 'package:isus_members/view/board_view.dart';
import 'package:isus_members/view/mypage_view.dart';
import 'package:isus_members/view/notice_view.dart';
import 'package:isus_members/view/social_view.dart';

import '../view_model/home_view_model.dart';

const searchTypeList = [
  {
    'id': '1',
    'title': 'ALL',
    'search': 'ALL',
  },
  {
    'id': '2',
    'title': 'faculty',
    'search': 'Faculty',
  },
  {
    'id': '3',
    'title': 'local',
    'search': 'local',
  },
  {
    'id': '4',
    'title': 'foreigner',
    'search': 'foreigner',
  },
  {
    'id': '5',
    'title': 'GC',
    'search': 'GC',
  },
  {
    'id': '6',
    'title': 'SUD',
    'search': 'SUD',
  },
  {
    'id': '7',
    'title': 'MUAP',
    'search': 'MUAP',
  },
  {
    'id': '8',
    'title': 'MURD',
    'search': 'MURD',
  },
  {
    'id': '9',
    'title': 'MGLEP',
    'search': 'MGLEP',
  },
  {
    'id': '10',
    'title': 'MIPD',
    'search': 'MIPD',
  },
];

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller:controller.pageController,
              children: [
                AddressView(),
                BoardView(),
                NoticeView(),
                SocialView(),
                MypageView()
              ],
            )

        ),

      bottomNavigationBar: Obx(() => BottomNavigationBar(
        onTap: (index){controller.changeIndex(index);},
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        currentIndex: controller.selectedIndex.value,
        items: [
          BottomNavigationBarItem(
          activeIcon: Image.asset('assets/images/book-color.png', width: 29, height: 29), label:tr('address'),
          icon: Image.asset('assets/images/book.png', width: 29, height: 29)
          ),
          BottomNavigationBarItem(
              activeIcon: Image.asset('assets/images/list-color.png', width: 29, height: 29,), label: tr('bod'),
              icon: Image.asset('assets/images/list.png', width: 29, height: 29,),),
          BottomNavigationBarItem(
              icon: Image.asset('assets/images/notice.png', width: 29, height: 29,),
              activeIcon: Image.asset('assets/images/notice-color.png', width: 29, height: 29,),
              label: tr('noti')),
          BottomNavigationBarItem(
              icon: Image.asset('assets/images/sns.png', width: 29, height: 29,),
              activeIcon: Image.asset('assets/images/sns-color.png', width: 29, height: 29,),
              label: tr('social')),
          BottomNavigationBarItem(
              icon: Image.asset('assets/images/my.png', width: 29, height: 29,),
              activeIcon: Image.asset('assets/images/my-color.png', width: 29, height: 29,),
              label: tr('myPage')),
        ],
      )),
    );
  }
}

class DropdownMenuComponent extends StatefulWidget {
  const DropdownMenuComponent({super.key});

  @override
  State<DropdownMenuComponent> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuComponent> {
  String? dropdownValue = searchTypeList[0]['title'];

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: searchTypeList[0]['title'],
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          searchTypeList.map<DropdownMenuEntry<String>>((Map value) {
        return DropdownMenuEntry<String>(
            value: value['search'], label: tr(value['title']));
      }).toList(),
    );
  }
}
