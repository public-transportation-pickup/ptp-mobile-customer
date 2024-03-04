import 'package:logger/logger.dart';

class ApiService {
  static var checkLog = Logger(printer: PrettyPrinter());
  static const String baseUrl = 'http://ptp-srv.ddns.net:5000/api';
}
