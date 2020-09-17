import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/product_page.dart';
import 'package:ecommerce/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: productCollection.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                //dispaly collection data
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    padding: EdgeInsets.only(top: 100, bottom: 12),
                    children: snapshot.data.docs.map((document) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        height: 350,
                        margin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                          productId: document.id,
                                        )));
                          },
                          child: Stack(children: [
                            Container(
                              height: 350,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "${document.data()['images'][0]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      document.data()['Name'] ?? 'Product Name',
                                      style: Constants.regularHeading,
                                    ),
                                    Text(
                                      'K' +
                                              document
                                                  .data()['Price']
                                                  .toString() ??
                                          'Price',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                      );
                    }).toList(),
                  );
                }

                //loading state
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          ActionBar(title: 'Home')
        ],
      ),
    );
  }
}
