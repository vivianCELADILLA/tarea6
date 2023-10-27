// ignore: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String clima = '';
  final String apiKey = 'a493f0c14d1fb02f351f2b6902f95af4';

  Future<void> obtenerDatosClima() async {
    final apiUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo,DO&appid=$apiKey');

    final respuesta = await http.get(apiUrl);

    if (respuesta.statusCode == 200) {
      final datos = json.decode(respuesta.body);
      final descripcionClima = datos['weather'][0]['description'];
      final temperatura = datos['main']['temp'] - 273.15;

      setState(() {
        clima =
            'Clima en Republica Dominicana es: $descripcionClima\nTemperatura: ${temperatura.toStringAsFixed(1)}°C';
      });
    } else {
      setState(() {
        clima = 'No se pudo obtener la información del clima.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerDatosClima();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima en RD'),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              clima,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }
}
// TODO Implement this library.