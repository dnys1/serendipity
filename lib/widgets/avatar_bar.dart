import 'package:flutter/material.dart';

import '../data/avatars.dart';

/// A row of avatars, representing the users associated
/// with a specific [Post], or completed activity.
class AvatarBar extends StatelessWidget {
  /// An ordered list of the users, represented by the avatar's index
  /// in [Avatars].avatars
  final List<int> avatarIndices;

  /// Padding between and around each [CircleAvatar] widget.
  final EdgeInsets padding;

  /// The radius of each [CircleAvatar] widget.
  final double radius;

  const AvatarBar({
    @required this.avatarIndices,
    this.padding = const EdgeInsets.symmetric(horizontal: 2),
    this.radius = kSmallAvatarSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: avatarIndices
          .map((idx) => Padding(
                padding: padding,
                child: Avatars.circleAvatarForRadius(idx, radius),
              ))
          .toList(),
    );
  }
}
