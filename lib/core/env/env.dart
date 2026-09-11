import 'package:envied/envied.dart';

part 'env.g.dart';

enum EnvFlavor { dev, staging, prod }

@Envied(path: '.env')
class Env {
  const Env._();

  @EnviedField(obfuscate: true)
  static final String apiBaseUrl = _Env.apiBaseUrl;
}
