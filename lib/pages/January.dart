import 'package:flutter/material.dart';
import 'package:sidebar/bloc.navigation_bloc/navigation_bloc.dart';


class January extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context){
    return Center(
      
        child: Text("January", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),),  

      
    );
  }
}