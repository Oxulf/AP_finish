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

    var results = await connection.query(
        'SELECT praticien.*, ville.nom AS nom_ville, ville.code_postal AS code_postal_ville, notes.NoteTotalClient AS note_total_client, notes.NoteExpert AS note_expert, notes.NoteTotaux AS note_totaux, (SELECT GROUP_CONCAT(relation_praticiens_client.Commentaire SEPARATOR "\n\n") FROM relation_praticiens_client INNER JOIN client ON relation_praticiens_client.IdClient = client.id_client WHERE relation_praticiens_client.IdPraticiens = praticien.id) AS commentaires_client, (SELECT GROUP_CONCAT(equipe_expert.Commentaire SEPARATOR "\n\n") FROM equipe_expert WHERE equipe_expert.IdPraticien = praticien.id) AS commentaire_expert FROM praticien INNER JOIN ville ON praticien.id_ville = ville.id INNER JOIN departement ON ville.id_departement = departement.id INNER JOIN region ON departement.id_region = region.id LEFT JOIN notes ON praticien.id = notes.idPraticiens WHERE region.nom LIKE "%ALPES%" LIMIT 10; ');

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
                          title: Text(praticien['nom'].toString()),
                          subtitle: Row(
                            children: [
                              Text(praticien['note_totaux'].toString()),
                              Icon(Icons.star),
                            ],
                          ),
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
