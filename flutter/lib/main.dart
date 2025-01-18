import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RoomList(),
    );
  }
}

class RoomList extends StatelessWidget {
  Future<List<String>> fetchRooms() async {
    final response = await http
        .get(Uri.parse('http://your-django-server-url/available-rooms/'));
    if (response.statusCode == 200) {
      List rooms = json.decode(response.body);
      return rooms.map((room) => room['room_number'].toString()).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rooms'),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Room ${snapshot.data[index]}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
