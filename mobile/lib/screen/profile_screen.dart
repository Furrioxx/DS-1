import 'package:ds_tom/model/user.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('Profil de l\'Utilisateur'),
    actions: [
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          // Action de déconnexion
          Navigator.pop(context);
        },
      ),
    ],
    ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Affichage des informations du profil
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Nom'),
              subtitle: Text('${user.firstname} ${user.lastname}'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text(user.email),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Rôle'),
              subtitle: Text(user.role),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Déconnexion en retournant à l'écran de connexion
                Navigator.pop(context);
              },
              child: Text('Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
