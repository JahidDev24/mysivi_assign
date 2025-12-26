import 'package:dio/dio.dart';

class ChatRepository {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  ChatRepository() {
    // Adding a simple logger interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("📡 Sending Request: ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("✅ Received Response: ${response.statusCode}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("❌ Error: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  final String _apiUrl = "http://api.quotable.io/random";
  Future<String> fetchRandomMessage() async {
    try {
      // Dio automatically infers the content-type and decodes JSON
      final response = await _dio.get(_apiUrl);

      if (response.statusCode == 200) {
        // response.data is already a Map<String, dynamic>
        return response.data['content'];
      } else {
        return "I received an empty response.";
      }
    } on DioException catch (e) {
      // Dio provides specific error types for better handling
      if (e.type == DioExceptionType.connectionTimeout) {
        return "Connection timed out. Please check your internet.";
      } else if (e.type == DioExceptionType.badResponse) {
        return "Server error: ${e.response?.statusCode}";
      }
      return "Network error occurred.";
    } catch (e) {
      return "Something went wrong: $e";
    }
  }
}
