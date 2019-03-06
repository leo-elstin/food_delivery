import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthPage extends StatefulWidget {
  final int _phoneNumber;
  AuthPage(this._phoneNumber);

  // final ScaffoldState _scaffold;
  @override
  State<StatefulWidget> createState() => _PhoneSignInSectionState(_phoneNumber);
}

class _PhoneSignInSectionState extends State<AuthPage> {
  final _phoneNumber ;
  _PhoneSignInSectionState(this._phoneNumber);
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _message = '';
  String _verificationId;

  bool verificationSent =false;

  @override
  void initState() {
    print('is loading');
      // _verifyPhoneNumber();
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
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         !verificationSent? LinearProgressIndicator() :Container(),
        Container(
          child: const Text('Test sign in with phone number'),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
        ),
       
        // TextFormField(
        //   controller: _phoneNumberController,
        //   decoration:
        //       InputDecoration(labelText: 'Phone number (+x xxx-xxx-xxxx)'),
        //   validator: (String value) {
        //     if (value.isEmpty) {
        //       return 'Phone number (+x xxx-xxx-xxxx)';
        //     }
        //   },
        // ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () async {
              _verifyPhoneNumber();
            },
            child: const Text('Verify phone number'),
          ),
        ),
        TextField(
          controller: _smsController,
          decoration: InputDecoration(labelText: 'Verification code'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () async {
              _signInWithPhoneNumber();
            },
            child: const Text('Sign in with phone number'),
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
        // Builder(
        //   builder: (bs){
             
        //     return Container();
        //   } ,
        // )
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
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content:
      //       const Text('Please check your phone for the verification code.'),
      // ));
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: '+91{_phoneNumber]',
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
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in, uid: ' + user.uid;
      } else {
        _message = 'Sign in failed';
      }
    });
  }
}
