import 'package:flutter/material.dart';
import 'package:serendipity/api/places.dart';
import 'package:serendipity/models/models.dart';
import 'package:serendipity/widgets/widgets.dart';

class DetailScreen extends StatefulWidget {
  final Post post;

  const DetailScreen(this.post);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isEditing = false;

  /// The bottom scrolling avatar bar
  Widget get _avatarBar => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            AvatarBar(
              avatarIndices: widget.post.peoplePresent,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              radius: 30,
            ),
            SizedBox(width: 5),
            if (_isEditing)
              AddAvatarButton(
                onSelect: (int selected) {
                  setState(() {
                    widget.post.peoplePresent.add(selected);
                  });
                },
              ),
          ],
        ),
      );

  /// The activity details below the images
  Widget get _activityDetails => Expanded(
        child: Column(
          children: <Widget>[
            Text(widget.post.place.name,
                style: Theme.of(context).textTheme.headline5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 5),
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 5),
                Text('${widget.post.place.rating} / 5'),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur blandit neque nunc. Vivamus efficitur odio vitae scelerisque auctor. Duis interdum eros scelerisque erat congue, id lacinia lectus auctor. Nulla et nunc risus. Suspendisse auctor purus dui, nec dapibus ligula consectetur quis. Vivamus id nisi id nunc dignissim malesuada. Quisque odio lectus, fermentum sed dolor eget, tristique ultrices libero. Donec lectus odio, maximus ut neque vitae, maximus egestas lorem. Phasellus bibendum consectetur augue, quis dictum purus viverra mollis.',
                overflow: TextOverflow.fade,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Who was there?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 15),
                  _avatarBar,
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.dateTime.toString().split(' ')[0]),
        actions: widget.post.userOwns
            ? <Widget>[
                IconButton(
                  icon: Icon(_isEditing ? Icons.check : Icons.edit),
                  onPressed: () => setState(() => _isEditing = !_isEditing),
                )
              ]
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder<List<PlacesPhoto>>(
              future: PlacesAPI().getAllPhotosForPlace(widget.post.place),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: PageView(
                          children: snapshot.data.map((PlacesPhoto photo) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                    photo.getRequestUrlForHeight(300)));
                          }).toList(),
                        ),
                      ),
                      _activityDetails,
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Error loading details. Please try again.'),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
