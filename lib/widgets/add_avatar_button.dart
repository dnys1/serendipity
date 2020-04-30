import 'package:flutter/material.dart';
import 'package:serendipity/data/avatars.dart';

class AddAvatarButton extends StatelessWidget {
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
