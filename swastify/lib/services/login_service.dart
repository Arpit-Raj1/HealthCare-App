import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swastify/provider/login_provider.dart';

Future<http.Response> logIn({
  required String url,
  required Map<String, dynamic> body,
  required LoginProvider loginProvider,
}) async {
  final token = loginProvider.token;

  if (token == null || token.isEmpty) {
    throw Exception("No auth token found. Please login first.");
  }

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(body),
  );

  return response;
}
