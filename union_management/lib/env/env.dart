import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'PW_PRIVATE_KEY', obfuscate: true)
  static String pwPrivateKey = _Env.pwPrivateKey;

  @EnviedField(varName: 'PW_PRIVATE_IV', obfuscate: true)
  static String pwPrivateIv = _Env.pwPrivateIv;

  @EnviedField(varName: 'TOKEN_PRIVATE_KEY', obfuscate: true)
  static String tokenPrivateKey = _Env.tokenPrivateKey;

  @EnviedField(varName: 'TOKEN_PRIVATE_IV', obfuscate: true)
  static String tokenPrivateIv = _Env.tokenPrivateIv;

  @EnviedField(varName: 'DATA_PRIVATE_KEY', obfuscate: true)
  static String dataPrivateKey = _Env.dataPrivateKey;

  @EnviedField(varName: 'DATA_PRIVATE_IV', obfuscate: true)
  static String dataPrivateIv = _Env.dataPrivateIv;

  @EnviedField(varName: 'KAKAO_KEY', obfuscate: true)
  static String kakaoMapKey = _Env.kakaoMapKey;
}
