import 'package:flutter/material.dart';
import 'package:serendipity/models/models.dart';

class PendingPost extends StatelessWidget {
  final Place place;
  final VoidCallback onCleared;

  const PendingPost({
    @required this.place,
    @required this.onCleared,
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
            onPressed: onCleared,
          ),
        ],
      ),
    );
  }
}
