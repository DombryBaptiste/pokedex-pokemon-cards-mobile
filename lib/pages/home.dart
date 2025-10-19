import 'package:flutter/material.dart';
import 'package:pokedex_pokemon_card_mobile/widgets/login_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 35, 45),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 31, 35, 45),
        centerTitle: true,
        title: Text(
          "PokédexApp",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 260,
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white, fontSize: 18),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Bienvenue dans tes Pokédex de Cartes"),
                const Text(
                  "Répertorie ta collection Pokémon sous forme d'un pokédex",
                ),
                const Text("Tu n'es pas encore connecté ?"),
                Center(child: LoginButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
