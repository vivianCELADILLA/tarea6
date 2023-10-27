import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'WeatherScreen.dart';
import 'UniversityListScreen.dart';
import 'NewsScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction App'),
        backgroundColor: const Color.fromARGB(95, 15, 7, 7),
      ),
      body: Center(
        child: Image.asset('assets/confi.jpg', width: 300, height: 300),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(166, 0, 0, 0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text(
                'Predecir Género',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GenderPredictionScreen()));
              },
            ),
            ListTile(
              title: const Text(
                'Determinar Edad',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AgePredictionScreen()));
              },
            ),
            ListTile(
              title: const Text(
                'Clima en RD',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WeatherScreen()));
              },
            ),
            ListTile(
              title: const Text(
                'Universidades',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ), // Opción para acceder a la pantalla de universidades
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const UniversityListScreen())); // Accede a la pantalla de universidades
              },
            ),
            ListTile(
              title: const Text(
                'Noticias',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ), // Nueva opción para acceder a las noticias de The New Yorker
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewsScreen()));
              },
            ),
            ListTile(
              title: const Text(
                'Acerca de',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutScreen()));
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

class GenderPredictionScreen extends StatefulWidget {
  const GenderPredictionScreen({super.key});

  @override
  _GenderPredictionScreenState createState() => _GenderPredictionScreenState();
}

class _GenderPredictionScreenState extends State<GenderPredictionScreen> {
  String name = '';
  String gender = '';

  TextEditingController nameController = TextEditingController();

  void predictGender() async {
    final name = nameController.text;
    final response =
        await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      gender = data['gender'];
    } else {
      gender = 'No se pudo predecir';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predecir Genero'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ingresa un nombre para predecir el genero:',
              style:
                  TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: predictGender,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text('Predecir Género'),
            ),
            if (gender == 'male')
              Container(
                width: 200,
                height: 50,
                color: const Color.fromARGB(255, 17, 73, 255),
                child: const Center(
                  child: Text(
                    'Género Masculino',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            else if (gender == 'female')
              Container(
                width: 200,
                height: 50,
                color: const Color.fromARGB(255, 255, 67, 130),
                child: const Center(
                  child: Text(
                    'Género Femenino',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class AgePredictionScreen extends StatefulWidget {
  const AgePredictionScreen({super.key});

  @override
  _AgePredictionScreenState createState() => _AgePredictionScreenState();
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Center(
                child: CircleAvatar(
                  radius: 160,
                  backgroundImage: AssetImage('assets/vivi.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nombre: Vivian Celadilla Agilda',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Text(
              'Matrícula: 2021-0882',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Text(
              'Teléfono: 849-445-0757',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Text(
              'Correo: 20210882@itla.edu.do',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

class _AgePredictionScreenState extends State<AgePredictionScreen> {
  String name = '';
  String age = '';
  String ageGroup = '';
  String ageImage = '';

  TextEditingController nameController = TextEditingController();

  void predictAge() async {
    final name = nameController.text;
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      age = data['age'].toString();
      ageGroup = determineAgeGroup(int.parse(age));
      ageImage = determineAgeImage(int.parse(age));
    } else {
      age = 'No se pudo determinar';
      ageGroup = '';
      ageImage = '';
    }

    setState(() {});
  }

  String determineAgeGroup(int age) {
    if (age < 18) {
      return 'Joven';
    } else if (age >= 18 && age < 65) {
      return 'Adulto';
    } else {
      return 'Anciano';
    }
  }

  String determineAgeImage(int age) {
    if (age < 18) {
      return 'assets/bebe.jpg';
    } else if (age >= 18 && age < 65) {
      return 'assets/adult.jpg';
    } else {
      return 'assets/vieja.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Determinar Edad:',
            style: TextStyle(color: Colors.white)), // Texto en blanco
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Fondo gris
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ingresa un nombre:',
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0)), // Texto en blanco
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: predictAge,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text('Determinar Edad'),
            ),
            if (age != 'No se pudo determinar')
              Column(
                children: [
                  Text(
                    'Tu edad seria: $age ',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0)), // Texto en blanco
                  ),
                  Text(
                    'Tu eres un: $ageGroup',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0)), // Texto en blanco
                  ),
                  Image.asset(
                    ageImage,
                    width: 300, // Cambiar el ancho a 200
                    height: 300, // Cambiar el alto a 200
                  ),
                ],
              )
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Fondo gris
    );
  }
}
