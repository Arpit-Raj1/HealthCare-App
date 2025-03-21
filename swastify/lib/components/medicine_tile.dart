import 'package:flutter/material.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class MedicineTile extends StatelessWidget {
  final String name;
  final List<String> times;
  final bool enabled;
  final Function(bool) onChanged;
  final VoidCallback onTap;

  MedicineTile({
    required this.name,
    required this.times,
    required this.enabled,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.alarm, color: AppColors.primary, size: 40),
      title: Text(name, style: AppText.header2),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            times.map((time) => Text(time, style: AppText.body2)).toList(),
      ),
      trailing: Switch(
        value: enabled,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }
}
