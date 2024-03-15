import 'package:flutter/material.dart';

class IconNameTag extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final IconData icon;
  const IconNameTag({
    super.key,
    this.color = Colors.grey,
    required this.text,
    this.size = 13,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 13,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class NameTag extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  const NameTag({
    super.key,
    this.color = Colors.grey,
    required this.text,
    this.size = 17,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }
}

class PartyTag extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  const PartyTag({
    super.key,
    this.color = Colors.grey,
    required this.text,
    this.size = 17,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }
}
