const String createNewShipment = r''' mutation CreateShippment($feild: createShippmentInput){
  createShippment(input: $feild){
    shippment{
      shipment_weight
      packing_service
      loading_service
      pickup_location{
        latitude
        longitude
      }
      delievry_date
      drop_off_location{
        latitude
        longitude
      }
      shipper{
        user{
          id
        }
      }
    }
  }
}''';