import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class UniversityListScreen extends StatefulWidget {
  const UniversityListScreen({super.key});

  @override
  _UniversityListScreenState createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  TextEditingController countryController = TextEditingController();
  List<University> universities = [];

  Future<void> fetchUniversities(String country) async {
    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$country'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<University> universityList =
          List<University>.from(data.map((item) => University.fromJson(item)));

      setState(() {
        universities = universityList;
      });
    } else {
      // Handle error
      setState(() {
        universities = [];
      });
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir el enlace: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades'),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: countryController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingresa el país en inglés'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String country = countryController.text.trim();
                fetchUniversities(country);
              },
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: const Text('Buscar Universidades'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _launchURL(universities[index].webPage);
                    },
                    child: ListTile(
                      title: Text(universities[index].name),
                      subtitle: Text(
                          'Dominio: ${universities[index].webDomains}\nSitio web: ${universities[index].webPage}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class University {
  String name;
  String webDomains;
  String webPage;

  University(
      {required this.name, required this.webDomains, required this.webPage});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      webDomains: json['web_pages'].join(', '),
      webPage: json['web_pages'][0],
    );
  }
}
