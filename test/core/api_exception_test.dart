import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/core/network/api_exception.dart';

void main() {
  group('ApiException', () {
    test('status 401, không có data -> message chứa "Phiên đăng nhập"', () {
      final exception = ApiException.fromResponse(statusCode: 401);
      expect(exception.message, contains('Phiên đăng nhập'));
      expect(exception.statusCode, 401);
    });

    test('statusCode 0 -> message chứa "Không có kết nối mạng"', () {
      final exception = ApiException.fromResponse(statusCode: 0);
      expect(exception.message, contains('Không có kết nối mạng'));
      expect(exception.statusCode, 0);
    });

    test('status 500 -> message chứa "Hệ thống đang bận"', () {
      final exception = ApiException.fromResponse(statusCode: 500);
      expect(exception.message, contains('Hệ thống đang bận'));
      expect(exception.statusCode, 500);
    });

    test('status 418 với data {"detail": "xyz"} -> message == "xyz"', () {
      final exception = ApiException.fromResponse(
        statusCode: 418,
        data: {'detail': 'xyz'},
      );
      expect(exception.message, equals('xyz'));
      expect(exception.statusCode, 418);
    });

    test('statusCode null -> message chứa "Không có kết nối mạng"', () {
      final exception = ApiException.fromResponse(statusCode: null);
      expect(exception.message, contains('Không có kết nối mạng'));
      expect(exception.statusCode, isNull);
    });

    test('status 503 (> 500) -> message chứa "Hệ thống đang bận"', () {
      final exception = ApiException.fromResponse(statusCode: 503);
      expect(exception.message, contains('Hệ thống đang bận'));
    });

    test('fromDioException với connectionTimeout -> statusCode 0', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/stories'),
        type: DioExceptionType.connectionTimeout,
      );
      final exception = ApiException.fromDioException(dioError);
      expect(exception.statusCode, 0);
      expect(exception.message, contains('Không có kết nối mạng'));
    });

    test('flatten errors mảng string và object từ data', () {
      final exception = ApiException.fromResponse(
        statusCode: 422,
        data: {
          'errors': {
            'username': ['Tên không hợp lệ'],
            'password': 'Mật khẩu quá ngắn',
          }
        },
      );
      expect(exception.errors, containsAll(['Tên không hợp lệ', 'Mật khẩu quá ngắn']));
      expect(exception.message, 'Tên không hợp lệ');
    });

    test('toString trả về message', () {
      const exception = ApiException(message: 'Lỗi kiểm thử', statusCode: 400);
      expect(exception.toString(), 'Lỗi kiểm thử');
    });
  });
}
