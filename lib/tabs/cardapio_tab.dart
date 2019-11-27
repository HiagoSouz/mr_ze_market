import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mr_ze_market/tile/category_file.dart';


class CardapioTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("products").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            GridView.count(
              crossAxisCount: 2,
              children: List.generate(20, (index) {
                return Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headline,
                  ),
                );
              }),
            );
            var dividedTiles = ListTile.divideTiles(
                context: context,
                tiles: snapshot.data.documents.map((doc) {
                  return CategoryTile(doc);
                }).toList(),
                color: Colors.grey)
                .toList();



            return ListView(
              children: dividedTiles,
            );
          }
        });
  }
}


/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trembaoapp/tiles/category_file.dart';

class CardapioTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("products").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            GridView.count(
              crossAxisCount: 2,
              children: List.generate(20, (index) {
                return Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headline,
                  ),
                );
              }),
            );
            var dividedTiles = ListTile.divideTiles(
                    context: context,
                    tiles: snapshot.data.documents.map((doc) {
                      return CategoryTile(doc);
                    }).toList(),
                    color: Colors.grey)
                .toList();

            return ListView(
              children: dividedTiles,
            );
          }
        });
  }
}

 */