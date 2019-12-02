import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'Mobile_id';

class AboutAppTab extends StatefulWidget {
  @override
  _AboutAppTabState createState() => _AboutAppTabState();
}

class _AboutAppTabState extends State<AboutAppTab> {

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['Game','Mario'],
  );

  BannerAd myBanner = BannerAd(
    adUnitId: BannerAd.testAdUnitId,/*"ca-app-pub-2406777328181976/7942987289",*/
    size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event){
      print("BannerAd $event");
    },
  );

  @override
  void initState(){
    FirebaseAdMob.instance.initialize(
      appId: "ca-app-pub-2406777328181976~5668193642",
    );
    myBanner..load()..show();
    super.initState();
  }

  @override
  void dispose(){
    myBanner.dispose();
    super.dispose();
  }

  final _emailController = TextEditingController();

  Widget build(BuildContext context) {
    _emailController.text = 'eng2019delta@gmail.com';

    _sendEmail() async {
      final String _email = 'mailto:' +
          _emailController.text;

      try {
        await launch(_email);
      } catch (e) {
        throw 'Could not Send Email';
      }
    }

    void _showSimpleDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
                title: Text(
                  'Relate o problema:',
                  textAlign: TextAlign.center,
                ),
                titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
                children: <Widget>[
                  Container(
                      child: Text(
                        'Envie um email para a nossa equipe para que possamos ajudar.',
                        textAlign: TextAlign.center,
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: RaisedButton(
                      onPressed: () {
                        _sendEmail();
                      },
                      child: Text("Enviar email",
                          style: TextStyle(color: Colors.black, fontSize: 16.0)),
                      color: Colors.orange,
                    ),
                  )
                ]
            );
          }
      );
    }


    return ListView(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 8.0),
                child: Text(
                  "Desenvolvedores",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                )
            ),
            Text("    Augusto César Campos Rocha"),
            Text("    Beatriz Martins Angelo"),
            Text("    Claudio Jorge Lopes Filho"),
            Text("    Gabriel Kenji de Almeida"),
            Text("    Israel da Rocha"),
            Text("    Vinícius Victor Girotto"),
          ],
        ),
        Divider(),
        Container(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: Text(
              "Versão",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            )
        ),
        Text("    1.0.0+1"),
        Divider(),
        Container(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: Text(
              "Proposta",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            )
        ),
        Text("    Facilitar a venda de produtos em comunidades "),
        Divider(),
        Container(
          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          child: GestureDetector(
            child: Text(
              "Clique para relatar um problema",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              _showSimpleDialog();
            },
          ),
        ),
        Text(
          "   Obtenha nossa ajuda",),
        Divider(),
      ],
    );
  }
}