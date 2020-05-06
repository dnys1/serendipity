import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serendipity/models/models.dart';
import 'package:serendipity/widgets/widgets.dart';

import 'feed_screen_model.dart';

/// The main screen for displaying the scrollable feed.
class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  FeedScreenModel _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _model = Provider.of<FeedScreenModel>(context);
  }

  Future<void> _clearPendingPost() async {
    if (_model.pendingPost != null) {
      return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Oh no!'),
          content: Text(
              'You already have a pending activity. Complete that before starting another!'),
        ),
      );
    }
    PostModel pendingPost = await Navigator.of(context).pushNamed('/add');
    if (pendingPost != null) {
      _model.setPendingPost(pendingPost);
    }
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
        future: _model.loadFeed(),
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.hasData) {
            child = ListView(
              addAutomaticKeepAlives: true,
              children: [
                if (_model.pendingPost != null)
                  PendingPost(
                    place: _model.pendingPost.place,
                    onComplete: _model.completePendingPost,
                  )
              ]..addAll(_model.feed.map((post) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Post(post),
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
