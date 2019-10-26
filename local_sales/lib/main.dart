import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'MyApp.dart';

void main() => runApp(MyApp());

class MainScreen extends StatefulWidget {
  final String currentUserId;

  MainScreen({Key key, @required this.currentUserId}) : super(key: key);

  @override
  State createState() => MainScreenState(currentUserId: currentUserId);
}

class _MessageHandler extends StatefulWidget {
  @override
  __MessageHandlerState createState() => __MessageHandlerState();
}

class __MessageHandlerState extends State<_MessageHandler> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

