import 'dart:async';
import 'dart:io';

import 'package:alfred/alfred.dart';

import 'postgresql.dart';
import 'session_tokens.dart';
import 'utils.dart';

FutureOr login(HttpRequest req, HttpResponse res) async {
  final body = await req.bodyAsJsonMap;
  final emailAddress = body["emailAddress"];
  final password = body["password"];

  // 查询数据库用户是否存在
  final result = await postgresql.mappedResultsQuery(
    'SELECT * FROM users WHERE email_address = @email_address',
    substitutionValues: {'email_address': emailAddress},
  );

  if (result.isEmpty) {
    // 如果用户不存在则返回错误给客户端
    res.json({'error': 'Invalid email address or password'});
    return;
  }

  final userData = result.first["users"];
  final storedsaltAndHashedPassword =
      userData!['salt_and_hashed_password'].toString();

  if (!passwordCompare(
      password: password,
      storedsaltAndHashedPassword: storedsaltAndHashedPassword)) {
    // 如果密码不正确则返回错误给客户端
    res.json({'error': 'Invalid username or password'});
    return;
  }

  // 如果密码正确，创建token作为响应发送给客户端
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final token = generateToken(emailAddress, timestamp);

  // 使用一个全局的Map存储token
  sessionTokens[token] = emailAddress;
  print(
      'sessionTockens.length:${sessionTokens.length},current logged tocken:$token, email:$emailAddress');
  res.json({'message': 'Login successed.', 'token': token});
  return;
}
