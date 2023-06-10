import 'dart:async';
import 'dart:convert';

import 'package:alfred/alfred.dart';

import 'utils.dart';

FutureOr crypt(HttpRequest req, HttpResponse res) async {
  final body = await req.body;
  const a = '你好';
  final aa = await aes256Encrypt('1111', utf8.encode(a));
  final bb = await aes256Decrypt('1111', aa);
  print(utf8.decode(bb));
}
