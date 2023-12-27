import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'For any inquiries or assistance, please contact our support team:',
                style: TextStyle(fontSize: 16.0),
                
                
              ),
              SizedBox(height: 20.0),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email'),
                subtitle: Text('Support@express-store.com'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone'),
                subtitle: Text('+201018276518'),

              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Address'),
                subtitle: Text('10 St, Cairo, Egypt'),

              ),
            ],
          ),
        ),
      ),
    );
  }
}