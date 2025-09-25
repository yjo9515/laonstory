import 'dart:developer';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user_model.dart';

class SqlLite{
  Database? db;


  Future<Database> initDB() async{
    String path = join(await getDatabasesPath(), 'isus.db');
    return await openDatabase(path,onCreate: (db, version) async {
      await db.execute('''
    CREATE TABLE IF NOT EXISTS app_state (
      key TEXT PRIMARY KEY,
      value TEXT
    )
  ''');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS user ('
              'idx INT PRIMARY KEY, '
              'id VARCHAR(50), '
              'name VARCHAR(100), '
              'name_en VARCHAR(100), '
              'nickname VARCHAR(100), '
              'email VARCHAR(100), '
              'phone VARCHAR(20), '
              'country VARCHAR(50), '
              'country_en VARCHAR(50), '
              'city VARCHAR(50), '
              'city_en VARCHAR(50), '
              'affiliation VARCHAR(255), '
              'dept VARCHAR(255), '
              'position VARCHAR(100), '
              'major VARCHAR(100), '
              'major_en VARCHAR(100), '
              'research_field VARCHAR(255), '
              'admission VARCHAR(4), '
              'birthday VARCHAR(50), '
              'img VARCHAR(255), '
              'ROLE_USER VARCHAR(50), '
              'admin_role VARCHAR(255)'
              ')'
      );
      await db.execute(
            'CREATE TABLE IF NOT EXISTS sns ('
                'user_id INT, '
                'social VARCHAR(50), '
                'url VARCHAR(255), '
                'FOREIGN KEY (user_id) REFERENCES user(idx) '
                'ON DELETE CASCADE ON UPDATE NO ACTION)'
      // 'CREATE TABLE sns ('
      //     'user_id INTEGER,'
      //     'social TEXT,'
      //     'url TEXT,'
      //     'FOREIGN KEY (user_id) REFERENCES user (idx))'
      );

    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // 버전 1에서 2로 업그레이드: admin_role 컬럼 추가
        await db.execute('ALTER TABLE user ADD COLUMN admin_role VARCHAR(255)');
      }
    },
    version: 2
    );
  }
  Future<List<String>> getTableNames() async {
    final db = await initDB();
    final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    return tables.map((table) => table['name'] as String).toList();
  }

  Future<void> insertUser(data) async{
    print('주소오록: $data');
    log('주소오록: $data');
    
    final db = await initDB();
    await db.insert(
      'user',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace, // 중복될 경우 대체
    );
  }

  Future<void> insertSns(data) async{
    final db = await initDB();
    await db.insert(
      'sns',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace, // 중복될 경우 대체
    );
  }

  Future<List<Map<String, dynamic>>> selectUser() async {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      List<String> adminRoleList = pref.getStringList('adminRole') ?? ['null'];
      final db = await initDB();

      if(adminRoleList.contains('MASTER') || adminRoleList.contains('null')){
        return await db.rawQuery('''
      SELECT user.*, sns.social, sns.url
      FROM user
      LEFT JOIN sns ON user.idx = sns.user_id
    ''');
      }else{
        // WHERE 절에 여러 major_en을 포함하도록 수정
        String placeholders = adminRoleList.map((e) => '?').join(',');
        return await db.rawQuery('''
      SELECT user.*, sns.social, sns.url
      FROM user
      LEFT JOIN sns ON user.idx = sns.user_id
      WHERE user.major_en IN ($placeholders)
    ''', adminRoleList);
      }


      return await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='sns';"
      );
  }

  Future<void> saveLastRunDate() async {
    final db = await initDB();
    final now = DateTime.now().toIso8601String();
    await db.insert('app_state', {
      'key': 'last_run_date',
      'value': now,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}

