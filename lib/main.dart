import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

List<User> users = [];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  Future getuserDetails() async {
    final _response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(_response.body);

    for (var u in data) {
      User user = User(u["name"], u["email"], u["username"]);
      users.add(user);
    }

    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "API Integration",
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
        ),
        body: Container(
          child: Card(
              child: FutureBuilder(
            future: getuserDetails(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: const Center(
                    child: Text('Loading...'),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(users[i].email),
                        subtitle: Text(users[i].name),
                        trailing: Text(users[i].userName),
                      );
                    });
              }
            },
          )),
        ));
  }
}

class User {
  final String name, email, userName;

  User(this.name, this.email, this.userName);
}
