import 'package:flutter/material.dart';

import '../models/models.dart';

/// A user's activity which has not been completed.
class PendingPost extends StatelessWidget {
  /// The place the activity is taking place.
  final Place place;

  /// A callback for when the checkmark is pressed.
  final VoidCallback onComplete;

  const PendingPost({
    @required this.place,
    @required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          place.photoReferences.isNotEmpty
              ? place.photoReferences[0].getRequestUrlForWidth(50)
              : place.icon,
        ),
      ),
      title: Text('Pending Activity'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Mark complete', style: Theme.of(context).textTheme.caption),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: onComplete,
          ),
        ],
      ),
    );
  }
}
