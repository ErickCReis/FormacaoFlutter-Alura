import 'dart:convert';
import 'package:meetups/models/device.dart';
import 'package:meetups/models/event.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://localhost:8080/api';

Future<List<Event>> getAllEvents() async {
  final response = await http.get(Uri.parse('$baseUrl/events'));

  if (response.statusCode == 200) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Event.fromJson(json)).toList();
  } else {
    throw Exception('Falha ao carregar os eventos');
  }
}

Future<void> sendDevice(Device device) async {
  final response = await http.post(
    Uri.parse('$baseUrl/devices'),
    headers: {'Content-Type': 'application/json; charset=utf-8'},
    body: jsonEncode({
      'token': device.token ?? '',
      'modelo': device.model ?? '',
      'marca': device.brand ?? '',
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Falha ao enviar o token');
  }
}
