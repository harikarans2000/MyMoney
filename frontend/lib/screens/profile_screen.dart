import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person,size:50),
            ),

            SizedBox(height:20),

            Text(
              "Harikaran",
              style: TextStyle(
                fontSize:28,
                fontWeight:FontWeight.bold,
              ),
            ),

            SizedBox(height:10),

            Text("PhD Scholar"),

            SizedBox(height:30),

            ListTile(
              leading: Icon(Icons.email),
              title: Text("Email"),
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            )

          ],
        ),
      ),
    );
  }
}