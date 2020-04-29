import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serendipity/api/places.dart';
import 'package:serendipity/blocs/places/places_bloc.dart';
import 'package:serendipity/models/models.dart';
import 'package:serendipity/widgets/widgets.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Post> _feed = [];
  PendingPost _pendingPost;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getRandomFeed() async {
    while (_feed.length < 50) {
      _feed.addAll((await PlacesAPI()
              .getRandomPlace(mood: Mood.Any, finType: FinType.Any))
          .where((Place place) => place.photoReferences.isNotEmpty)
          .map((Place place) => Post(place: place)));
      _feed.shuffle();
    }

    // Must return something to trigger `snapshot.data` in FutureBuilder
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
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
              var pendingPlace = await Navigator.of(context).pushNamed('/add');
              if (pendingPlace == null) {
                return;
              }
              setState(() {
                _pendingPost = PendingPost(
                  place: pendingPlace,
                  onCleared: () => setState(() {
                    _feed.insert(
                        0,
                        Post(
                          userOwns: true,
                          place: pendingPlace,
                        ));
                    _pendingPost = null;
                  }),
                );
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getRandomFeed(),
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
