import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:ct_flutter_native_push/second_page.dart';
import 'package:flutter/material.dart';

late CleverTapPlugin _clevertapPlugin;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp( MyApp());
}

Future<void> init() async {
  _clevertapPlugin = CleverTapPlugin();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{
        MyHomePage.routeName: (_) => MyHomePage(),
        SecondPage.routeName: (_) => SecondPage()
      },
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage( {Key? key,}) : super(key: key);
  final String title = "Home";
  static const String routeName = '/home';


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CleverTapPlugin.setDebugLevel(2);
    _clevertapPlugin.setCleverTapPushClickedPayloadReceivedHandler(pushClickedPayloadReceived);
    CleverTapPlugin.createNotificationChannel("fluttertest", "Flutter Test", "Flutter Test", 3, true);
    CleverTapPlugin.createNotificationChannel("Tester", "Tester", "Flutter Test", 4, true);
  }

  void pushClickedPayloadReceived(Map<String, dynamic> map) {
    print("pushClickedPayloadReceived called");
    setState(() async {
      var data = jsonEncode(map);
      print("on Push Click Payload = $data");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is a test app for custom push notification handling',
            ),
            ElevatedButton(onPressed: (){
              var stuff = ["bags", "shoes"];
              var profile = {
                'Name': 'Captain America',
                'Identity': '100',
                'Email': 'captain@america.com',
                'Phone': '+14155551234',
                'stuff': stuff
              };
              CleverTapPlugin.onUserLogin(profile);
            }, child: const Text("Login")),
            ElevatedButton(onPressed: (){
              var eventData = {
                // Key:    Value
                'Amount': 100,
                'type': 'UPI'
              };

              CleverTapPlugin.recordEvent("Charged", eventData);
            }, child: const Text("Charged")),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
