import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isus_members/domain/database/SqlLite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/api/api_service.dart';
import '../domain/model/user_model.dart';
import '../domain/repository/address_repository.dart';
import '../type/emuns.dart';

class AddressViewModel extends GetxController with ApiService {

  int total = 0;
  List<User> userList = [];
  List<User> userBackList = [];
  String searchText = '';
  String searchFilter = 'ALL';
  String cate = 'all';
  String sortFilter = 'name';
  String continent = 'AF';
  String country = 'AF';
  List<Map<String,dynamic>> nationList = [];
  bool countryChk = false;
  TextEditingController contientController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController filterController = TextEditingController();
  TextEditingController filterTextController = TextEditingController();
  String? filterValue = filter[0]['value'];
  String userRole = '';

  clearController(){
    countryController.clear();
    contientController.clear();
    countryChk = false;
    log('초기화');
    update();
  }

  Future<List> processUserWithSnsData() async {
    final List<Map<String, dynamic>> result = await SqlLite().selectUser();

    // Map to store user data
    Map<String, dynamic> userData = {};

    // Iterate over each row in the result
    for (var row in result) {
      String userId = row['idx'].toString();

      // Initialize user data if not already present
      if (userData.isEmpty || !userData.containsKey(userId)) {
        userData[userId] = {
          'idx': row['idx'],
          'id': row['id'],
          'name': row['name'],
          'name_en': row['name_en'],
          'nickname': row['nickname'],
          'email': row['email'],
          'phone': row['phone'],
          'country': row['country'],
          'country_en': row['country_en'],
          'city': row['city'],
          'city_en': row['city_en'],
          'affiliation': row['affiliation'],
          'dept': row['dept'],
          'position': row['position'],
          'major': row['major'],
          'major_en': row['major_en'],
          'research_field': row['research_field'],
          'admission': row['admission'],
          'birthday': row['birthday'],
          'img': row['img'],
          'ROLE_USER': row['ROLE_USER'],
          'sns': []  // Initialize sns list
        };
      }

      // Add sns data to the corresponding user
      if (row['social'] != null && row['url'] != null) {
        userData[userId]['sns'].add({
          'social': row['social'],
          'url': row['url']
        });
      }
    }

    // Convert the map to a list format if needed
    return userData.values.toList();
  }


  Future<void> refreshAddress() async {
    await AddressRepository.to.getAddress().then((value) {
      log('주소록');
        log(value['data'].length.toString());
        total = value['data'].length!;
        userList.clear();
        userBackList.clear();
        clearController();

        value['data'].forEach((val){
          userList.add(User.fromJson(val));
        });
        value['data'].forEach((val){
          userBackList.add(User.fromJson(val));
        });
        filterController.clear();
        log(filter[0]['value'].toString());
        filterValue = filter[0]['value'];
        filterTextController.clear();
        update();
    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert')           ,
          middleText: e.resultMsg,
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });
  }

