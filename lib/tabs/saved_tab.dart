import 'package:ecommerce/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          
          ActionBar(title: 'Saved Products')
        ],
      ),
    );
  }
}
