import 'dart:async';
import 'dart:convert';

import 'package:alfred/alfred.dart';
import 'package:crypto/crypto.dart';

import 'postgresql.dart';
import 'utils.dart';

FutureOr register(HttpRequest req, HttpResponse res) async {
  final body = await req.bodyAsJsonMap;
  final username = body['username'];
  final emailAddress = body['emailAddress'];
  final password = body['password'];

  if (username == null || username == '') {
    res.json({'error': 'username is empty.'});
    return;
  }

  if (emailAddress == null || emailAddress == '') {
    res.json({'error': 'email address is empty.'});
    return;
  }

  if (password == null || password == '') {
    res.json({'error': 'password is empty.'});
    return;
  }

  //检查是否是正确的email
  if (!isEmail(emailAddress)) {
    res.json({'error': 'email address is not correct.'});
    return;
  }

  // 检查emailAddress是否唯一
  final result = await postgresql.mappedResultsQuery(
      'SELECT * FROM users WHERE email_address = @email_address;',
      substitutionValues: {'email_address': emailAddress});

  if (result.isNotEmpty) {
    res.json({'error': 'email address already exists.'});
    return;
  }

  final salt = generateSalt(32);
  final hashedPassword =
      sha256.convert(utf8.encode('$password$salt')).toString();
  final saltAndHashedPassword = '$salt\$sha256\$$hashedPassword';

  // 将新用户插入到数据库中
  await postgresql.query(
      "INSERT INTO public.users (username, email_address,salt_and_hashed_password) VALUES (@username,@email_address,@salt_and_hashed_password)",
      substitutionValues: {
        'username': username,
        'email_address': emailAddress,
        'salt_and_hashed_password': saltAndHashedPassword
      });
  print('Registration successful: $username,$emailAddress');
  res.json({'message': 'Registration successful.'});
  return;
}
