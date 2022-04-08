import 'package:Truckker/models/FireDatabaseUser.dart';
import 'package:Truckker/models/Shipment_model.dart';
import 'package:Truckker/services/firebase_database.dart';
import 'package:flutter/material.dart';

class UserDeliveries extends StatelessWidget {
  User currentUser;

  UserDeliveries(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Shipment>>(
      stream: DatabaseService(currentUser.id).userShipments,
      builder: (BuildContext context, AsyncSnapshot<List<Shipment>> snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          List<Shipment> currentShipemnts = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Your Deliveries'),
              elevation: 0.0,
              centerTitle: true,
            ),
            // ignore: missing_return
            body:currentUser.shipments.isEmpty
                    ? Center(
                        child: Text(
                            'Sorry you do not have any deliveries right know'),
                      )
                    : Container(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: currentShipemnts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: GestureDetector(
                                onTap: (){

                                },
                                child: Card(
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset('assets/sofa.jpg',
                                          fit: BoxFit.cover),
                                      Divider(),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                            Text(
                                              currentShipemnts
                                                  .elementAt(index)
                                                  .condition,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                            Text(
                                              currentShipemnts
                                                  .elementAt(index)
                                                  .price.toString(),
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 30),
                        ),
                      ),
          );
        }
      },
    );
  }
}
