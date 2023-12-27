import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_store/home.dart';
import 'package:online_store/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
  }

  void _changeEmail() {}

  void _changePassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        late String oldPassword;
        late String newPassword;

        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Old Password'),
                obscureText: true,
                onChanged: (value) {
                  oldPassword = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onChanged: (value) {
                  newPassword = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  if (oldPassword.isEmpty || newPassword.isEmpty) {
                    print('Please enter both old and new passwords.');
                    return;
                  }

                  await _auth.currentUser!.updatePassword(newPassword);
                  print('Password changed successfully');
                  Navigator.of(context).pop();
                } catch (e) {
                  print('e');
                }
              },
              child: Text('Change'),
            ),
          ],
        );
      },
    );
  }

  void _logout() async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome, ${_user.displayName ?? _user.email}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _user.email!,
                style: TextStyle(fontSize: 18),
              ),
              trailing: ElevatedButton(
                onPressed: _changeEmail,
                child: Text('Change'),
              ),
            ),
            ListTile(
              title: Text(
                'Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '********',
                style: TextStyle(fontSize: 18),
              ),
              trailing: ElevatedButton(
                onPressed: _changePassword,
                child: Text('Change'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
