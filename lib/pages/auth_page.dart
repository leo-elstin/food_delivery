import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthPage extends StatefulWidget {
  final int _phoneNumber;
  AuthPage(this._phoneNumber);

  // final ScaffoldState _scaffold;
  @override
  State<StatefulWidget> createState() => _PhoneSignInSectionState(_phoneNumber);
}

class _PhoneSignInSectionState extends State<AuthPage> {
  final int _phoneNumber;
  _PhoneSignInSectionState(this._phoneNumber);
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _title = 'Please wait while we verify your mobile number.';
  String _message = '';
  String _verificationId;

  bool _verificationSent = false;

  @override
  void initState() {
    _verifyPhoneNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Verify',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _buildPhoneAuthWidget(),
    );
  }

  Widget _buildPhoneAuthWidget() {
    return ListView(
      children: <Widget>[
        !_verificationSent ? LinearProgressIndicator() : Container(),
        Container(
          margin: EdgeInsets.only(top: 50, left: 50, right: 50),
          child: Text(
            _title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
          ),
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
        ),
        _verificationSent ? Icon(Icons.check) : Container(),
        Container(
          margin: EdgeInsets.all(32),
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 6,
            style: TextStyle(fontSize: 18),
            controller: _smsController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Verification code',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 32, right: 32),
          child: SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: () async {
                _signInWithPhoneNumber();
              },
              child: const Text(
                'Verify Now',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _message,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  // Exmaple code of how to veify phone number
  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (FirebaseUser user) {
      setState(() {
        _message = 'signInWithPhoneNumber auto succeeded: $user';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      setState(() {
        _verificationSent = true;
      });
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    // print('+91{$_phoneNumber}');

    await _auth.verifyPhoneNumber(
        phoneNumber: '+91$_phoneNumber',
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Example code of how to sign in with phone.
  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    if (user != null) {
      validateUser(user);
    }
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in, uid: ' + user.uid;
      } else {
        _message = 'Sign in failed';
      }
    });
  }

  void validateUser(FirebaseUser user) async {
    Firestore.instance
        .collection('user_list')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot ds) {
      if (ds.exists) {
      } else {
        createUser(user);
      }
    });
  }

  void createUser(FirebaseUser user) async {
     Firestore.instance
        .collection('user_list')
        .document(user.uid)
        .setData({
          'uid':user.uid,
          'phone' : user.phoneNumber
        });
  }
}
