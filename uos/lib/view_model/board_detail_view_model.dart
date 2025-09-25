
import 'dart:developer';


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/api/api_service.dart';
import 'package:isus_members/domain/model/comment_model.dart';
import 'package:isus_members/domain/repository/board_repository.dart';
import 'package:isus_members/view_model/board_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/model/board_model.dart';

class BoardDetailViewModel extends GetxController with ApiService{
  Board? board;
  List<Comment> commentList = [];
  String? userId;
  String? comment;
  List<bool> patchList = [];
  String? report;
  String? boardReport;


  Future<void> getDetailBoard(id) async {
    if (id == null) {
      // id가 null인 경우에 대한 예외 처리
      return;
    }
    await BoardRepository.to.getDetailBoard(id).then((value) {
      commentList.clear();
      patchList.clear();
      board = Board.fromJson(value['data']['board']);
      value['data']['comment'].forEach((val){
        commentList.add(Comment.fromJson(val));
      });
      value['data']['comment'].forEach((val){
        patchList.add(false);
      });
      update();

    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert')           ,
          middleText: e.resultMsg.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });}

  Future<void> postBoardComment(comment) async {
    print(comment);
    await BoardRepository.to.postBoardComment(board?.idx, comment).then((value) {
      if(value['data'] == 'success'){
        Get.snackbar(tr('alert'), '${tr('comment')} ${tr('write')} ${tr('complete')}',backgroundColor: Colors.white,);
        final id = Get.parameters['id'];
        getDetailBoard(id);
      }
      update();

    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert'),
          middleText: e.resultMsg.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });}

  togglePatch(idx){
    patchList[idx] = !patchList[idx];
    update();
  }

  Future<void> patchBoardComment(comment,idx) async {
    log(comment);
    await BoardRepository.to.patchBoardComment(board?.idx, comment,commentList[idx].idx).then((value) {
      if(value['data'] == 'success'){
        Get.snackbar(tr('alert'), '${tr('comment')} ${tr('modi')} ${tr('complete')}',backgroundColor: Colors.white,);
        final id = Get.parameters['id'];
        getDetailBoard(id);
      }
      update();
    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert'),
          middleText: e.resultMsg.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });}

  Future<void> deleteBoardComment(idx) async {
    await BoardRepository.to.deleteBoardComment(board?.idx,commentList[idx].idx).then((value) {
      if(value['data'] == 'success'){
        Get.snackbar(tr('alert'), '${tr('comment')} ${tr('del')} ${tr('complete')}',backgroundColor: Colors.white,);
        final id = Get.parameters['id'];
        getDetailBoard(id);
      }
      update();
    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert'),
          middleText: e.resultMsg.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });}

  Future<void> deleteBoard(idx) async {
    await BoardRepository.to.deleteBoard(board?.idx).then((value) {
      if(value['data'] == 'success'){
        Get.back();
        Get.back();
        final controller = Get.put(BoardViewModel());
        controller.getBoard();
        Get.snackbar(tr('alert'), '${tr('delComplete')}',backgroundColor: Colors.white,);


      }
      update();
    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert'),
          middleText: e.resultMsg.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });}

  Future<void> postReportUser(report,idx) async {
    await BoardRepository.to.postReport(report,commentList[idx].idx).then((value) {
      if(value['data'] == 'success'){
        Get.snackbar(tr('alert'), '${tr('complete')}',backgroundColor: Colors.white,);
        final id = Get.parameters['id'];
        getDetailBoard(id);
      }
      update();
    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert'),
          middleText: e.resultMsg.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });
  }

  Future<void> postReportBoard(report) async {
    await BoardRepository.to.postBoardReport(report,board?.idx).then((value) {
      if(value['data'] == 'success'){
        Get.snackbar(tr('alert'), '${tr('complete')}',backgroundColor: Colors.white,);
        final id = Get.parameters['id'];
        getDetailBoard(id);
      }
      update();
    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert'),
          middleText: e.resultMsg.toString(),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });
  }

  getId() async{
    SharedPreferences store = await SharedPreferences.getInstance();
    userId = store.getString('idx');
    update();
  }

  @override
  void onInit(){
    // TODO: implement onInit
    final id = Get.parameters['id'];
    getId();
    getDetailBoard(id);
    super.onInit();
  }
}
