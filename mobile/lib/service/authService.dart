import 'package:ds_tom/model/user.dart';
import 'package:ds_tom/service/tokenStorageService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Authservice {

  Future<User> login(String email, String password) async {
    final response = await http.post(
        Uri.parse('http://localhost:3000/login'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          'email': email,
          'password': password
        }),
    );

    final Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      await TokenStorageService.save(data['token'] as String);
      return User.fromJson(data);
    }

    throw Exception(data['message'] ?? 'Erreur ${response.statusCode}');
  }

}