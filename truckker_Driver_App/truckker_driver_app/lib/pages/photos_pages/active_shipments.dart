import 'package:flutter/material.dart';
import 'package:truckker_driver_app/model/firebaseShipment.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';
import 'package:truckker_driver_app/services/firebase_database.dart';

class ActiveShipments extends StatefulWidget {
  Driver currentDriver;
  List<Shipment> allShipments;
  ActiveShipments(this.currentDriver,this.allShipments);
  @override
  _ActiveShipmentsState createState() => _ActiveShipmentsState();
}

class _ActiveShipmentsState extends State<ActiveShipments> {
  @override
  Widget build(BuildContext context) {
    List<Shipment> activeShipment=widget.allShipments.where((element){
      if(element.condition=='accepted'&& element.shipperId==widget.currentDriver.id)
        return true;
      return false;
    }).toList();

    return Scaffold(
        body:  new ListView.builder(
            itemCount:activeShipment.length ,
            itemBuilder: (BuildContext ctxt, int index) =>
                _buildShipmentRequestCard(activeShipment[index]))



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
                'You haven`t submitted bids on any shipment requests lately.',
                style: TextStyle(fontSize: 13.68, fontWeight: FontWeight.w400, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),*/
    );
  }

  Widget _buildShipmentRequestCard(Shipment activeShipment) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 10, left: 10, right: 10),
      height: 200,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 10),
            Container(
              height: 200,
              width: 100,
              child: Image.asset(
                'assets/sofa.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    activeShipment.condition,
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
                          activeShipment.pickUpLocationName,
                          style: TextStyle(
                              fontSize: 12.68,
                              letterSpacing: 0.15,
                              color: Colors.grey[700]),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
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
                          activeShipment.dropOffLocationName,
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
                        activeShipment.price.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0.15,
                            color: Colors.grey[700]),
                      ),

                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    height: 20,
                    child: RaisedButton(
                        child: Text(
                          'Complete Ride',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          activeShipment.condition='Completed';
                          DatabaseService(widget.currentDriver.id).updateShipmentData(activeShipment);
                        },
                        color: Colors.redAccent),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}