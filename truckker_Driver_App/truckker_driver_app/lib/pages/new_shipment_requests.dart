import 'package:flutter/material.dart';
import 'package:truckker_driver_app/model/firebaseShipment.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';
import 'package:truckker_driver_app/pages/ignored_shipment_requests.dart';
import 'package:truckker_driver_app/pages/shipmentRequestInfo.dart';

class NewShipmentRequests extends StatefulWidget {
  Driver currentDriver;
  List<Shipment> allShipments;
  NewShipmentRequests(this.currentDriver,this.allShipments);

  @override
  _NewShipmentRequestsState createState() => _NewShipmentRequestsState();
}

class _NewShipmentRequestsState extends State<NewShipmentRequests> {


  @override
  Widget build(BuildContext context) {
    List<Shipment> currentPendingShipemnt=widget.allShipments.where((element) {
      if (element.packageType==widget.currentDriver.currentVehicle && element.condition=='pending')
        return true;
      return false;
    }).toList();
    
    
    return Scaffold(
        body: new ListView.builder(
            itemCount:currentPendingShipemnt.length ,
            itemBuilder: (BuildContext ctxt, int index) =>
                _buildShipmentRequestCard(currentPendingShipemnt[index]))

        /*Center(
        child: Padding(
          padding: const EdgeInsets.only(left:10.0, right: 10 ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.grey,
                height:110,
                width:180,
                child: Image.asset('assets/homeLogo.jpg', fit: BoxFit.cover,),
              ),
              SizedBox(height: 10,),
              Text(
                'You have no new requests for biding.',
                style: TextStyle(fontSize: 13.68, fontWeight: FontWeight.w400, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),*/
        );
  }

  Widget _buildShipmentRequestCard(Shipment currentPendingShipemnt) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 10, left: 3, right: 10),
      height: 200,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 10),
            Container(
              height: 200,
              width: 120,
              child: Image.asset(
                'assets/sofa.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Rs : '+currentPendingShipemnt.price.toString(),
                    style: TextStyle(
                        fontSize: 15.68,
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.location_searching,
                        color: Colors.grey[700],
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          currentPendingShipemnt.pickUpLocationName,
                          style: TextStyle(
                              fontSize: 12.68,
                              letterSpacing: 0.15,
                              color: Colors.grey[700]),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[700],
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          currentPendingShipemnt.dropOffLocationName,
                          style: TextStyle(
                              fontSize: 12.68,
                              letterSpacing: 0.15,
                              color: Colors.grey[700]),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'TODAY',
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0.15,
                            color: Colors.grey[700]),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        height: 20,
                        child: RaisedButton(
                            child: Text(
                              'Details',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShipmetRequestInfo(currentPendingShipemnt.shipmentId,widget.currentDriver),
                                ),
                              );
                            },
                            color: Colors.redAccent),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
