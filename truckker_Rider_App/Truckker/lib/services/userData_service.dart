import 'dart:convert';

import 'package:Truckker/locator.dart';
import 'package:Truckker/objects/Shipment.dart';
import 'package:Truckker/services/auth_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserData {
  static Auth _authService = locator<Auth>();
  static String jwt = _authService.userInfo.jwt;

  static final HttpLink httpLink = HttpLink(
    uri: 'http://192.168.0.2:1337/graphql',
    //auth link, get token ,
  );

  static final AuthLink authLink = AuthLink(
    getToken: () => 'Bearer $jwt',
  );

  final Link link = authLink.concat(httpLink);

  GraphQLClient _client;

  GraphQLClient getClient() {
    _client = GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    );
    return _client;
  }

  void addShipment() {
    /*
    shipment weight,
    delivery date,
    shipment picture,
    packing service,
    loading service,
    pickup  location,
    dropoff location,
    shiper,
    Driver,
    payment,

    As we need Driver and payment so, we will post this request at the completion of ride,

    shipment weight, shipment date, packing, loading , we can get these values from homepage      
    then pickup location and dropoff location can be get from next page,
    */
  }

  Future<Shipment> getShipment(String userId) async {
    print('In method');
    QueryResult result = await getClient().query(_queryOptionsCountry(userId));
    print(result.exception);

    return Shipment.fromJson(result.data);
  }

  QueryOptions _queryOptionsCountry(String userId) {
    print('In query');
    return QueryOptions(
      documentNode: gql(r"""
       query userShipments ($shiperId : ID!) {
          shipper(id: $shiperId){
            shippments{
              delievry_date
              payment{
                cost_of_delivery
              }
            }
          }
}
      """),
      variables: <String, String>{
        'shiperId': userId,
      },
    );
  }
}
