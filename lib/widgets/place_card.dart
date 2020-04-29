import 'package:flutter/material.dart';
import 'package:serendipity/models/models.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({
    Key key,
    @required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Image.network(
              place.photoReferences.isEmpty
                  ? place.icon
                  : place.photoReferences[0].getRequestUrlForHeight(150),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ListTile(
                title: Text(place.name),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 5),
                    Text('${place.rating} / 5'),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Open in Maps'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
