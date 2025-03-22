import 'package:flutter/material.dart';
import 'package:swastify/components/app_bar.dart';
import 'package:swastify/components/sidebar.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MessagesScreen(),
    );
  }
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: AppStrings.messages),
      drawer: SideBar(selectedIndex: 4),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: AppColors.greyText),
                hintText: AppStrings.search,
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                MessageTile(
                  name: "Haley James",
                  message: "Stand up for what you believe in",
                  unreadMessages: 9,
                ),
                MessageTile(
                  name: "Antwon Taylor",
                  message: "Meet me at the Rivercourt",
                  unreadMessages: 0,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_hospital,
              color:
                  _selectedIndex == 0 ? AppColors.primary : AppColors.greyText,
            ),
            label: AppStrings.doctor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color:
                  _selectedIndex == 1 ? AppColors.primary : AppColors.greyText,
            ),
            label: AppStrings.caregiver,
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String name;
  final String message;
  final int unreadMessages;

  const MessageTile({
    super.key,
    required this.name,
    required this.message,
    this.unreadMessages = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Icon(Icons.person, color: AppColors.primary),
      ),
      title: Text(
        name,
        style: AppText.header2.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(message, style: AppText.body2),
      trailing:
          unreadMessages > 0
              ? CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 10,
                child: Text(
                  "$unreadMessages",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.actionBackround,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : null,
    );
  }
}
