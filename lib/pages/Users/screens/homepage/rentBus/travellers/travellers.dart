import 'package:flutter/material.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/pages/Users/screens/homepage/rentBus/travellers/travellersWidget/travellersWidget.dart';
class TravellersForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return travellersWidget(context: context, 
    onContinue: ()=>navigation(context: context, pageName: "itenary")
      
    );
  }
}

