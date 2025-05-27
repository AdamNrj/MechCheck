import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> saveCredentials(String user, String pass) async {
  await storage.write(key: 'user', value: user);
  await storage.write(key: 'pass', value: pass);
}

Future<Map<String, String?>> getCredentials() async {
  String? user = await storage.read(key: 'user');
  String? pass = await storage.read(key: 'pass');
  return {'user': user, 'pass': pass};
}
