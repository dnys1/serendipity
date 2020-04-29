import 'package:flutter/material.dart';

class PendingPost extends StatelessWidget {
  final VoidCallback onPressed;

  const PendingPost(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(),
      title: Text('Pending Activity'),
      trailing: IconButton(
        icon: Icon(Icons.check),
        onPressed: onPressed,
      ),
    );
  }
}