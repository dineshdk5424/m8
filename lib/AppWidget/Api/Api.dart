import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = new LocalStorage('local_store');

class Api {
  getStaffList(context) async {
    var result = await http.get(
      Uri.parse("http://m8itsolutions.in/mobilestaticapp/events/exhibitor/staff_list.json"),
      headers: {"Content-Type": "application/json"},
    );
    return json.decode(result.body);
  }
}
