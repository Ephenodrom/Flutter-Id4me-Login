import 'package:flutter/material.dart';
import 'package:flutter_id4me_login/flutter_id4me_login.dart';
import 'package:id4me_relying_party_api/id4me_relying_party_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Id4me Demo Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(title: 'Id4me Demo Login'),
    );
  }
}

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map<String, dynamic> properties = {
    Id4meConstants.KEY_CLIENT_NAME: "ID4me Demo",
  };

  Map<String, dynamic> claimsParameters = {
    "name": {"required": true, "reason": "Displayname in the user data"},
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 122, 157, 1),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/img/logo.png"),
            Id4meLoginButton(
                properties,
                claimsParameters,
                "assets/img/id4meloginbtn.png",
                (Map<String, dynamic> userInfo) => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home(userInfo))),
                () => print("Error while login")),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final String title = "Home";
  final Map<String, dynamic> userInfo;

  Home(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              "Welcome",
              style: Theme.of(context).textTheme.headline,
            ),
            SizedBox(height: 10),
            Text(userInfo["name"] + "(" + userInfo["email"] + ")",
                style: Theme.of(context).textTheme.subhead),
            SizedBox(height: 10),
            Text("Your login was successfull!\n Thank you for using Id4me.",
                style: Theme.of(context).textTheme.body1)
          ])),
    );
  }
}
