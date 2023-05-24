import 'package:flutter/material.dart';
import 'package:flutter_application_ap/details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '': (context) => MyHomePage(title: "Connexion"),
        '/secondPage': (context) => Page2(title: "Deuxième page"),
      },
      initialRoute: '/',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 25,
                  ), //SizedBox
                  ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      ListTile(
                          title: const Text('Davy'),
                          subtitle: Text('8/10'),
                          trailing: Icon(Icons.touch_app),
                          tileColor: const Color.fromARGB(255, 220, 201, 201),
                          onTap: () {
                            print('Cheval');
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                          title: const Text('Nathan'),
                          subtitle: Text('8.5/10'),
                          trailing: Icon(Icons.touch_app),
                          tileColor: const Color.fromARGB(255, 220, 201, 201),
                          onTap: () {
                            Navigator.pushNamed(context, '/secondPage');
                          })
                    ],
                  )
                ],
              ),
            ), //Column
          ), //Padding
        ), //SizedBox
      ), //Card
    );
  }
}

/*TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {},
                      child: Text('Details'),
                    )
*/