import 'package:Truckker/locator.dart';
import 'package:Truckker/models/FireDatabaseUser.dart';
import 'package:Truckker/pages/add_new_shipment.dart';
import 'package:Truckker/pages/settings_page.dart';
import 'package:Truckker/pages/user_deliveries_page.dart';
import 'package:Truckker/services/auth_service.dart';
import 'package:Truckker/services/firebase_auth.dart';
import 'package:Truckker/services/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  String userId;

  HomePage(this.userId);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Camera

  //
  bool needLabour = false;
  bool needPacking = false;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double center = height / 2;
    double end = center - 160;
    return StreamBuilder<User>(
        stream: DatabaseService(widget.userId).currentUserData,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            User user = snapshot.data;
            _firebaseMessaging.configure(
              onMessage: (Map<String, dynamic> message) async {
                print("onMessage: $message");
              },
              onLaunch: (Map<String, dynamic> message) async {
                print("onLaunch: $message");
              },
              onResume: (Map<String, dynamic> message) async {
                print("onResume: $message");
              },
            );
            _firebaseMessaging.requestNotificationPermissions(
                const IosNotificationSettings(
                    sound: true, badge: true, alert: true));
            _firebaseMessaging.getToken().then((String token) {
              assert(token != null);
              if (user.fcmDeviceId == null) {
                if (user.fcmDeviceId != token) {
                  user.fcmDeviceId = token;
                  DatabaseService(user.id)
                      .setUserData(user);
                }
              }
            });
            return Scaffold(
              appBar: AppBar(
                title: Text('WELCOME'),
                centerTitle: true,
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                        accountName: Text(user.name),
                        accountEmail: Text(user.email),
                        currentAccountPicture: ClipOval(
                          child: Image.asset(
                            'assets/profilePic.jpg',
                            fit: BoxFit.cover,
                          ),
                        )),
                    ListTile(
                      leading: Icon(Icons.traffic),
                      title: Text('Your trips'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDeliveries(user)),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.payment),
                      title: Text('Payments'),
                      onTap: () {
                        user != null
                            ? print(user.id)
                            : print('user object is null');
                        print(user.id);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Settings()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: Builder(
                builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      color: Colors.grey,
                      height: 120,
                      width: 190,
                      child: Image.asset(
                        'assets/homeLogo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Click `+` button to add delivery',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: end,
                    ),
                    Container(
                      height: 170,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border.all(
                          width: 2,
                          color: Color.fromRGBO(26, 65, 96, 1),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20),
                          ),
                          Text(
                            'Welcome , ${user.name} ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 0.5,
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Card(
                              color: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                title: Text('Want to move something ? '),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.add_box,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      //Here we will insert data into database details about delievery
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddNewShipment(widget.userId)),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
