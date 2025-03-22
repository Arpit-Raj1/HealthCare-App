import 'package:flutter/material.dart';
import 'package:swastify/config/app_routes.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class SideBar extends StatefulWidget {
  final int selectedIndex;
  const SideBar({super.key, required this.selectedIndex});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void onItemTapped(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.pop(context);

    switch (index) {
      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.medicineAlerts,
          (route) => false,
        );
        break;
      // case 2:
      //   Navigator.pushNamedAndRemoveUntil(
      //     context,
      //     AppRoutes.reports,
      //     (route) => false,
      //   );
      //   break;
      // case 3:
      //   Navigator.pushNamedAndRemoveUntil(
      //     context,
      //     AppRoutes.maps,
      //     (route) => false,
      //   );
      //   break;
      case 4:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.medicineAlerts,
          (route) => false,
        );
        Navigator.pushReplacementNamed(context, AppRoutes.chatPage);
        break;
      case 5:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.emergency,
          (route) => false,
        );
        break;
      case 6:
        Navigator.pushReplacementNamed(context, AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Haley James", style: AppText.body2),
            accountEmail: Text("+91 7979737747", style: AppText.body2),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(AppStrings.profilePic),
            ),
          ),
          _buildDrawerItem(Icons.notifications, AppStrings.medicineAlerts, 1),
          _buildDrawerItem(Icons.insert_drive_file, AppStrings.reports, 2),
          _buildDrawerItem(Icons.map, AppStrings.maps, 3),
          _buildDrawerItem(
            Icons.message,
            AppStrings.messages,
            4,
            hasBadge: true,
          ),
          _buildDrawerItem(Icons.contacts, AppStrings.emergencyContactList, 5),
          _buildDrawerItem(Icons.settings, AppStrings.settings, 6),
          Spacer(),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(AppStrings.logout, style: AppText.logout),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String title,
    int index, {
    bool hasBadge = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: _selectedIndex == index ? Colors.blue : Colors.black,
      ),
      title: Text(
        title,
        style:
            _selectedIndex == index
                ? AppText.body2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                )
                : AppText.body2,
      ),
      trailing:
          hasBadge
              ? CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.primary,
                child: Text(
                  "1",
                  style: TextStyle(fontSize: 12, color: AppColors.buttonText),
                ),
              )
              : null,
      selected: _selectedIndex == index,
      selectedTileColor: const Color.fromARGB(255, 209, 229, 255),
      onTap: () => onItemTapped(context, index),
    );
  }
}
