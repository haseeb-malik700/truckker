import 'dart:io';

import 'package:Truckker/models/Shipment_model.dart';
import 'package:Truckker/models/home_page_model.dart';
import 'package:Truckker/pages/base_page.dart';
import 'package:Truckker/pages/location_Details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewShipment extends StatefulWidget {
  String userId;
  AddNewShipment(this.userId);
  @override
  _AddNewShipmentState createState() => _AddNewShipmentState();
}

class _AddNewShipmentState extends State<AddNewShipment> {
  File _image;

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  bool needPacking = false;
  bool needLabour = false;

  var _luggageType = ['Single Item', 'Multiple Items', 'Complete House'];

//  var selectedLuggageType = 'Single Item';
  Shipment currentShipment=new Shipment(shipmentPackage: 'Single Item',basicPrice: '500');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Shipment'),
      ),
      body:
//      BasePage<HomePageModel>(
//       onModelReady: (model){},
//       builder: (context, model, child) =>
      Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter Shipment Details',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                    color: Colors.grey[800]),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                  'What do you want to move :',
                  style: TextStyle(
                      fontSize: 14.68,
                      letterSpacing: 0.25,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w400),
                ),
                  DropdownButton<String>(
                    items: _luggageType.map(
                      (String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      },
                    ).toList(),
                    onChanged: (String selectedValue) {
                      setState(
                        () {
                          currentShipment.shipmentPackage=selectedValue;
//                          this.selectedLuggageType = selectedValue;
                          if(selectedValue == 'Multiple Items'){
                            currentShipment.basicPrice='1000';
                          }
                          if(selectedValue == 'Single Item'){
                            currentShipment.basicPrice='500';
                          }
                          if(selectedValue == 'Complete House'){
                            currentShipment.basicPrice='2000';
                          }
                        },
                      );
                    },
                    value: currentShipment.shipmentPackage,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              new TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "No of Labours",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onChanged: (String val){

                  currentShipment.numberOfLabours=val;
                },
                onSubmitted: (String val){
                  currentShipment.numberOfLabours=val;

                },
              ),
              SizedBox(height: 10),
              /*new TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Height in cm",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              new TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Width in cm",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(width: 5),
                  Text(
                    'Need packing Service :',
                    style: TextStyle(
                        fontSize: 12.68,
                        letterSpacing: 0.25,
                        color: Colors.grey[700]),
                  ),
                  //SizedBox(width:5),
                  //_buildNeedPackingCheckBox(model),
                  Checkbox(
                    value: needPacking,
                    onChanged: (val) {
                      setState(() {
                        needPacking = val;
                      });
                      print(needPacking);
                    },
                  ),
                  Text(
                    'Need Labours :',
                    style: TextStyle(
                        fontSize: 12.68,
                        letterSpacing: 0.25,
                        color: Colors.grey[700]),
                  ),
                  Checkbox(
                    value: needLabour,
                    onChanged: (bool val) {
                      setState(() {
                        needLabour = val;
                      });
                      print(needLabour);
                    },
                  ),
                ],
              ),*/
              Divider(
                thickness: 1,
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: _image == null
                      ? Image.asset(
                          'assets/sofa.jpg',
                          fit: BoxFit.cover,
                        )
                      : Image.file(_image, fit: BoxFit.cover),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Please capture image of parcel :',
                      style: TextStyle(
                          fontSize: 13.68,
                          letterSpacing: 0.25,
                          color: Colors.grey[700]),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.redAccent,
                      size: 40,
                    ),
                    onPressed: getImage,
                  ),
                ],
              ),
              Container(
                //padding: EdgeInsets.symmetric(horizontal: 100),
                height: 35,
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  onPressed: () {
                    print(currentShipment);
                    currentShipment.customerId=widget.userId;
                    currentShipment.price=int.parse(currentShipment.numberOfLabours)*500+int.parse(currentShipment.basicPrice);
                    print(currentShipment);
                    //todo: upload image to firebase storage
                    Navigator.push(
                      //Here we will insert data into database details about delievery
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationDetails( currentShipment)),
                    );
                  },
                  //padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  //color: Colors.white,
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      
    );
  }
}
