import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:ytmini/app-settings.dart';
import 'dart:html';
import 'package:http/http.dart' as http;

@provide
@singleton
class AccountEndpointService {

  String get accountUrl {
    return AppSettings.apiUrl + "/api/accounts/";
  }

  Future login(String username, String password) async {
    final query = {
      'userName': username,
      'password': password
    };

    var response = await http.get(Uri.https(accountUrl+"login", "", query));

    if(response.statusCode != 200){
      throw Exception("Failed to login account");
    }
    else {
      var json = jsonDecode(response.body);
      AppSettings.accessToken = json['accessToken'];
    }
  }

  Future logout() async{
    var response = await http.post(Uri.parse(accountUrl+"logout"));

    if(response.statusCode != 200) {
      throw Exception("Failed to logout account");
    }
    else {
      AppSettings.accessToken = "";
    }
  }
}