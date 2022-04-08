import 'package:Truckker/pages/single_shipment_detail_page.dart';
import 'package:flutter/material.dart';

class ActiveShipments extends StatefulWidget {
  @override
  _ActiveShipmentsState createState() => _ActiveShipmentsState();
}

class _ActiveShipmentsState extends State<ActiveShipments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Text(
          'My Shipments',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20, bottom: 5),
            child: Text(
              'Active Shipments',
              style: TextStyle(
                  fontSize: 16.68,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                  color: Colors.grey),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            //height: MediaQuery.of(context).size.height / 1.3,
            child: SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _activeShipmentsCard();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activeShipmentsCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
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
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '1 bid received (Waiting)',
                    style: TextStyle(
                        fontSize: 14.68,
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'Expires in 1 hours, 41 minutes',
                    style: TextStyle(fontSize: 12.68, color: Colors.grey),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.directions_car,
                        color: Colors.black,
                      ),
                      Text(
                        'Container | 33 Kgs',
                        style: TextStyle(fontSize: 14.68, letterSpacing: 0.15),
                      )
                    ],
                  ),
                  SizedBox(height: 23),
                  Container(
                    height: 30,
                    //margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: RaisedButton(
                        child: Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => SingleShipmetDetail(),
//                            ),
//                          );
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
