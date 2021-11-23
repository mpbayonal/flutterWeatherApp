import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class Api {
  static final Dio _dio = Dio();
  static final Map<String, String> _headers = Map();
  static final Api _instance = Api._();

  /// Constructor privado de la Api
  Api._();

  /// Retorna una instancia de API
  static Api getInstance() => _instance;

  /// Le agrega los Headers a la peticion al backend
  Future<void> setHeaders() async {
    _headers[HttpHeaders.contentTypeHeader] = 'application/json';
  }

  /// Parsea un json en formato string a un Map
  /// Returns. Map String, dynamic
  Map<String, dynamic> decode(String response) => jsonDecode(response);

  /// Encode un json en formato Map a un String
  /// Returns. Map String, dynamic
  String encode(Map<String, dynamic> response) => jsonEncode(response);

  /// Hace peticiones get con la subruta pasada por parametro
  /// Returns Future con un Map de la respuesta
  Future<dynamic> get(String path) async {
    await setHeaders();
    final response = await _dio.get('$path',
        options: Options(headers: _headers, responseType: ResponseType.json));
    return response.data;
  }
}
