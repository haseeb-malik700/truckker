import 'package:Truckker/graphql/mutation.dart';
import 'package:Truckker/models/base_model.dart';
import 'package:Truckker/objects/Shipment.dart';
import 'package:Truckker/objects/add_shipment.dart';
import 'package:Truckker/services/userData_service.dart';
import 'package:Truckker/view_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../locator.dart';

class UserModel extends BaseModel {

   final UserData _fetchData = locator<UserData>();
  
    Shipment shipment;

  Future<void> getUserDeliveries(String userId) async {
    setState(ViewState.Busy);
    print('State set to busy now getting data ');
    shipment=await _fetchData.getShipment(userId);
    print('got data ');
    if(shipment!=null){
      print('shipper not null');
    }
   print(shipment.shipper.shippments.elementAt(0).delievryDate);
    setState(ViewState.Idle); 

  }
 
 String lastError;
  Future<void> addNewShippment(AddShipment newShipment) async {
    if (newShipment != null) {
      setState(ViewState.Busy);
      QueryResult queryResult = await _fetchData.getClient().mutate(
            MutationOptions(
              documentNode: gql(createNewShipment),
              variables: {
                "field": {
                  "data": {
                    "shipment_weight": newShipment.createShippment.shippment.shipmentWeight,
                    "packing_service": newShipment.createShippment.shippment.packingService,
                    "loading_service": newShipment.createShippment.shippment.loadingService,
                    "pickup_location": newShipment.createShippment.shippment.pickupLocation,
                    "drop_off_location":newShipment.createShippment.shippment.dropOffLocation ,
                    "shipper":newShipment.createShippment.shippment.shipper.user.id,
                  }
                }
              },
            ),
          );
      if (queryResult.hasException) {
        lastError = queryResult.exception.toString();
        print(lastError);
        setState(ViewState.Error);
      } else {
        setState(ViewState.Mutated);
      }
    }
  }


  

}