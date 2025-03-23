import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '1');
  final _otherUser = const types.User(id: '2', firstName: 'Haley');
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<Map<String, String>> _uploadedReports = [];

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    final prefs = await SharedPreferences.getInstance();
    final storedMessages = prefs.getStringList('chat_messages') ?? [];

    setState(() {
      _messages.clear();
      _messages.addAll(
        storedMessages.map((msg) {
          final map = jsonDecode(msg);
          if (map['type'] == 'text') {
            return types.TextMessage(
              author: map['author'] == 'user' ? _user : _otherUser,
              createdAt: map['createdAt'],
              id: map['id'],
              text: map['text'],
            );
          } else if (map['type'] == 'image') {
            return types.ImageMessage(
              author: _user,
              createdAt: map['createdAt'],
              id: map['id'],
              uri: map['uri'],
              name: map['name'],
              size: map['size'],
            );
          } else if (map['type'] == 'file') {
            return types.FileMessage(
              author: _user,
              createdAt: map['createdAt'],
              id: map['id'],
              name: map['name'],
              uri: map['uri'],
              size: map['size'],
              mimeType: map['mimeType'],
            );
          }
          return null;
        }).whereType<types.Message>(),
      );
    });
  }

  Future<void> _saveChats() async {
    final prefs = await SharedPreferences.getInstance();
    final chatData =
        _messages
            .map((message) {
              if (message is types.TextMessage) {
                return jsonEncode({
                  'type': 'text',
                  'author': message.author.id == _user.id ? 'user' : 'other',
                  'createdAt': message.createdAt,
                  'id': message.id,
                  'text': message.text,
                });
              } else if (message is types.ImageMessage) {
                return jsonEncode({
                  'type': 'image',
                  'author': 'user',
                  'createdAt': message.createdAt,
                  'id': message.id,
                  'uri': message.uri,
                  'name': message.name,
                  'size': message.size,
                });
              } else if (message is types.FileMessage) {
                return jsonEncode({
                  'type': 'file',
                  'author': 'user',
                  'createdAt': message.createdAt,
                  'id': message.id,
                  'name': message.name,
                  'uri': message.uri,
                  'size': message.size,
                  'mimeType': message.mimeType,
                });
              }
              return null;
            })
            .whereType<String>()
            .toList();

    await prefs.setStringList('chat_messages', chatData);
  }

  void _handleSendPressed() {
    if (_textController.text.isEmpty) return;

    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: _textController.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
      _textController.clear();
    });

    _saveChats();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final imageMessage = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        uri: pickedFile.path,
        name: pickedFile.name,
        size: await pickedFile.length(),
      );

      setState(() {
        _messages.insert(0, imageMessage);
      });

      _saveChats();
    }
  }

  Future<void> _pickReport() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      String fileName = result.files.single.name;

      setState(() {
        _uploadedReports.add({"name": fileName, "path": filePath});
        _messages.insert(
          0,
          types.FileMessage(
            author: _user,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: const Uuid().v4(),
            name: fileName,
            uri: filePath,
            size: result.files.single.size,
            mimeType: 'application/pdf',
          ),
        );
      });

      _saveChats();
    }
  }

  void _openFile(String path) {
    OpenFilex.open(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];

                return GestureDetector(
                  onTap: () {
                    if (message is types.FileMessage) {
                      _openFile(message.uri);
                    } else if (message is types.ImageMessage) {
                      _openFile(message.uri);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Align(
                      alignment:
                          message.author.id == _user.id
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              message.author.id == _user.id
                                  ? Colors.blue[200]
                                  : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            message is types.TextMessage
                                ? Text(
                                  message.text,
                                  style: TextStyle(fontSize: 16),
                                )
                                : message is types.ImageMessage
                                ? message.uri.startsWith('http')
                                    ? Image.network(
                                      message.uri,
                                      width: 150,
                                      height: 150,
                                    )
                                    : Image.file(
                                      File(message.uri),
                                      width: 150,
                                      height: 150,
                                    )
                                : message is types.FileMessage
                                ? Row(
                                  children: [
                                    Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        message.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                                : SizedBox.shrink(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Row(
            children: [
              IconButton(
                icon: Icon(Icons.image),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              IconButton(
                icon: Icon(Icons.picture_as_pdf),
                onPressed: _pickReport,
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: "Type a message"),
                ),
              ),
              IconButton(icon: Icon(Icons.send), onPressed: _handleSendPressed),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
