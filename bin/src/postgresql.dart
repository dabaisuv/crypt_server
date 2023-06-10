//连接postgresql数据库
import 'package:postgres/postgres.dart';

final postgresql = PostgreSQLConnection(
  'localhost',
  5432,
  'crypt',
  username: 'crypt',
  password: 'crypt',
);
