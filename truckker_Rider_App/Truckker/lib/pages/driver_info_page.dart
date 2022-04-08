import 'package:Truckker/models/driver_page_model.dart';
import 'package:Truckker/pages/base_page.dart';
import 'package:Truckker/pages/live_tracking_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final double deviceWidth = MediaQuery.of(context).size.width-20;
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Jhon is arriving'),
        centerTitle: true,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: BasePage<DriverModel>(
        onModelReady: (model) {},
        builder: (context, model, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildProfile(),
            _buildRatings(),
            Text(
              'Jhon Doe',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Silver Suzuki Pickup',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'MKZ 282',
              style: TextStyle(letterSpacing: 2, fontSize: 20),
            ),
            Card(
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[

                 ],
              )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Theme.of(context).primaryColor,onPressed: (){} , child :Icon(Icons.chat)),
    );
  }

  Widget _buildRatings() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.star, color: Color(0xFFFFD600),),
          Icon(Icons.star, color: Color(0xFFFFD600)),
          Icon(Icons.star, color: Color(0xFFFFD600)),
          Icon(Icons.star, color: Color(0xFFFFD600)),
          Icon(Icons.star_half, color: Color(0xFFFFD600)),
        ],
      );
  }

  Widget _buildProfile() {
    return Container(
        width: 150,
        height: 170,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/profilePic.jpg',
            fit: BoxFit.cover,
          ),
        ));
  }
}
