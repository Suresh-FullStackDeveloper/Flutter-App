import 'package:flutter/material.dart';
//import './register.dart';
import './resetpassword.dart';
import './dashboard.dart';
import 'package:flutter_app/data/api.dart';
//import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_app/ui/login.dart';
class LoginPage extends StatefulWidget {


  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}
enum LoginStatus { notSignIn, signIn }
class _LoginPageState extends State<LoginPage> {
  //createLoginState api = new createLoginState();
  //LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

 // TextEditingController _userNamefield = TextEditingController();
  //TextEditingController _passwordField = TextEditingController();
  final GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();

  TextEditingController userNamefield = new TextEditingController();
  TextEditingController passwordfeild = new TextEditingController();
  //final userNamefield = TextEditingController();
  //final passwordfeild = TextEditingController();
  // Getting value from Controller

  //String baseUrl = "http://kycdigi.ae/remitex/Agent_login/login_user";


  /*insertApi() async {
    final res = await http.post(baseUrl, body: {
      'username': userNamefield.text,
      'password': passwordfeild.text,

    });
  }
*/
   get logo => Container(
    alignment: Alignment(0, 0),
    child: Column(
      children: <Widget>[
        Hero(
          tag: 'DIG',
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 100.0,
            child: Image.asset('assets/logo.png'),
          ),
        )
      ],
    ),
  );






  get _userNamefield => TextFormField(
    controller: userNamefield,
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter a valid e-mail';
      }
    },
    onChanged: (value) {
      setState(() => _userNamefield == value);
    },
    decoration: InputDecoration(

        labelText: 'EMAIL',

        labelStyle:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red))),
  );

  get _passwordField => TextFormField(
    controller: passwordfeild,
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter the password';
      } else if (value.length <= 6) {
        return 'Please enter a valid password';
      }
    },
    onChanged: (value) {
      setState(() => _userNamefield == value);
    },
    decoration: InputDecoration(

        labelText: 'PASSWORD',
        labelStyle:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red))),
    obscureText: true,
  );

  get forgotPassword => Container(
    alignment: Alignment(1.0, 1.0),
    padding: EdgeInsets.only(top: 15.0, left: 20.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) =>
              new ResetPasswordPage(title: 'Reset Password'),
            ));
      },
      child: Text(
        'Forgot Password?',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            decoration: TextDecoration.underline),
      ),
    ),
  );

  get _loginButton => Container(
    height: 40.0,
    child: Material(
      borderRadius: BorderRadius.circular(20.0),
      shadowColor: Colors.red,
      color: Colors.black,
      elevation: 1.0,
      child: RaisedButton(
          color: Colors.blue,
          onPressed: () {
            _isLoading = true;
            var isValid = _formKey.currentState.validate();
            if (!isValid) {
              _isLoading = false;
            }
            if (isValid) {

              login(_userNamefield.toString(),_passwordField.toString());

              _isLoading = false;
            }
          },
          child: Center(
              child: Text(
                'LOGIN',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),

              ))),
    ),
  );


  login(username,password) async
  {
    Map data = {
      'username': username,
      'password': password
    };
    print(data.toString());
    final  response= await http.post(
        LOGIN,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },


        body: data,
        encoding: Encoding.getByName("utf-8")
    )  ;
    setState(() {
      //isLoading=false;
    });
    if (response.statusCode == 200) {
      Map<String,dynamic>resposne=jsonDecode(response.body);
      if(resposne['Status'] == 'true')
      {
        Map<String,dynamic>user=resposne['data'];
        print(" User name ${user['id']}");
        //savePref(1,user['name'],user['email'],user['id']);
        //Navigator.pushReplacementNamed(context, "/MyApp");
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
      }else{
        print(" ${resposne['message']}");
      }
      //_scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("${resposne['message']}")));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${resposne['message']}")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please try again!")));
    }


  }
  /*loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
 */
  Widget get _loadingView {
    if(_isLoading)
      return new Center(
        child: new CircularProgressIndicator(),
      );
  }
  @override
  void dispose() {
    userNamefield.dispose();
    passwordfeild.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        //resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            logo,
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  _userNamefield,
                  SizedBox(height: 20.0),
                  _passwordField,
                  SizedBox(height: 20.0),
                  forgotPassword,
                  SizedBox(height: 40.0),
                  _loginButton,
                  //_loadingView
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Powered By KYCDGI',
                  style: TextStyle(),
                ),
                SizedBox(
                  width: 5.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new MyApp(),
                        ));
                    //Navigator.of(context).pushNamed('/register');
                  },
                 child: Text('Register',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline))
                          ,

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