  Future<void> getAddress() async {
    final db = await SqlLite().initDB();
      final result = await db.query('app_state', where: 'key = ?', whereArgs: ['last_run_date']);
      log(result.toList().toString());
      if(result.isEmpty || result == []){
        // 앱 최초 실행시 기록한 날짜가 없을때
        log("날짜없음");
        saveAddress();
      }else{
        log(result.toList().toString());
        final lastRunDateStr = result.first['value'] as String;
        final lastRunDate = DateTime.parse(lastRunDateStr);
        final now = DateTime.now();
        final difference = now.difference(lastRunDate).inDays;

        if (difference >= 7) {
          saveAddress();
          log("7일 넘어감");
        } else {
          log("7일 안넘어감");
          List<dynamic>  d = await processUserWithSnsData();
          total = d.length!;
          userList.clear();
          userBackList.clear();
          for (var val in d) {
            userList.add(User.fromJson(val));
          }
          for (var val in d) {
            userBackList.add(User.fromJson(val));
          }
          handleSort(sortFilter);
          update();
        }
      }

  }
  Future<void> saveAddress()async {
    await AddressRepository.to.getAddress().then((Map<String,dynamic> value) async {
      log('주소록');
      try{
        value['data'].forEach((val){
          List<dynamic> t = val['sns'];
          Map<String,dynamic> r = val;
          r.remove('sns');
          SqlLite().insertUser(r);
          if(t.isNotEmpty) {
            for(var k in t){
              SqlLite().insertSns(k);
            }
          }
          // if(val['sns'] != [] && val['sns'] != null){
          // }
        }
        );
        List<dynamic>  d = await processUserWithSnsData();
        total = d.length!;
        userList.clear();
        userBackList.clear();

        for (var val in d) {
          userList.add(User.fromJson(val));
        }
        for (var val in d) {
          userBackList.add(User.fromJson(val));
        }
        handleSort(sortFilter);
        SqlLite().saveLastRunDate();
        update();
      }catch (e){
        log(e.toString());
      }
    }).catchError((e){
      print(e);
      Get.defaultDialog(
          title: tr('alert')           ,
          middleText: e.resultMsg,
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });
  }




  void change(){
    update();
  }

  Future<void> cateSet( ) async {
    List<User> cateList = [];
    if (cate == 'all') {
      cateList = userBackList;
    } else if (cate == 'local') {
      cateList = userBackList.where((val) => val.country?.contains('대한민국') ?? false)
          .map((user) {
        return user;
      }).toList();
    } else if (cate == 'foreigner') {
      cateList = userBackList.where((val) => !(val.country?.contains('대한민국')?? false))
          .map((user) {
        return user;
      }).toList();
    }
    else if (cate == 'faculty') {
      cateList = userBackList.where((val) => val.major?.contains('교수') ?? false)
          .map((user) {
        return user;
      }).toList();
    } else if (cate == 'GC') {
      cateList = userBackList.where((val) => val.major?.contains('글로벌건설학과') ?? false)
          .map((user) {
        return user;
      }).toList();
    } else if (cate == 'SUD') {
      cateList = userBackList.where((val) => val.major?.contains('첨단녹색도시개발학과') ?? false)
          .map((user) {
        return user;
      }).toList();
    } else if (cate == 'MUAP') {
      cateList = userBackList.where((val) => val.major?.contains('도시행정및계획전공') ?? false)
          .map((user) {
        return user;
      }).toList();
    } else if (cate == 'MURD') {
      cateList = userBackList.where((val) => val.major?.contains('도시및지역개발정책전공') ?? false)
          .map((user) {
        return user;
      }).toList();
    } else if (cate == 'MGLEP') {
      cateList = userBackList.where((val) => val.major?.contains('글로벌환경정책전공') ?? false)
          .map((user) {
        return user;
      }).toList();
    } else if (cate == 'MIPD') {
      cateList = userBackList.where((val) => val.major?.contains('글로벌인프라계획및개발전공') ?? false)
          .map((user) {
        return user;
      }).toList();
    }else if (cate == 'MUD') {
      cateList = userBackList.where((val) => val.major?.contains('도시개발정책전공') ?? false)
          .map((user) {
        return user;
      }).toList();
    }else if (cate == 'MUDSIP') {
      cateList = userBackList.where((val) => val.major?.contains('도시개발및스마트인프라정책전공') ?? false)
          .map((user) {
        return user;
      }).toList();
    }else if (cate == 'IDC') {
      cateList = userBackList.where((val) => val.major?.contains('국제개발협력학과') ?? false)
          .map((user) {
        return user;
      }).toList();
    }else if (cate == 'IUD') {
      cateList = userBackList.where((val) => val.major?.contains('국제도시개발학과') ?? false)
          .map((user) {
        return user;
      }).toList();
    }
    userList = cateList;
    total = userList.length;
    handleSort(sortFilter);
  }

  Future<void> handleSort(value) async{
    List<User> searchList = [];
    sortFilter = value;
    log(sortFilter);
    if (sortFilter == 'name') {
      userList.sort((a, b) {
        return a.name!.compareTo(b.name!);
      });
    } else {
      userList.sort((a, b) {
        return a.admission!.compareTo(b.admission!);
      });
    }

    update();
  }

  Future<void> search( ) async {
    try{
      log(cate);
      log(searchFilter.toString());
      log(userBackList.toString());
      List<User> cateList = [];
      List<User> searchList = [];
      int count = 0;


      if (cate == 'all') {
        cateList = userBackList;
      } else if (cate == 'local') {
        cateList = userBackList.where((val) => val.country?.contains('대한민국') ?? false)
            .map((user) {
          return user;
        }).toList();
      } else if (cate == 'foreigner') {
        cateList = userBackList.where((val) => !(val.country?.contains('대한민국')?? false))
            .map((user) {
          return user;
        }).toList();
      }
      else if (cate == 'faculty') {
        cateList = userBackList.where((val) => val.major?.contains('교수') ?? false)
            .map((user) {
          return user;
        }).toList();
      } else if (cate == 'GC') {
        cateList = userBackList.where((val) => val.major?.contains('글로벌건설학과') ?? false)
            .map((user) {
          return user;
        }).toList();
      } else if (cate == 'SUD') {
        cateList = userBackList.where((val) => val.major?.contains('첨단녹색도시개발학과') ?? false)
            .map((user) {
          return user;
        }).toList();
      } else if (cate == 'MUAP') {
        cateList = userBackList.where((val) => val.major?.contains('도시행정및계획전공') ?? false)
            .map((user) {
          return user;
        }).toList();
      } else if (cate == 'MURD') {
        cateList = userBackList.where((val) => val.major?.contains('도시및지역개발정책전공') ?? false)
            .map((user) {
          return user;
        }).toList();
      } else if (cate == 'MGLEP') {
        cateList = userBackList.where((val) => val.major?.contains('글로벌환경정책전공') ?? false)
            .map((user) {
          return user;
        }).toList();
      } else if (cate == 'MIPD') {
        cateList = userBackList.where((val) => val.major?.contains('글로벌인프라계획및개발전공') ?? false)
            .map((user) {
          return user;
        }).toList();
      }else if (cate == 'MUD') {
        cateList = userBackList.where((val) => val.major?.contains('도시개발정책전공') ?? false)
            .map((user) {
          return user;
        }).toList();
      }else if (cate == 'MUDSIP') {
        cateList = userBackList.where((val) => val.major?.contains('도시개발및스마트인프라정책전공') ?? false)
            .map((user) {
          return user;
        }).toList();
      }else if (cate == 'IDC') {
        cateList = userBackList.where((val) => val.major?.contains('국제개발협력학과') ?? false)
            .map((user) {
          return user;
        }).toList();
      }else if (cate == 'IUD') {
        cateList = userBackList.where((val) => val.major?.contains('국제도시개발학과') ?? false)
            .map((user) {
          return user;
        }).toList();
      }

      if (searchFilter  == 'ALL') {
        searchList = cateList.where((item) {
          return item.name?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.nameEn?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.nameEn?.toLowerCase()?.contains(searchText.toLowerCase()) == true ||
              item.nickname?.toLowerCase()?.contains(searchText.toLowerCase()) == true ||
              item.nickname?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.country?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.countryEn?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.city?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.cityEn?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.major?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.majorEn?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              (item.admission?.toUpperCase()?.contains(searchText.toUpperCase()) == true) ||
              (item.affiliation?.toUpperCase()?.contains(searchText.toUpperCase()) == true) ||
              (item.dept?.toUpperCase()?.contains(searchText.toUpperCase()) == true);
        }).toList();
      } else if (searchFilter == 'NAME') {
        searchList = cateList.where((item) {
          return item.name?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.nameEn?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.name?.toLowerCase()?.contains(searchText.toLowerCase()) == true ||
              item.nameEn?.toLowerCase()?.contains(searchText.toLowerCase()) == true;
        }).toList();
        log(searchList.toString());
      } else if (searchFilter == 'NICKNAME') {
        searchList = cateList.where((item) {
          return item.nickname?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.nickname?.toLowerCase()?.contains(searchText.toLowerCase()) == true;
        }).toList();
        log("닉네임"+searchList.toString());
      } else if (searchFilter == 'NATION') {
        log(searchFilter);
        searchList = cateList.where((item) {
          return item.country?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.countryEn?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.country?.toLowerCase()?.contains(searchText.toLowerCase()) == true ||
              item.countryEn?.toLowerCase()?.contains(searchText.toLowerCase()) == true
          ;
        }).toList();
      } else if (searchFilter == 'CITY') {
        searchList = cateList.where((item) {
          return item.city?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.cityEn?.toUpperCase()?.contains(searchText.toUpperCase()) == true;
        }).toList();
      } else if (searchFilter == 'MAJOR') {
        searchList = cateList.where((item) {
          return item.major?.toUpperCase()?.contains(searchText.toUpperCase()) == true ||
              item.majorEn?.toUpperCase()?.contains(searchText.toUpperCase()) == true;
        }).toList();
      } else if (searchFilter == 'ADMISSION') {
        searchList = cateList.where((item) {
          return item.admission?.contains(searchText) == true;
        }).toList();
      } else if (searchFilter == 'AFFILIATION') {
        searchList = cateList.where((item) {
          return item.affiliation?.toUpperCase()?.contains(searchText.toUpperCase()) == true;
        }).toList();
      } else if (searchFilter == 'DEPT') {
        searchList = cateList.where((item) {
          return item.dept?.toUpperCase()?.contains(searchText.toUpperCase()) == true;
        }).toList();
      }

      count = searchList.length;
      if (sortFilter == 'name') {
        searchList.sort((a, b) {
          return a.name!.compareTo(b.name!);
        });
      } else {
        searchList.sort((a, b) {
          return a.admission!.compareTo(b.admission!);
        });
      }
      log("검색어"+searchText);
      log(userBackList.first.toJson().toString());
      log("검색결과"+searchList.toString());
      userList = searchList;
      total = userList.length;
      update();
    }catch(e){
      log(e.toString());
    }


    // try{
    //   await props.addressGet(sortFilter, cate, searchFilter, searchWord, 0 );
    // }catch(e){'
    //   print(e)
    // }
  }

  continentSearch (value){
    nationList = nation.where((element){
      return element['official_conname'].contains(value) == true;
    }).toList();
    log(nationList.toString());
    countryChk = true;
    cate ='all';
    sortFilter = 'name';
    sortFilter = 'ALL';
    update();
  }

  countrySearch (value){
    // value
    log(value);
    log(searchText);

    cate ='all';
    sortFilter = 'name';
    sortFilter = 'ALL';

    String search =  value;
    List<User> searchList = [];
    // userBackList.where((element) => element.countryEn == )
    searchList = userBackList.where((item) {
      return item.name?.toUpperCase()?.contains(search) == true ||
          item.nameEn?.toUpperCase()?.contains(search) == true ||
          item.country?.toUpperCase()?.contains(search) == true ||
          item.countryEn?.toUpperCase()?.contains(search) == true ||
          item.city?.toUpperCase()?.contains(search) == true ||
          item.cityEn?.toUpperCase()?.contains(search) == true ||
          item.major?.toUpperCase()?.contains(search) == true ||
          item.majorEn?.toUpperCase()?.contains(search) == true ||
          (item.admission?.toUpperCase()?.contains(search) == true) ||
          (item.affiliation?.toUpperCase()?.contains(search) == true) ||
          (item.dept?.toUpperCase()?.contains(search) == true);
    }).toList();
    log(searchList.toString());
    userList = searchList;
    total = userList.length;
    update();
  }

  Future<void> userPassReset (id) async {

    await AddressRepository.to.userPassReset(id.toString()).then((value){
      try {

        if(value['result'] == 1){
          Get.defaultDialog(
              title: tr('alert')
              ,
              middleText: tr('resetAccount'),
              confirm: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(tr('confirm'))));
        }

      } catch (e) {
        log('error');
        log(e.toString());
      }
    }).catchError((e) {
      Get.defaultDialog(
          title: tr('alert'),
          middleText: e.resultMsg,
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(tr('confirm'))));
    });
  }

  getUserRole() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    userRole = store.getString('ROLE_USER')!;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAddress();
    getUserRole();
  }

}
