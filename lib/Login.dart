import 'package:flutter/material.dart';
import 'package:padelmarcheflutter/GestioneFirebase.dart';
import 'package:padelmarcheflutter/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyLoginPage extends StatefulWidget {
  static const routeName = '/login';
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  bool emailcorretta = true;
  bool nascondipassword = true;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text("Accedi a MySocialUnivpm"),
      ), //AppBar
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: showProgress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "PadelMarche",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 40.0),
                ), //Text
              ),
              ClipOval(
                child: Image.asset("images/logo.png",width: 120.0,height: 120.0,fit: BoxFit.fill,),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 40.0,right: 40.0),
                child: TextFormField(
    //          cursorColor: Theme.of(context).cursorColor,  CAMBIATA IO
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value; // get value from TextField
                  setState(() {
                    emailcorretta = email.isEmpty ||
                        (email.startsWith('s') || email.startsWith('S')) &&
                              email.endsWith('@studenti.univpm.it');
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: emailcorretta ? null : 'Email non valida',
                  border: OutlineInputBorder(),
                  suffixIcon: emailcorretta ? null : Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 40.0,right: 40.0),
              child: TextFormField(
                obscureText: nascondipassword? true:false,
                keyboardType: TextInputType.visiblePassword,
  //            cursorColor: Theme.of(context).cursorColor,  CAMBIATA IO
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value; //get value from textField
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon:nascondipassword? IconButton(
                    icon: Icon(Icons.visibility,),
                          onPressed:(){
                            setState(() {
                              nascondipassword=!nascondipassword;
                            });
                          }
                  ):IconButton(
                      icon:Icon(Icons.visibility_off),
                    onPressed: (){
                      setState(() {
                        nascondipassword=!nascondipassword;
                      });
                    }
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Material(
              elevation: 5,
              color: Theme.of(context).primaryColor,//Colors.red,
              borderRadius: BorderRadius.circular(2.0),
              child: MaterialButton(
                onPressed: () async {
                  setState(() {
                    showProgress = true;
                  });
                  try {
                    ///login su firebase
                    final newUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    print(newUser.toString());
                    if (newUser != null) {
                      ///check se un account è verificato
                      if (newUser.user!.emailVerified) {
                        setState(() {
                          showProgress = false;
                        });

                        ///navigazione verso la homepage
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return HomePage();//MyApp();
                          }),
                        );
                        //Navigator.of(context).pushNamed("/home");
                      }
                    }
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: "Credenziali errate o email non verificata",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    setState(() {
                      showProgress = false;
                    });
                  }
                },
                minWidth: 200.0,
                height: 45.0,
                child: Text(
                    "ACCEDI",
                    style:TextStyle(fontWeight: FontWeight.w500,color: Colors.white, fontSize: 20.0),
                )
              )
            ),
            ],
      ),
    ),
    ),
    );
  }

  //ULTERIORI FUNZIONI
}