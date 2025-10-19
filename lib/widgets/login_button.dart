import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
import 'package:pokedex_pokemon_card_mobile/services/auth_service.dart';


class LoginButton extends StatelessWidget {

  const LoginButton({super.key});

  
  
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 255, 225, 101),
          foregroundColor: Colors.black,
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () => (AuthService.signInWithGoogle()),
        child: Text("Connexion"),
      );
  }

  // void handleButton() async
  // {
  //   var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/1"));
  //   print(response.body);
  // }
}
