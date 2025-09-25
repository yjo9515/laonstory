import 'package:envied/envied.dart';

part 'generated/env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'PW_PRIVATE_KEY', obfuscate: true)
  static String pwPrivateKey = _Env.pwPrivateKey;

  @EnviedField(varName: 'PW_PRIVATE_IV', obfuscate: true)
  static String pwPrivateIv = _Env.pwPrivateIv;

  @EnviedField(varName: 'FIREBASE_API_AOS', obfuscate: true)
  static String firebaseAosKey = _Env.firebaseAosKey;

  @EnviedField(varName: 'FIREBASE_API_IOS', obfuscate: true)
  static String firebaseIosKey = _Env.firebaseIosKey;

  @EnviedField(varName: 'FIREBASE_API_WEB', obfuscate: true)
  static String firebaseWebKey = _Env.firebaseWebKey;

  @EnviedField(varName: 'TOSS_PAY_TEST_CLIENT_KEY', obfuscate: true)
  static String tossTestClientKey = _Env.tossTestClientKey;

  @EnviedField(varName: 'TOSS_PAY_TEST_SECRET_KEY', obfuscate: true)
  static String tossTestSecretKey = _Env.tossTestSecretKey;
}
