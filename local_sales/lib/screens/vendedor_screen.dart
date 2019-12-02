import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_sales/datas/product_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'Mobile_id';

class VendedorScreen extends StatefulWidget {
  final ProductData product;

  VendedorScreen(this.product);

  @override
  _VendedorScreenState createState() => _VendedorScreenState(product);
}

class _VendedorScreenState extends State<VendedorScreen> {

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


  final ProductData product;

  _VendedorScreenState(this.product); 

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme
        .of(context)
        .primaryColor;


    return Scaffold(
      appBar: AppBar(
        title: Text("Vendedor"),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection("users").document(product.uid).get(),
        builder: (context, snapshot) {

          if(!snapshot.hasData){
            print("null");
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor)),
              ),
              color: Colors.white.withOpacity(0.8),
            );
          }
          else
          {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Align(
                      alignment: Alignment.topCenter,
                      child:
                      Container(
                        width: 267.0,
                        height: 200.0,
                        decoration: new BoxDecoration(
                            //shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(snapshot.data["photoUrl"])
                            )
                        )
                    )   
                  )
              ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                          child: Text(
                            snapshot.data["name"],
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w500),
                            maxLines: 3,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                              "E-mail: " + snapshot.data["email"],
                              style: TextStyle(
                                  fontSize: 16.0),
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            child: Text("Nascimento: " + snapshot.data["birth"],
                              style: TextStyle(
                                  fontSize: 16.0,
                              ),
                            )

                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            child: Text(
                              "PicPay: " + snapshot.data["picpay"],
                              style: TextStyle(
                                  fontSize: 18.0,
                              ),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              )
            );
          }
        },
      )
    );
  }

}