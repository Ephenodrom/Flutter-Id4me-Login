part of flutter_id4me_login;

///
/// The Id4me login button for easy integration of the Id4me login flow
///
class Id4meLoginButton extends StatefulWidget {
  final double height;
  final String imageLocation;
  final Text loginBtnText;
  final Text cancelBtnText;
  final Text modalHintText;
  final Map<String, dynamic> claimsParameters;
  final Map<String, dynamic> properties;
  final InputDecoration inputDecoration;

  final Function(Map<String, dynamic>) onSuccess;
  final Function() onError;

  Id4meLoginButton(this.properties, this.claimsParameters, this.imageLocation,
      this.onSuccess, this.onError,
      {this.height = 45,
      this.inputDecoration = const InputDecoration(),
      this.loginBtnText = const Text("Login"),
      this.cancelBtnText = const Text("Cancel"),
      this.modalHintText});

  @override
  _Id4meLoginButtonState createState() => _Id4meLoginButtonState();
}

class _Id4meLoginButtonState extends State<Id4meLoginButton> {
  Id4meLogon logon;
  Id4meSessionData sessionData;

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        displayDomainInput();
      },
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(widget.imageLocation))),
      ),
    );
  }

  void displayDomainInput() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return SimpleDialog(children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: widget.modalHintText,
              )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    controller: controller, decoration: widget.inputDecoration),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      child: widget.loginBtnText,
                      onPressed: () {
                        processId4meLogin(controller.text);
                      }),
                  FlatButton(
                    child: widget.cancelBtnText,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )
            ]);
          });
        });
  }

  Future<void> processId4meLogin(String domain) async {
    Map<String, dynamic> prop = widget.properties;
    prop[Id4meConstants.KEY_REDIRECT_URI] = "https://id4meflutterredirect.com";
    logon = buildLogon(prop, widget.claimsParameters);
    sessionData = await buildSessionData(domain);
    String url = logon.buildAuthorizationUrl(sessionData);
    String code = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Id4meLoginWebScreen(url)),
    );
    await logon.authenticate(sessionData, code);
    Map<String, dynamic> userInfo = await logon.fetchUserinfo(sessionData);
    widget.onSuccess(userInfo);
  }

  Id4meLogon buildLogon(
      Map<String, dynamic> properties, Map<String, dynamic> claimsParameters) {
    return Id4meLogon(
        properties: properties, claimsParameters: claimsParameters);
  }

  Future<Id4meSessionData> buildSessionData(String domain) async {
    return await logon.createSessionData(domain, true);
  }
}
