import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

final Uri baseUrl = Uri.parse('http://172.20.0.203:8080/transactions');
final http.Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);
