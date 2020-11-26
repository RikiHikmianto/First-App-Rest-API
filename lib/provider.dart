import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kawal_corona/model.dart';
import 'dart:convert';

class ProviderContent with ChangeNotifier {
  Model model;

  Future<void> getData() async {
    final url = 'https://covid19.mathdro.id/api/countries/ID';
    final response = await http.get(url);

    final result = json.decode(response.body) as Map<String, dynamic>;

    model = Model(
        konfirmasi: result['confirmed']['value'],
        sembuh: result['recovered']['value'],
        meninggal: result['deaths']['value'],
        waktuUpdate: result['lastUpdate'],);

        notifyListeners();
  }
}
