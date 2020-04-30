import 'package:flutter/material.dart';

const kLargeAvatarSize = 30.0;
const kSmallAvatarSize = 10.0;

/// Mock users, represented as avatars.
class Avatars {
  static const List<AssetImage> avatars = [
    AssetImage('assets/avatars/avatar1.png'),
    AssetImage('assets/avatars/avatar2.png'),
    AssetImage('assets/avatars/avatar3.png'),
    AssetImage('assets/avatars/avatar4.png'),
    AssetImage('assets/avatars/avatar5.png'),
    AssetImage('assets/avatars/avatar6.png'),
    AssetImage('assets/avatars/avatar7.png'),
    AssetImage('assets/avatars/avatar8.png'),
    AssetImage('assets/avatars/avatar9.png'),
  ];

  static CircleAvatar circleAvatarForRadius(int index, double radius) =>
      CircleAvatar(
        radius: radius,
        backgroundImage: avatars[index],
      );
}
