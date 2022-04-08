import 'package:Truckker/models/FireDatabaseUser.dart';
import 'package:Truckker/models/Shipment_model.dart';
import 'package:Truckker/pages/bottom_navigation_bar.dart';
import 'package:Truckker/pages/live_tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BidDetail extends StatefulWidget {
  Driver currentShipper;
  Shipment currentShipment;
  BidDetail(this.currentShipper,this.currentShipment);
  @override
  _BidDetailState createState() => _BidDetailState();
}

class _BidDetailState extends State<BidDetail> {
  Future<void> _launched;

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Driver Details',
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Column(
              children: <Widget>[
                _buildDriverDetail(),
                Divider(
                  thickness: 1,
                ),
                _buildVehicleDetailsContainer(),
                Divider(
                  thickness: 1,
                ),
                SizedBox(height: 10),
               // _buildBidBreakDown(),
                SizedBox(height: 40),
              ], 
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: RaisedButton(
                color: Colors.redAccent,
                child: Text(
                  'Track Location',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavBar(widget.currentShipment),
                          ),
                        );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildDriverDetail() {
    return Row(
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
            SizedBox(width: 130),
           /* Column(
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
    );
  }

  Widget _buildVehicleDetailsContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              widget.currentShipper.phone,
              style: TextStyle(
                  letterSpacing: 0.25,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              'Suzuki',
              style: TextStyle(
                fontSize: 12.68,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Very powerful Logisics Truck',
              style: TextStyle(
                fontSize: 12.68,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 15)
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chat_bubble_outline,
                color: Colors.redAccent,
              ),
              onPressed: () => setState(
                () {
                  _launched = _makePhoneCall('sms:${widget.currentShipper.phone}');
                },
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.phone,
                color: Colors.redAccent,
              ),
              onPressed: () => setState(
                () {
                  _launched = _makePhoneCall('tel:${widget.currentShipper.phone}');
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildBidBreakDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'BID BREAKDOWN',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800]),
            ),
          ],
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Loader Service',
              style: TextStyle(
                fontSize: 14.68,
                fontWeight: FontWeight.w400,
                color: Colors.redAccent,
              ),
            ),
            Text(
              'RS  88',
              style: TextStyle(
                  fontSize: 14.68,
                  fontWeight: FontWeight.w400,
                  color: Colors.redAccent),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Packaging Service',
              style: TextStyle(
                fontSize: 14.68,
                fontWeight: FontWeight.w400,
                color: Colors.redAccent,
              ),
            ),
            Text(
              'RS 100',
              style: TextStyle(
                  fontSize: 14.68,
                  fontWeight: FontWeight.w400,
                  color: Colors.redAccent),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              ' Delivery Cost',
              style: TextStyle(
                fontSize: 14.68,
                fontWeight: FontWeight.w400,
                color: Colors.redAccent,
              ),
            ),
            Text(
              'RS 200',
              style: TextStyle(
                  fontSize: 14.68,
                  fontWeight: FontWeight.w400,
                  color: Colors.redAccent),
            ),
          ],
        ),
        SizedBox(height: 15),
        Divider(
          thickness: 1,
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              ' Grand Total',
              style: TextStyle(
                fontSize: 14.68,
                fontWeight: FontWeight.w400,
                color: Colors.redAccent,
              ),
            ),
            Text(
              'RS 388',
              style: TextStyle(
                  fontSize: 14.68,
                  fontWeight: FontWeight.w400,
                  color: Colors.redAccent),
            ),
          ],
        ),
        SizedBox(height: 15),
        Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
