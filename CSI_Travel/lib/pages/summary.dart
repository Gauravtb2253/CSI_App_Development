import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

import '../consts.dart'; // Import your GPT-3 code here

class SummaryPage extends StatefulWidget {
  final String cost;
  final String destination;
  final String source;

  SummaryPage(
      {required this.cost, required this.destination, required this.source});

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final OpenAI _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY, // Use your API key
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 20),
    ),
    enableLog: true,
  );

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  void initState() {
    super.initState();
    startConversation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Advisory '),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Cost: ${widget.cost}'),
            Text('Source: ${widget.source}'),
            Text('Destination: ${widget.destination}'),
            SizedBox(height: 20.0),
            Text('Travel Advisory Summary:'),
            SizedBox(height: 10.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _messages.map((message) {
                    return Text(message.text);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startConversation() async {
    await addInitialMessages();
    await generateSummary();
  }

  Future<void> addInitialMessages() async {
    _messages.add(ChatMessage(
        user: ChatUser(id: '1', firstName: 'User', lastName: ''),
        createdAt: DateTime.now(),
        text:
            'I am planning a trip to ${widget.destination} from ${widget.source}.'
            'The estimated cost for the trip is ${widget.cost}.'
            'Plan my trip with  cost'
            'Plan my entire trip with where to travel'));

    setState(() {});
  }

  Future<void> generateSummary() async {
    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages: _messages.map((message) {
        return Messages(
          role: Role.user,
          content: message.text,
        );
      }).toList(),
      maxToken: 200,
    );

    final response = await _openAI.onChatCompletion(request: request);

    setState(() {
      for (var element in response!.choices) {
        if (element.message != null) {
          _messages.add(
            ChatMessage(
              user: ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT'),
              createdAt: DateTime.now(),
              text: element.message!.content,
            ),
          );
        }
      }
    });
  }
}
