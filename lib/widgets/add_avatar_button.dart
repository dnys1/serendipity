import 'package:flutter/material.dart';

import '../data/avatars.dart';

/// A plus (+) button which shows a [BottomSheet] for selecting
/// an avatar. The widget takes a callback to call when an
/// avatar is selected.
class AddAvatarButton extends StatelessWidget {
  /// A callback for when a certain avatar is selected.
  /// 
  /// (int) index: The index of the avatar.
  final void Function(int) onSelect;

  const AddAvatarButton({
    this.onSelect
  });

  Future<void> _showAvatarModal(BuildContext context) async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (_) {
        return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(10.0),
                children:
                    List.generate(Avatars.avatars.length, (index) => index)
                        .map((int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(index),
                      child: Avatars.circleAvatarForRadius(
                          index, kLargeAvatarSize),
                    ),
                  );
                }).toList(),
              );
            });
      },
    );

    if (result != null && onSelect != null) {
      onSelect(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAvatarModal(context),
      child: CircleAvatar(
        radius: kLargeAvatarSize,
        backgroundColor: Colors.grey,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
