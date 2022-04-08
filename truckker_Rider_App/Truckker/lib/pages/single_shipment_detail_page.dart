import 'package:Truckker/models/FireDatabaseUser.dart';
import 'package:Truckker/models/Shipment_model.dart';
import 'package:Truckker/pages/bid_details_page.dart';
import 'package:Truckker/services/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class SingleShipmetDetail extends StatefulWidget {
  Shipment currentShipment;
  Driver currentShipper;
  SingleShipmetDetail(this.currentShipment);

  @override
  _SingleShipmetDetailState createState() => _SingleShipmetDetailState();
}

class _SingleShipmetDetailState extends State<SingleShipmetDetail> {
  String pickUpLocation = '';
  String dropLocation = '';
  bool isLoading = false;
  bool isRequestMade = false;

  @override
  Future<void> initState() {
    // TODO: implement initState
    setCordinate();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Shipment>(
      stream: DatabaseService(widget.currentShipment.customerId)
          .getParticularShipment(widget.currentShipment.shipmentId),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          Shipment shipment = snapshot.data;
          if (shipment.condition != 'pending') {
            widget.currentShipment.condition=shipment.condition;
            widget.currentShipment.shipperId=shipment.shipmentId;
//            _settingModalBottomSheet(context);
            isLoading = false;
          }
          else{
            isLoading=true;
          }
        }
        return !isLoading
            ? Scaffold(
                body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 30,
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 50),
                          Text(
                            'Confirm Request',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                        ],
                      ),
                      //SizedBox(height: 20),
                      Expanded(
                        //height: 450,
                        child: ListView(
                          children: <Widget>[
                            //_buildDateTimeCard(),
                            _buildpickupLocationCard(),
                            _buildDropOffLocationCard(),
                            SizedBox(height: 10),
                            _buildShipmentDetailsCard(),
                            SizedBox(height: 10),
                            _builVehicleCard(),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              child: RaisedButton(
                                  color: Colors.redAccent,
                                  child: Text(
                                    !isRequestMade?'REQUEST RIDE':'Check RIDER',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        letterSpacing: 0.25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onPressed: () {
                                    if (!isRequestMade) {
                                      widget.currentShipment.condition = 'pending';
                                      widget.currentShipment.pickUpLocationName = pickUpLocation;
                                      widget.currentShipment.dropOffLocationName = dropLocation;
                                      widget.currentShipment.shipmentId = Firestore
                                          .instance
                                          .collection('')
                                          .document()
                                          .documentID;
                                      DatabaseService(
                                              widget.currentShipment.customerId)
                                          .registerShipmentToUserList(widget.currentShipment);
                                      setState(() {
                                        isLoading = true;
                                        isRequestMade = true;
                                      });
                                    }
                                    else{
                                      _settingModalBottomSheet(context);
                                    }
                                  }),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            :Center(child: Column(
              children: <Widget>[
                Text("Your Order is sent for approval"),
                CircularProgressIndicator(),
              ],
            ));
      }
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StreamBuilder<Driver>(
            stream: DatabaseService(widget.currentShipment.customerId).getParticularDriver(widget.currentShipment.shipperId),
            builder: (context, snapshot) {
              if(snapshot.data==null)
                return Container(width: 0.0, height: 0.0);
              widget.currentShipper=snapshot.data;
              return Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // _buildBidsTile(),

                    _buildDriverDetail(context),

                    Divider(
                      thickness: 1,
                    ),

                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 2 - 30),
                      child: RaisedButton(
                          color: Colors.redAccent,
                          child: Text(
                            'SEE DETAILS',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 0.25,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BidDetail(widget.currentShipper,widget.currentShipment),
                              ),
                            );
                          }),
                    ),

                    //_buildDriverDetail(context),
                  ],
                ),
              );
            }
          );
        });
  }

  Widget _buildDriverDetail(context) {
    return ListTile(
      onTap: () {
        print('abc');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BidDetail(widget.currentShipper,widget.currentShipment)));
      },
      title: Row(
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            child: ClipOval(
              child: Image.asset(
                'assets/profilePic.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.currentShipper.name,
                    style: TextStyle(
                        fontSize: 12.68,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star),
                      Text(widget.currentShipper.review),
                    ],
                  )
                ],
              ),
              SizedBox(width: 100),
              /*Column(
                children: <Widget>[
                  Text(
                    'Bid Price',
                    style: TextStyle(
                        fontSize: 12.68,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'RS 231',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              )*/
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBidsTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '1 bids receieved ',
              style: TextStyle(
                fontSize: 14.68,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Wiating for more bids...',
              style: TextStyle(
                fontSize: 14.68,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        Text(
          'STOP BIDS ',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeCard() {
    return Container(
      child: Card(
        color: Color.fromRGBO(26, 65, 96, 0.6),
        child: ListTile(
          leading: Icon(
            Icons.access_time,
            color: Colors.white,
          ),
          title: Text(
            'Pick Date/Time',
            style: TextStyle(fontSize: 14.68, color: Colors.grey[200]),
          ),
          subtitle: Text(
            'May 09,2020|09:44 PM',
            style: TextStyle(fontSize: 14.68, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildpickupLocationCard() {
    return Container(
      child: Card(
        color: Color.fromRGBO(26, 65, 96, 0.6),
        child: ListTile(
          leading: Icon(
            Icons.location_searching,
            color: Colors.white,
          ),
          title: Text(
            'Pickup Location',
            style: TextStyle(fontSize: 14.68, color: Colors.grey[200]),
          ),
          subtitle: Text(
            pickUpLocation,
            style: TextStyle(fontSize: 14.68, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildDropOffLocationCard() {
    return Container(
      child: Card(
        color: Color.fromRGBO(26, 65, 96, 0.6),
        child: ListTile(
          leading: Icon(
            Icons.location_on,
            color: Colors.white,
          ),
          title: Text(
            'Dropoff Location',
            style: TextStyle(fontSize: 14.68, color: Colors.grey[200]),
          ),
          subtitle: Text(
            dropLocation,
            style: TextStyle(fontSize: 14.68, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildShipmentDetailsCard() {
    return Container(
      height: 156,
      //padding: EdgeInsets.only(top: 10, bottom: 10,left: 15),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, bottom: 20, right: 15, top: 10),
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width - 70,
                child: Image.asset('assets/sofa.jpg', fit: BoxFit.cover),
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.border_vertical,
                    color: Colors.grey[800],
                  ),
                  Text('N/A in',
                      style:
                          TextStyle(fontSize: 12.68, color: Colors.grey[800])),
                  SizedBox(width: 50),
                  Icon(
                    Icons.border_bottom,
                    color: Colors.grey[800],
                  ),
                  Text('33 in',
                      style: TextStyle(
                        fontSize: 12.68,
                        color: Colors.grey[800],
                      )),
                  SizedBox(width: 50),
                  Icon(
                    Icons.border_horizontal,
                    color: Colors.grey[800],
                  ),
                  Text('22 in',
                      style: TextStyle(
                        fontSize: 12.68,
                        color: Colors.grey[800],
                      )),
                ],
              ),*/
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('No of Persons requested : ',
                      style: TextStyle(
                        fontSize: 12.68,
                        color: Colors.grey[800],
                      )),
                  Icon(Icons.people, color: Colors.grey[800]),
                  Text(widget.currentShipment.numberOfLabours,
                      style: TextStyle(
                        fontSize: 12.68,
                        color: Colors.grey[800],
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _builVehicleCard() {
    return Container(
      child: Card(
        child: new ListTile(
          leading: ClipOval(
            child: Image.asset(
              'assets/${widget.currentShipment.packageType}.png',
              fit: BoxFit.cover,
            ),
          ),
          title: new Text(
            widget.currentShipment.packageType,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          onTap: () => {},
          trailing: Icon(Icons.show_chart),
        ),
      ),
    );
  }

  Future<void> setCordinate() async {
    Coordinates pickUp = Coordinates(
        double.parse(widget.currentShipment.pickUpLocation.split(',')[0]),
        double.parse(widget.currentShipment.pickUpLocation.split(',')[1]));
    var addresses = await Geocoder.local.findAddressesFromCoordinates(pickUp);
    var first = addresses.first;
    setState(() {
      pickUpLocation = first.addressLine;
    });
    Coordinates drop = Coordinates(
        double.parse(widget.currentShipment.dropLocation.split(',')[0]),
        double.parse(widget.currentShipment.dropLocation.split(',')[1]));
    var dropAddresses = await Geocoder.local.findAddressesFromCoordinates(drop);
    var dropFirst = dropAddresses.first;
    setState(() {
      dropLocation = dropFirst.addressLine;
    });
  }
}
