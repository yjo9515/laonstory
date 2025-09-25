

import 'package:get/get.dart';
import 'package:isus_members/domain/api/api_service.dart';
import 'package:isus_members/domain/repository/board_repository.dart';

import '../domain/model/board_model.dart';

class BoardViewModel extends GetxController with ApiService{

  List<Board> boardList = [];


  Future<void> getBoard() async {
    await BoardRepository.to.getBoard().then((value) {
      print(value);
      boardList.clear();
      value['data']['data'].forEach((val){
        boardList.add(Board.fromJson(val));
        update();
      });
    });}
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBoard();
  }
}
