import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:pokedex_pokemon_card_mobile/services/api_service.dart';

class AuthService {

  static Future<void> ensureInitialized()
  {
    return GoogleSignInPlatform.instance.init(const InitParameters());
  }

  static Future<void> signInWithGoogle() async {
    try {
      await ensureInitialized();

      final AuthenticationResults result = await GoogleSignInPlatform.instance.authenticate(const AuthenticateParameters());

      final String? idToken = result.authenticationTokens.idToken;

      if(idToken != null)
      {
        final OAuthCredential credential = GoogleAuthProvider.credential(idToken: idToken);

        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        final firebaseUser = userCredential.user;

        if(firebaseUser != null)
        {
          final firebaseToken = await firebaseUser.getIdToken();
          print("TOKEN ------------ $firebaseToken");

          final response = await ApiService.post(
            '/Auth/firebase-login',
            body: jsonEncode({
              'firebaseToken': firebaseToken,
            }),
          );

          if (response.statusCode == 200) {
            final jwt = jsonDecode(response.body)['token'];
            print("JWT from API: $jwt");
            // Stocker le JWT dans l'interceptor pour les futures requêtes
            AuthInterceptor.setToken(jwt);

            if(jwt != null)
            {
              var user = await ApiService.get('/Auth/current-user');
              print(user.body);
            }
          }
        }
      } else {
        throw Exception("Erreur Lors de la récupération du token google");
      }

    } on GoogleSignInException catch (e) {
      throw Exception(e.code);
    }
  }
}
