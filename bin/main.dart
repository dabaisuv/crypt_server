import 'dart:async';
import 'dart:io';

import 'package:alfred/alfred.dart';

import 'src/crypt.dart';
import 'src/server.dart';

void main() async {
  final app = Alfred(onInternalError: errorHandler);
  await postgresql.open();
  // 添加中间件
  app.all('*', (req, res) {
    // 设置响应头，允许所有来源
    res.headers.set('Access-Control-Allow-Origin', '*');
    // 设置响应头，允许的请求头
    res.headers.set('Access-Control-Allow-Headers',
        'Origin, Authorization, Content-Type, X-Requested-With');
    // 设置响应头，允许的请求方法'Access-Control-Allow-Methods'
    res.headers.set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');

    //如果是预检请求，直接设置响应头并返回200
    if (req.method == 'OPTIONS') {
      res.statusCode = HttpStatus.noContent;
      return '';
    }
  });

  //处理登录请求
  app.post('/api/login', login);
  app.post('/api/register', register);
  app.post('/api/crypt', crypt);

  await app.listen(8080); //监听8080端口
}

FutureOr errorHandler(HttpRequest req, HttpResponse res) {
  res.statusCode = 500;
  return {'message': 'error not handled'};
}
