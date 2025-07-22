import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedia/detailscreen.dart';
import 'dart:convert';
import 'package:pokedia/model.dart';
import 'package:pokedia/services/pokemon_api.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<Pokemon> pokemonList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPokemons();
  }

  Future<void> loadPokemons() async {
    try {
      final data = await ApiService.fetchPokemons();
      setState(() {
        pokemonList = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching pokemons: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Color getTypeColor(String type) {
    switch (type) {
      case 'grass':
        return Colors.greenAccent;
      case 'fire':
        return Colors.redAccent;
      case 'water':
        return Colors.blueAccent;
      case 'bug':
        return Colors.lightGreenAccent;
      case 'electric':
        return Colors.deepPurpleAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueGrey,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.3,
        ),
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          final poke = pokemonList[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detailscreen(pokemon: poke),
                  ),
                );

              },
           child:  Container(
            decoration: BoxDecoration(
              color: getTypeColor(poke.types.first),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(10),
            child :Column(
             children: [
               Align(
                 alignment: Alignment.centerLeft,
                child:  Text(
                   poke.name[0].toUpperCase() + poke.name.substring(1),
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                   ),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                   softWrap: false,
                 ),
               ),
              Row(
            children: [
            // Left side: name and types
            Expanded(
            flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var type in poke.types)
                    Container(
                      margin: EdgeInsets.only(top:2),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),

             // Right side: image
             Expanded(
               flex: 5,
               child: poke.imageUrl.isNotEmpty
                   ? Image.network(
                 poke.imageUrl,
                 fit: BoxFit.contain,
               )
                   : Icon(Icons.image_not_supported, color: Colors.white),
             ),
             ],
           ),
          ],
          ),
           ),
          );
        },
      ),
    );
  }
}
