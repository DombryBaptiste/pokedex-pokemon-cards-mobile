import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

class AuthInterceptor implements InterceptorContract {
  static String? _jwtToken;

  static void setToken(String token) {
    _jwtToken = token;
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (_jwtToken != null) {
      request.headers['Authorization'] = 'Bearer $_jwtToken';
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) async {
    return response;
  }

  @override
  bool shouldInterceptRequest() => true;  // Intercepter toutes les requêtes

  @override
  bool shouldInterceptResponse() => true;  // Intercepter toutes les réponses
}

class ApiService {
  static final _client = InterceptedClient.build(
    interceptors: [AuthInterceptor()],
  );

  static String _resolveLocalhostHost() {
    if (kIsWeb) return 'localhost';
    if (defaultTargetPlatform == TargetPlatform.android) return '10.0.2.2';
    return 'localhost';
  }

  static String get baseUrl => 'http://${_resolveLocalhostHost()}:5001';

  static Future<http.Response> get(String path) {
    final uri = Uri.parse('$baseUrl$path');
    return _client.get(uri);
  }

  static Future<http.Response> post(String path, {Object? body}) {
    final uri = Uri.parse('$baseUrl$path');
    return _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }

  // Ajoutez d'autres méthodes HTTP si nécessaire (put, delete, etc.)
}