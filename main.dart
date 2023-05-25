import 'package:flutter/material.dart';
import 'package:flutter_application_ap/details.dart';
import 'package:mysql1/mysql1.dart';

void main() {
  runApp(const MyApp());
}

Future<MySqlConnection> getConnection() async {
  var settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: null,
    db: 'ap_bts_sio_2',
  );

  return await MySqlConnection.connect(settings);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '': (context) => MyHomePage(title: "Connexion"),
        '/secondPage': (context) => Page2(
              praticien: {}, // Remplacez les accolades par les données appropriées
              title: "Deuxième page",
            ),
      },
      initialRoute: '/',
      home: const MyHomePage(title: 'Liste Praticien'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> praticiens = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var connection = await getConnection();

    var results = await connection.query('SELECT * FROM client');

    setState(() {
      praticiens = results.map((row) => row.fields).toList();
    });

    await connection.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Color.fromARGB(255, 152, 219, 240),
          child: SizedBox(
            width: 300,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Liste des praticiens',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: praticiens.length,
                      itemBuilder: (context, index) {
                        var praticien = praticiens[index];
                        return ListTile(
                          title: Text(praticien['Nom'].toString()),
                          subtitle: Text(praticien['Prenom'].toString()),
                          trailing: Icon(Icons.touch_app),
                          tileColor: const Color.fromARGB(255, 220, 201, 201),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Page2(
                                  praticien: praticien,
                                  title: 'Détails du praticien',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
