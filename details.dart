import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Page2(
        title: 'Flutter Demo Home Page',
        praticien: {},
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  final Map<String, dynamic> praticien;
  final String title;

  const Page2({Key? key, required this.praticien, required this.title});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
                    'Détails du praticien',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Nom : ${widget.praticien['nom']}'),
                  Text('Prenom : ${widget.praticien['prenom']}'),
                  Text('Adresse : ${widget.praticien['adresse']}'),
                  Text('Ville : ${widget.praticien['nom_ville']}'),
                  Text(
                      'Code Postal : ${widget.praticien['code_postal_ville']}'),
                  SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Note Expert - ${widget.praticien['note_expert']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Color.fromARGB(255, 179, 177, 177),
                    child: Text.rich(
                      TextSpan(
                        text: 'Commentaire : \n\n',
                        children: <TextSpan>[
                          TextSpan(
                            text: '${widget.praticien['commentaire_expert']}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Notes des Clients - ${widget.praticien['note_total_client']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Color.fromARGB(255, 179, 177, 177),
                    child: Text.rich(
                      TextSpan(
                        text: 'Commentaire : \n\n',
                        children: <TextSpan>[
                          TextSpan(
                            text: '${widget.praticien['commentaires_client']}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 7, 7, 7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Revenir sur la liste des praticiens',
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
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
