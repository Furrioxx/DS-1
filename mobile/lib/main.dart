import 'package:ds_tom/service/authService.dart';
import 'package:flutter/material.dart';
import 'model/user.dart';
import 'screen/profile_screen.dart';


void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application de Connexion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(title: 'Page de Connexion'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = new Authservice();
  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  void setLoading(bool loading) {
    if(loading) {
      // on reset le mot de passe à chaque essai
      _passwordController.text = "";
    }
    setState(() {
      isLoading = loading;
    });
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        setLoading(true);
        User user = await _authService.login(email, password);

        // Connexion réussie
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProfileScreen(
                  user: user,
                ),
          ),
        );
      }
      catch (e) {
        // Connexion échouée
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erreur'),
            content: Text('Email ou mot de passe incorrect'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
      finally {
        setLoading(false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assignation de la clé au formulaire
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // Champ Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.mail),
                ),
                //keyboardType: TextInputType.visiblePassword,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  // Validation de l'email
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  // Regex simple pour valider l'email
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Champ Mot de Passe
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.lock),
                ),
                obscureText: true, // Masquer le texte
                validator: (value) {
                  // Validation du mot de passe
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.0),

              if(isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Se connecter'),
                ),
            ],
          ),
        ),
      ),

    );
  }
}
