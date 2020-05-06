import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';

/// A widget containing information from a completed activity,
/// represented as a [Card] widget with [Place] and [DateTime]
/// information. This widget is often passed around for the [Place]
/// in lieu of maintaining a separate class for [Post] data.
class Post extends StatelessWidget {
  final PostModel post;

  const Post(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/detail', arguments: post),
      child: Card(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                post.place.photoReferences[0].getRequestUrlForWidth(
                    MediaQuery.of(context).size.width.toInt()),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AvatarBar(avatarIndices: post.peoplePresent),
                  Text(
                    post.dateTime.toString().split(' ')[0],
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: post.userOwns
                  ? Text('You recently completed an activity at:')
                  : Text('An Activity was recently completed at:'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                post.place.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star, color: Colors.amber, size: 14),
                  SizedBox(width: 5),
                  Text('${post.place.rating} / 5'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
