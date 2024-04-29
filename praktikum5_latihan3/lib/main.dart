import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class University {
  String name;
  String website;

  University({required this.name, required this.website});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      website: json['web_pages'][0], // Ambil situs web pertama (jika ada)
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  late Future<List<University>> futureUniversities;

  String url = "http://universities.hipolabs.com/search?country=Indonesia";

  Future<List<University>> fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<University> universities = data.map((item) {
        return University.fromJson(item);
      }).toList();

      return universities;
    } else {
      throw Exception('Gagal load data');
    }
  }

  @override
  void initState() {
    super.initState();
    futureUniversities = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Universitas',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Universitas Indonesia'),
        ),
        body: Center(
          child: FutureBuilder<List<University>>(
            future: futureUniversities,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(snapshot.data![index].name),
                        subtitle: Text(snapshot.data![index].website),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
