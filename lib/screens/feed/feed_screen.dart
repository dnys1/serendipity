import 'package:flutter/material.dart';
import 'package:serendipity/api/places.dart';
import 'package:serendipity/models/models.dart';
import 'package:serendipity/screens/add/add_screen.dart';
import 'package:serendipity/widgets/widgets.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Widget> _feed = [];
  PendingPost _pendingPost;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _getRandomFeed() async {
    while (_feed.length < 50) {
      // Generate a clickable post for a bunch of random places.
      _feed.addAll((await PlacesAPI()
              .getRandomPlace(mood: Mood.Any, finType: FinType.Any))
          .where((Place place) => place.photoReferences.isNotEmpty)
          .map((Place place) => Post(place: place)));
      _feed.shuffle();
    }

    // Must return something to trigger `snapshot.data` in FutureBuilder
    return true;
  }

  Future<void> _clearPendingPost() async {
    if (_pendingPost != null) {
      return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Oh no!'),
          content: Text(
              'You already have a pending activity. Complete that before starting another!'),
        ),
      );
    }
    Post pendingPost = await Navigator.of(context).push(MaterialPageRoute<Post>(
      builder: (_) => AddScreen(),
    ));
    if (pendingPost == null) {
      return;
    }
    setState(() {
      _pendingPost = PendingPost(
        place: pendingPost.place,
        onCleared: () => setState(() {
          _feed.insert(0, pendingPost);
          _pendingPost = null;
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _clearPendingPost,
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getRandomFeed(),
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.hasData) {
            child = ListView(
              addAutomaticKeepAlives: true,
              children:
                  (_pendingPost == null ? <Widget>[] : <Widget>[_pendingPost])
                    ..addAll(_feed.map((post) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: post,
                        ))),
            );
          } else if (snapshot.hasError) {
            child = Text(snapshot.error);
          } else {
            child = CircularProgressIndicator();
          }

          return Center(
            child: child,
          );
        },
      ),
    );
  }
}
