import 'package:covid_19_app/Modals/world_state_model.dart';
import 'package:covid_19_app/View_Modal/Utils/app_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldStateApi {
  Future<WorldStateModel> fetchWorldStateProducts() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> fetchCountriesListApi() async {
    dynamic data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
