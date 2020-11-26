import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kawal_corona/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ProviderContent(),
      )
    ],
    child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Kawal Covid-19"),
        backgroundColor: Color(0xff6B63FF),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              width: double.infinity,
              height: 200,
              child: Image.asset('img/corona.png'),
            ),
            Center(
              child: Text(
                "Kawal Corona di Indonesia",
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.w600,
                    fontSize: 30),
              ),
            ),
            FutureBuilder(
              future: Provider.of<ProviderContent>(context, listen: false)
                  .getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Consumer<ProviderContent>(
                  builder: (context, data, _) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Card(
                            color: Colors.blue,
                            elevation: 10,
                            child: ListTile(
                              leading: Icon(
                                Icons.coronavirus,
                                color: Colors.white,
                              ),
                              title: Text("Positif", style: TextStyle(color: Colors.white, fontSize: 20),),
                              trailing: Text(
                                data.model.konfirmasi.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Card(
                            color: Colors.green,
                            elevation: 10,
                            child: ListTile(
                              leading: Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              title: Text("Sembuh", style: TextStyle(color: Colors.white, fontSize: 20)),
                              trailing: Text(
                                data.model.sembuh.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Card(
                            color: Colors.red[400],
                            elevation: 10,
                            child: ListTile(
                              leading: Icon(
                                Icons.sick,
                                color: Colors.white,
                              ),
                              title: Text("Meninggal", style: TextStyle(color: Colors.white, fontSize: 20)),
                              trailing: Text(
                                data.model.meninggal.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Update : ${data.model.waktuUpdate}",
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Milonga"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
