import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/classes/activity_class.dart';
import 'package:http/http.dart' as http;

Future<Activity> fetchRandomActivity() async {
  final url = Uri.https('bored-api.appbrewery.com', '/random');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Activity.fromJson(json);
  } else {
    throw Exception('Failed to load activity: ${response.statusCode}');
  }
}

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course')),
      body: FutureBuilder<Activity>(
        future: fetchRandomActivity(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final activity = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.activity,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text('Type: ${activity.type}'),
                Text('Participants: ${activity.participants}'),
                Text('Duration: ${activity.duration}'),
                Text('Kid friendly: ${activity.kidFriendly}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
