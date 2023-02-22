import 'package:flutter/material.dart';

final roundGrey = BoxDecoration(
  color: Colors.grey[300],
  borderRadius: BorderRadius.circular(100),
);

final appbar = AppBar(
  title: const Text(
    'FB REACTION TRAY',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  ),
  centerTitle: true,
);

const likeButtonTextStyle = TextStyle(
  color: Colors.blueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);
