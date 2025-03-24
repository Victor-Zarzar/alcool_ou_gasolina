import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FipeService {
  final String _baseUrl = dotenv.env['FIPE_API_URL'] ?? 'default_url';

  Future<List<dynamic>> fetchBrands(String type) async {
    final url = Uri.parse('$_baseUrl/$type/marcas');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(tr('error_brands'));
    }
  }

  Future<List<dynamic>> fetchModels(String type, String brandCode) async {
    final url = Uri.parse('$_baseUrl/$type/marcas/$brandCode/modelos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body)['modelos'];
    } else {
      throw Exception(tr('error_models'));
    }
  }

  Future<List<dynamic>> fetchYears(
    String type,
    String brandCode,
    String modelCode,
  ) async {
    final url = Uri.parse(
      '$_baseUrl/$type/marcas/$brandCode/modelos/$modelCode/anos',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(tr('error_years'));
    }
  }

  Future<Map<String, dynamic>> fetchDetails(
    String type,
    String brandCode,
    String modelCode,
    String yearCode,
  ) async {
    final url = Uri.parse(
      '$_baseUrl/$type/marcas/$brandCode/modelos/$modelCode/anos/$yearCode',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(tr('error_details'));
    }
  }
}
