import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMacroWidget extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  const MyMacroWidget({
    required this.title,
    required this.value,
    required this.icon,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 2),
                  blurRadius: 5,
                  color: Colors.grey.shade400)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              FaIcon(
                icon,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 4),
              Text(
                title == "Kcal"
                ? "$value $title"
                : "${value}g $title",
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
