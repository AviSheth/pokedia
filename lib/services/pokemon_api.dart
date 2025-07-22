import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedia/model.dart';

class ApiService {
  static Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      List<Pokemon> pokemons = [];

      for (var item in results) {
        final detailRes = await http.get(Uri.parse(item['url']));
        final detailData = json.decode(detailRes.body);

        final imageUrl = detailData['sprites']['other']['official-artwork']['front_default'];
        final types = (detailData['types'] as List)
            .map((e) => e['type']['name'].toString())
            .toList();

        pokemons.add(Pokemon(name: item['name'], imageUrl: imageUrl, types: types));
      }

      return pokemons;
    } else {
      throw Exception("Failed to load pokemons");
    }
  }
}
