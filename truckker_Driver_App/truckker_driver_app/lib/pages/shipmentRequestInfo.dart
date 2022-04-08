import 'package:flutter/material.dart';
import 'package:truckker_driver_app/model/firebaseShipment.dart';
import 'package:truckker_driver_app/model/firebase_Driver.dart';
import 'package:truckker_driver_app/pages/ignored_shipment_requests.dart';
import 'package:truckker_driver_app/pages/shipmentRoutePage.dart';
import 'package:truckker_driver_app/services/firebase_database.dart';

class ShipmetRequestInfo extends StatefulWidget {
  String shipmentId;
  Driver currentDriver;
  Shipment currentShipment;

  ShipmetRequestInfo(this.shipmentId, this.currentDriver);

  @override
  _ShipmentRequestInfoState createState() => _ShipmentRequestInfoState();
}

class _ShipmentRequestInfoState extends State<ShipmetRequestInfo> {
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Shipment>(
        stream: DatabaseService(widget.currentDriver.id)
            .getParticularShipment(widget.shipmentId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          widget.currentShipment = snapshot.data;
          if (widget.currentShipment.condition != 'pending') {
            isLoading = false;
            Navigator.pop(context);
            return Center(child: CircularProgressIndicator());
          }

          return isLoading
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
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
                              'Request Info',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          //height: 450,
                          child: ListView(
                            children: <Widget>[
                              _buildDateTimeCard(),
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
                                padding: EdgeInsets.symmetric(horizontal: 60),
                                child: RaisedButton(
                                    color: Colors.redAccent,
                                    child: Text(
                                      'I`M INTERESTED',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          letterSpacing: 0.25,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () async {
                                      isLoading = true;
                                      widget.currentShipment.condition =
                                          'accepted';
                                      widget.currentShipment.shipperId =
                                          widget.currentDriver.id;
                                      await DatabaseService(
                                              widget.currentDriver.id)
                                          .updateShipmentData(
                                              widget.currentShipment);
                                    }),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
        });
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              height: 500,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildUserDetailsContainer(),
                  _buildBidContainer(),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildDateTimeCard() {
    return Container(
      child: Card(
        color: Color.fromRGBO(26, 65, 96, 0.6),
        child: ListTile(
          leading: Icon(
            Icons.attach_money,
            color: Colors.white,
          ),
          title: Text(
            'Money',
            style: TextStyle(fontSize: 14.68, color: Colors.grey[200]),
          ),
          subtitle: Text(
            widget.currentShipment.price.toString(),
            style: TextStyle(fontSize: 14.68, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Bid sent to customer successfully.",
          ),
          content: new Text("Thankyou for using truckker",
              style: TextStyle(
                  color: Colors.grey[500], fontWeight: FontWeight.w600)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "OK",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
            widget.currentShipment.pickUpLocationName,
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
            widget.currentShipment.dropOffLocationName,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    child: Image.asset('assets/sofa.jpg', fit: BoxFit.cover),
                  )
                ],
              ),
              Row(
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
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.calendar_view_day,
                    color: Colors.grey[800],
                  ),
                  Text('33kg',
                      style: TextStyle(
                        fontSize: 12.68,
                        color: Colors.grey[800],
                      )),
                  SizedBox(width: 50),
                  Icon(Icons.check_circle_outline, color: Colors.grey[800]),
                  Text('Loading + Packaging',
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
            '${widget.currentShipment.packageType}',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          onTap: () => {},
          trailing: Icon(Icons.show_chart),
        ),
      ),
    );
  }

  final Map<String, dynamic> _formData = {
    'deliveryCost': null,
    'loaderCost': null,
    'packagingCost': null,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildBidContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Bid your price',
          style: TextStyle(
            fontSize: 12.68,
            letterSpacing: 0.15,
            color: Colors.grey[700],
          ),
        ),
        TextFormField(
          onSaved: (String value) {
            _formData['deliveryCost'] = value;
            print(_formData['deliveryCost']);
          },
          validator: (String value) {
            if (value.isEmpty ||
                !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
              return 'Price is required and should be a number. ';
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Delievry Cost(RS)',
          ),
          keyboardType: TextInputType.number,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          onSaved: (String value) {
            _formData['loaderCost'] = value;
          },
          validator: (String value) {
            if (value.isEmpty ||
                !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
              return 'Price is required and should be a number. ';
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Loading Cost(RS)',
          ),
          keyboardType: TextInputType.number,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          onSaved: (String value) {
            _formData['packagingCost'] = value;
          },
          validator: (String value) {
            if (value.isEmpty ||
                !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
              return 'Price is required and should be a number. ';
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10),
            hintText: 'packaging Cost(RS)',
          ),
          keyboardType: TextInputType.number,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.done,
                color: Theme.of(context).primaryColor,
              ),
              FlatButton(
                onPressed: () {
                  setState(() {});
                  //_submitForm();
                  _showDialog();
                },
                child: Text(
                  'SUBMIT BID',
                  style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    _formKey.currentState.save();

    if (!_formKey.currentState.validate()) {
      return;
    }
  }

  Widget _buildUserDetailsContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Expires in 1 hour, 42',
          style: TextStyle(
              fontSize: 12.68,
              letterSpacing: 0.25,
              color: Colors.grey,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 20),
        Divider(
          thickness: 1,
        ),
        SizedBox(height: 20),
        Text(
          'Jahanzaib',
          style: TextStyle(
              fontSize: 17,
              letterSpacing: 0.15,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 20),
        Text(
          'Member since May 2020',
          style: TextStyle(
              fontSize: 15,
              letterSpacing: 0.25,
              color: Colors.grey,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 20),
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.directions_car, color: Theme.of(context).primaryColor),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShipmentRoutePage(),
                    ),
                  );
                },
                child: Text(
                  'SEE DELIVERY ROUTE',
                  style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: 1,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
