import 'package:get/get.dart';
import 'package:isus_members/domain/api/api_service.dart';
import 'package:isus_members/domain/model/notice_model.dart';
import 'package:isus_members/domain/repository/notice_repository.dart';

import '../domain/model/board_model.dart';

class NoticeViewModel extends GetxController with ApiService{

  List<Notice> noticeList = [];


  Future<void> getNotice() async {
    await NoticeRepository.to.getNotice().then((value) {
      noticeList.clear();
      value['data']['data'].forEach((val){
        noticeList.add(Notice.fromJson(val));
        update();
      });

    });}


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotice();
  }
}
