import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';

// 使用用户名和时间戳生成一个哈希字符串作为token
String generateToken(String username, int timestamp) {
  final secret = 'onanfweicdlifbilaubevnlaerwuinalkxjnd';
  final bytes = utf8.encode('$username:$timestamp:$secret');
  final hash = sha256.convert(bytes);
  return hash.toString().substring(0, 32);
}

/// 计算给定密码的hash并比较数据库的密码hash
bool passwordCompare(
    {required String password, required String storedsaltAndHashedPassword}) {
  final String salt;
  final String storedPassword;
  [
    salt,
    _,
    storedPassword,
  ] = storedsaltAndHashedPassword.split("\$");

  final key = utf8.encode('$password$salt');
  final hashedPassword = sha256.convert(key).toString();

  return hashedPassword == storedPassword;
}

String generateSalt(int length) {
  var rand = Random.secure();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';

  List<int> saltBytes = List.generate(
      length, (i) => chars.codeUnitAt(rand.nextInt(chars.length)));

  return String.fromCharCodes(saltBytes);
}

bool isEmail(String email) {
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

Future<List<int>> aes256Encrypt(String key, List<int> data) async {
  final keyList = List<int>.from(utf8.encode(key));
  keyList.length < 32
      ? keyList.addAll(List.filled(32 - keyList.length, 0))
      : null;
  final secretKey = SecretKey(keyList.sublist(0, 32));

  final iv = List<int>.generate(
      16, (i) => Random.secure().nextInt(256)); //随机生成一个16byte的初始化向量
  final algorithm = AesGcm.with256bits(); //选择256位AES加密算法
  final encrypted =
      await algorithm.encrypt(data, secretKey: secretKey, nonce: iv); //加密数据
  final mac = encrypted.mac.bytes;
  print(mac);
  print(iv);
  final encryptedBytes = [...iv, ...mac, ...encrypted.cipherText]; //生成加密后的字节数组
  return encryptedBytes;
}

Future<List<int>> aes256Decrypt(String key, List<int> encryptedData) async {
  final keyList = List<int>.from(utf8.encode(key));
  keyList.length < 32
      ? keyList.addAll(List.filled(32 - keyList.length, 0))
      : null;
  final secretKey = SecretKey(keyList.sublist(0, 32));
  final algorithm = AesGcm.with256bits(); // 选择256位AES解密算法
  final iv = encryptedData.sublist(0, 16); // 获取初始化向量
  final mac = encryptedData.sublist(16, 32);
  final cipherText = encryptedData.sublist(32); // 获取需要解密的密文
  final encrypted = SecretBox(cipherText,
      nonce: iv, mac: Mac(mac)); // 将需要解密的数据和初始化向量生成 Encrypted 类实例
  print(mac);
  print(iv);
  final decrypted =
      await algorithm.decrypt(encrypted, secretKey: secretKey); // 解密密文
  return decrypted; // 返回解密后的数据
}
