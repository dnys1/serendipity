import 'package:flutter/material.dart';
import 'package:serendipity/models/models.dart';

class Post extends StatelessWidget {
  /// Whether or not the user owns this post.
  final bool userOwns;

  /// The place represented by this post.
  final Place place;

  const Post({
    @required this.place,
    this.userOwns = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              place.photoReferences[0].getRequestUrlForWidth(
                  MediaQuery.of(context).size.width.toInt()),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('An Activity was recently completed at:'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(place.name, style: Theme.of(context).textTheme.subtitle2),
          ),
        ],
      ),
    );
  }
}
