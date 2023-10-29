import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padelmarcheflutter/Login.dart';
import 'package:padelmarcheflutter/GestioneFirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:padelmarcheflutter/PaginaProfilo.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GestioneFirebase gestioneFirebase = GestioneFirebase();

  WidgetsFlutterBinding.ensureInitialized();

  // Set default home.
  Widget _defaultHome = new MyLoginPage();

  /// se non c'è un account in memoria si va alla pagina di login
  if (gestioneFirebase.checkState()) {
    // FirebaseAuth.instance.currentUser!=null) {
    _defaultHome = HomePage(); //new MyApp();
  }
  runApp(new MaterialApp(
    theme: CustomTheme.lightTheme,
    darkTheme: CustomTheme.darkTheme,
    title: 'PadelMarche',
    home: _defaultHome,

    /// si definiscono le rotta utili alla navigazione
    routes: <String, WidgetBuilder>{

      '/home': (BuildContext context) => new HomePage(),
      MyLoginPage.routeName: (BuildContext context) => new MyLoginPage(),
  //    ViewProfile.routeName: (context) => ViewProfile(),  COMMENTATO IO
   //   Comments.routeName: (context) => Comments()  COMMENTATIO IO
    },
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final GestioneFirebase gestioneFirebase = GestioneFirebase();
  bool showProgress = false;
  late String email, password;

  //String annoCorrente = "";
  // List anni = List.generate(0, (index) => null);  COMMENTATO IO
  // List posts = List.generate(0, (index) => null);  COMMENTATO IO

  late HashMap account = HashMap();

  @override
  void initState() {
    super.initState();
    init();
  }

  ///inizializzazione
  ///si recuperano le informazioni dell'account loggato
  ///si recuperano le classi associate al corso di laurea dell'account loggato
  ///si recuperano i post della classe dell'account loggato
  void init() async { /*
    await gestioneFirebase.leggiInfo().then((acc) {
      setState(() {
        account = acc;
        annoCorrente = account['idClasse'];
      });
    });
    await gestioneFirebase.downloadAnni(account['idCorso']).then((ann) {
      setState(() {
        anni = ann;
      });
    });
    await gestioneFirebase
        .leggiPosts(account['idCorso'], account['idClasse'])
        .then((ris) {
      setState(() {
        posts = ris;
      });
    }); */
  }

  ///funzione che viene richiamata quando devo visualizzare il profilo alla quale si passa l'hashMap identificativa dell'account
  void _lauchUserProfile() {
    Navigator.pushNamed(
      context,
      ViewProfile.routeName,
      arguments: MyProfile(account),
    );
  }

  ///funzione utile alla cancellazione delle informazioni salvate in locale riguardo l'account
  ///ed utile per tornare alla pagina di login
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      // the new route
      MaterialPageRoute(
        builder: (BuildContext context) => MyLoginPage(),
      ),
      ModalRoute.withName('/home'),
    );
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
  /*  return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
    //    title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ); */
  }

}


  ///definizione dei temi dell'applicazione
  class CustomTheme {
  ///tema chiaro
  static ThemeData get lightTheme {
  const Color darkRed = Color(0xFF8B0122);
  const Color red = Color(0xFFFF0000);
  const Color lightRed = Color(0xFFFF5A36);
  return ThemeData(
  primaryColor: red,
  primaryColorLight: lightRed,
  primaryColorDark: darkRed,
  colorScheme: ColorScheme(
  onPrimary: Colors.red,
  background: Colors.red,
  secondaryVariant: Colors.red,
  surface: Colors.red,
  brightness: Brightness.light,
  onError: Colors.white,
  onSecondary: Colors.red,
  primaryVariant: Colors.red,
  error: red,
  onBackground: Colors.grey.shade100,
  onSurface: Colors.black,
  //colore del bordo del form text
  secondary: lightRed,
  //Listview animation
  primary: red, //colore del bordo del form text con focus
  ),
  cardColor: Colors.white,
  textTheme: ThemeData.light().textTheme,
  scaffoldBackgroundColor: Colors.grey.shade300,
  fontFamily: 'Montserrat',
  buttonTheme: ButtonThemeData(
  buttonColor: red,
  ),
  iconTheme: ThemeData.light().iconTheme.copyWith(color: Colors.white),
  );
  }

  ///tema scuro
  static ThemeData get darkTheme {
  const Color darkRed = Color(0xFF8B0122);
  const Color red = Color(0xFFFF0000);
  const Color lightRed = Color(0xFFFF5A36);
  return ThemeData(
  primaryColor: red,
  primaryColorLight: lightRed,
  primaryColorDark: darkRed,
  colorScheme: ColorScheme(
  onPrimary: Colors.red,
  background: Colors.red,
  secondaryVariant: Colors.red,
  surface: Colors.red,
  brightness: Brightness.dark,
  onError: Colors.white,
  onSecondary: Colors.red,
  primaryVariant: Colors.red,
  error: red,
  onBackground: Colors.grey.shade600,
  onSurface: Colors.white,
  //colore del bordo del form text
  secondary: lightRed,
  //Listview animation
  primary: red, //colore del bordo del form text con focus
  ),
  cardColor: Colors.black,
  textTheme: ThemeData.dark().textTheme,
  scaffoldBackgroundColor: Colors.grey.shade800,
  fontFamily: 'Montserrat',
  buttonTheme: ButtonThemeData(
  buttonColor: red,
  ),
  iconTheme: ThemeData.dark().iconTheme.copyWith(color: Colors.white),
  );
  }
}
