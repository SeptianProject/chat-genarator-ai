import 'dart:developer';

import 'package:chatapp_ai/pages/widgets/chat_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyAFOAVPZeNnx2rEbJuT6xEZb2GAFxtjnSo';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final model =
      GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);
  TextEditingController messageController = TextEditingController();

  bool isLoading = false;

  List<ChatBubble> chatBubbles = [
    const ChatBubble(
      direction: Direction.left,
      message: 'Hello, septianz I am Ronaldo, your personal AI assistant.',
      photoUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlwMiO40OFJ_2WF4te1jNUKq0_ZJ7Uc3Gigg&s',
      type: BubbleType.single,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: CupertinoButton(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('Ronaldo AI', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              reverse: true,
              padding: const EdgeInsets.all(10),
              children: chatBubbles.reversed.toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? const CupertinoActivityIndicator()
                    : IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          if (messageController.text.isEmpty) return;
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            final content = [
                              Content.text(messageController.text)
                            ];

                            final GenerateContentResponse responseAI =
                                await model.generateContent(content);

                            chatBubbles = [
                              ...chatBubbles,
                              ChatBubble(
                                direction: Direction.right,
                                message: messageController.text,
                                photoUrl: null,
                                type: BubbleType.single,
                              )
                            ];

                            chatBubbles = [
                              ...chatBubbles,
                              ChatBubble(
                                direction: Direction.left,
                                message: responseAI.text ??
                                    'Sorry, I don\'t know paham🤚',
                                photoUrl:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlwMiO40OFJ_2WF4te1jNUKq0_ZJ7Uc3Gigg&s',
                                type: BubbleType.single,
                              )
                            ];
                          } catch (e) {
                            log(e.toString());
                            chatBubbles = [
                              ...chatBubbles,
                              const ChatBubble(
                                direction: Direction.left,
                                message:
                                    'An error occurred. Please try again later.',
                                photoUrl:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlwMiO40OFJ_2WF4te1jNUKq0_ZJ7Uc3Gigg&s',
                                type: BubbleType.single,
                              )
                            ];
                          } finally {
                            messageController.clear();

                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
