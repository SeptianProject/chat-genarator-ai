import 'package:chatapp_ai/pages/chat_page.dart';
import 'package:chatapp_ai/pages/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Chat App"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                icon: const Icon(Icons.logout)),
          )
        ],
      ),
      body: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigoAccent,
                  radius: 25,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                title: Text('Chat ${index + 1}'),
                subtitle: const Text('Last message'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatPage()));
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }),
    );
  }
}
