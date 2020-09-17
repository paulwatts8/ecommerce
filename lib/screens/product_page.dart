import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/widgets/custom_action_bar.dart';
import 'package:ecommerce/widgets/image_swipe.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String productId;
  ProductPage({Key key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference productCollection =
        FirebaseFirestore.instance.collection('Products');
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: productCollection.doc(productId).get(),
            builder: (context, snapshot) {
              //checks for errors
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              //dispaly collection data
              if (snapshot.connectionState == ConnectionState.done) {
                //firebase map
                Map<String, dynamic> _docData = snapshot.data.data();

                //images list
                List listImages = _docData['images'];
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: ListView(
                    children: [
                      ImageSwiper(imageList: listImages,),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24, bottom: 4, left: 24, right: 24),
                        child: Text(
                          _docData['Name'].toString(),
                          style: Constants.boldHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 24),
                        child: Text(
                          'K ' + _docData['Price'].toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24),
                        child: Text(
                          _docData['Desc'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 24),
                        child: Text(
                          'Select Size',
                          style: Constants.regularHeading,
                        ),
                      ),
                    ],
                  ),
                );
              }

              //loading state
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          ActionBar(
            backArrow: true,
            hasTitle: false,
            hasBackground: false,
          ),
        ],
      ),
    );
  }
}
