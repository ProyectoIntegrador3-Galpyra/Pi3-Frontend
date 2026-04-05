import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poultry_trace_app/core/errors/exceptions.dart';
import 'package:poultry_trace_app/core/network/api_response_parser.dart';

void main() {
  group('ApiResponseParser.asMap', () {
    test('returns map when input is already Map<String, dynamic>', () {
      final source = <String, dynamic>{'a': 1};

      final result = ApiResponseParser.asMap(source);

      expect(result, {'a': 1});
    });

    test('converts Map<dynamic, dynamic> keys to String', () {
      final source = {1: 'a', 'b': 2};

      final result = ApiResponseParser.asMap(source);

      expect(result, {'1': 'a', 'b': 2});
    });

    test('returns empty map for non-map values', () {
      final result = ApiResponseParser.asMap('not-map');

      expect(result, isEmpty);
    });
  });

  group('ApiResponseParser.extractMessage', () {
    test('uses message when available', () {
      final result = ApiResponseParser.extractMessage({'message': 'ok'});

      expect(result, 'ok');
    });

    test('falls back to error.message when top-level message is absent', () {
      final result = ApiResponseParser.extractMessage({
        'error': {'message': 'bad request'}
      });

      expect(result, 'bad request');
    });

    test('returns fallback when no message exists', () {
      final result = ApiResponseParser.extractMessage({}, fallback: 'fallback');

      expect(result, 'fallback');
    });
  });

  group('ApiResponseParser.extractStatusCode', () {
    test('reads int status code', () {
      expect(ApiResponseParser.extractStatusCode({'status_code': 422}), 422);
    });

    test('reads numeric status code and converts to int', () {
      expect(ApiResponseParser.extractStatusCode({'status_code': 429.0}), 429);
    });

    test('reads string status code', () {
      expect(ApiResponseParser.extractStatusCode({'status_code': '500'}), 500);
    });

    test('returns null for invalid status_code', () {
      expect(ApiResponseParser.extractStatusCode({'status_code': 'abc'}), isNull);
    });
  });

  group('ApiResponseParser.extractDataMap', () {
    test('returns data when data is map', () {
      final body = {
        'data': {'id': '1'}
      };

      final result = ApiResponseParser.extractDataMap(body);

      expect(result, {'id': '1'});
    });

    test('returns full body when data is missing and allowBodyAsData true', () {
      final body = {'id': '1'};

      final result = ApiResponseParser.extractDataMap(body);

      expect(result, {'id': '1'});
    });

    test('returns empty map when data is missing and allowBodyAsData false', () {
      final body = {'id': '1'};

      final result = ApiResponseParser.extractDataMap(body, allowBodyAsData: false);

      expect(result, isEmpty);
    });
  });

  group('ApiResponseParser.extractDataList', () {
    test('returns data when data is list', () {
      final body = {
        'data': [1, 2, 3]
      };

      final result = ApiResponseParser.extractDataList(body);

      expect(result, [1, 2, 3]);
    });

    test('returns empty list when data is not a list', () {
      final body = {
        'data': {'id': '1'}
      };

      final result = ApiResponseParser.extractDataList(body);

      expect(result, isEmpty);
    });
  });

  group('ApiResponseParser.toServerException', () {
    test('maps DioException response data into ServerException', () {
      final options = RequestOptions(path: '/api/test');
      final response = Response<dynamic>(
        requestOptions: options,
        statusCode: 422,
        data: {
          'message': 'payload invalido',
          'status_code': 422,
        },
      );
      final exception = DioException(
        requestOptions: options,
        response: response,
        type: DioExceptionType.badResponse,
      );

      final result = ApiResponseParser.toServerException(
        exception,
        fallbackMessage: 'fallback',
      );

      expect(result, isA<ServerException>());
      expect(result.message, 'payload invalido');
      expect(result.statusCode, 422);
      expect(result.originalException, exception);
    });

    test('uses fallback message when response body has no message', () {
      final options = RequestOptions(path: '/api/test');
      final response = Response<dynamic>(
        requestOptions: options,
        statusCode: 500,
        data: {'error': {}},
      );
      final exception = DioException(
        requestOptions: options,
        response: response,
        type: DioExceptionType.badResponse,
      );

      final result = ApiResponseParser.toServerException(
        exception,
        fallbackMessage: 'server error',
      );

      expect(result.message, 'server error');
      expect(result.statusCode, 500);
    });
  });
}
