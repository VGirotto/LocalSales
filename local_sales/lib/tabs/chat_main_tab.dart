import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:local_sales/tabs/chat_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class chat_main extends StatefulWidget {

  final String currentUserId;
  final String name;

  chat_main(userData, {@required this.currentUserId,@required this.name});


  @override
  _chat_mainState createState() => _chat_mainState(currentUserId: currentUserId,name: name);
}

class _chat_mainState extends State<chat_main>{

  final String name;
  final String currentUserId;

  _chat_mainState({@required this.currentUserId, @required this.name});

  final FirebaseMessaging _fcm = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  @override
  void initState(){
    super.initState();
    registerNotification();
    configLocalNotification();
  }

  void configLocalNotification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'com.dfa.flutterchatdemo',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
    new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
  }

  void registerNotification() {
    _fcm.requestNotificationPermissions();
    _fcm.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      showNotification(message['notification']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });

    _fcm.getToken().then((token) {
      print('token: $token');
      Firestore.instance.collection('users').document(currentUserId).updateData({'pushToken': token});
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }


  final Color primaryColor = Colors.orange;

  Color themeColor = Colors.deepOrange;
  Color greyColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    //print("entrou com 1 - $name");
    //print("entrou com 2 - $currentUserId");
    return Container(
      child: StreamBuilder (
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
              ),
            );
          } else{
            return ListView.builder(
              //padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => buildItem (context, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          model.loadUserData();
          List ids = new List();
          ids = model.userData["conversou"];
          int aux = 0;
          int i;
          for(i = 0;i < ids.length;i++){
            if(document['id'] == ids[i]) aux=1;
          }

          if (aux == 1 && document['id'] != currentUserId) {
            return Container(
              child: OutlineButton(
                child: Row(
                  children: <Widget>[
                    Material(
                      child: document['photoUrl'] != null
                          ? CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                          ),
                          width: 50.0,
                          height: 50.0,
                          padding: EdgeInsets.all(15.0),
                        ),
                        imageUrl: document['photoUrl'],
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      )
                          : Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.deepOrangeAccent,
                    ),
                    Flexible(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                '${document['name']}',
                                style: TextStyle(color: Colors.deepOrangeAccent,
                                  decorationColor: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Chat(
                            peerId: document.documentID,
                            peerAvatar: document['photoUrl'],
                            namePressed: document.data['name'],
                            id: currentUserId,
                          )));
                },
                color: Colors.transparent,
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
            );
          } else {
            return Container();
          }

        }
      ),
    
    );
    
  }
}
