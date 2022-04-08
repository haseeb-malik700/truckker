import 'package:Truckker/models/base_model.dart';

class HomePageModel extends BaseModel {

  String luggageType;
  int labours;
  int estimatedCost;

  void setLuggeageType(String luggage){
    luggageType=luggage;
  }
  
  void setLabours(String noOfLabours){
    labours = int.parse(noOfLabours);
  }

   int laboursCost() {
     return labours*500;
   }

   int getInitialRate(){
    int initialAmount;
    if(luggageType == 'Multiple Items'){
      initialAmount = 1000+laboursCost();
    }
    if(luggageType == 'Single Item'){
      initialAmount = 500+laboursCost();
    }
    if(luggageType == 'Complete House'){
      initialAmount = 2000+laboursCost();
    }
    estimatedCost = initialAmount;
    return initialAmount;
  }

}