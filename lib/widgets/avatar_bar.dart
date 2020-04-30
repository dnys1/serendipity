import 'package:flutter/material.dart';
import 'package:serendipity/data/avatars.dart';

class AvatarBar extends StatelessWidget {
  final List<int> avatarIndices;

  final EdgeInsets padding;

  final double radius;

  final void Function(int) onTap;

  const AvatarBar({
    @required this.avatarIndices,
    this.padding = const EdgeInsets.symmetric(horizontal: 2),
    this.radius = kSmallAvatarSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: avatarIndices
          .map((idx) => Padding(
                padding: padding,
                child: GestureDetector(
                  onTap: onTap == null ? null : () => onTap(idx),
                  child: Avatars.circleAvatarForRadius(idx, radius),
                ),
              ))
          .toList(),
    );
  }
}
