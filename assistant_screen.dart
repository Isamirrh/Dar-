import 'package:flutter/material.dart';
import 'package:dar_plus/services/assistant_service.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final AssistantService _assistantService = AssistantService();
  final List<AssistantMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _addAssistantMessage('¡Hola! Soy tu guía inteligente de Dar+. ¿Cómo puedo apoyarte en tu labor hoy?');
  }

  void _addAssistantMessage(String text) {
    setState(() {
      _messages.add(AssistantMessage(text: text, isUser: false, timestamp: DateTime.now()));
    });
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add(AssistantMessage(text: text, isUser: true, timestamp: DateTime.now()));
    });
  }

  Future<void> _handleSubmitted(String text) async {
    _messageController.clear();
    _addUserMessage(text);
    final response = await _assistantService.getAssistantResponse(text);
    _addAssistantMessage(response.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistente DAR+'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _messageController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(hintText: 'Escribe tu consulta...'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_messageController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssistantMessage extends StatelessWidget {
  const AssistantMessage({required this.text, required this.isUser, required this.timestamp, super.key});

  final String text;
  final bool isUser;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isUser) ...[
            CircleAvatar(child: Text('DA')),
            const SizedBox(width: 8.0),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isUser ? 'Tú' : 'Asistente Dar+',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isUser ? Theme.of(context).primaryColor.withOpacity(0.8) : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(color: isUser ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color),
                  ),
                ),
                Text(
                  '${timestamp.hour}:${timestamp.minute}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8.0),
            CircleAvatar(child: Text('Yo')),
          ],
        ],
      ),
    );
  }
}
