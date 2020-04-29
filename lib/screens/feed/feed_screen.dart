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
  List<Place> _feed = [];
  PendingPost _pendingPost;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getRandomFeed() async {
    while (_feed.length < 50) {
      _feed.addAll(await PlacesAPI()
          .getRandomPlace(mood: Mood.Any, finType: FinType.Any));
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
            onPressed: () {},
          ),
        ],
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       FlatButton(
      //         onPressed: () => BlocProvider.of<PlacesBloc>(context).add(
      //             PlacesRequested(mood: Mood.Chill, finType: FinType.Paid)),
      //         child: Text('Press Me'),
      //       ),
      //       BlocBuilder<PlacesBloc, PlacesState>(builder: (context, state) {
      //         if (state is PlacesInitial) {
      //           return Text('Press the button to begin.');
      //         } else if (state is PlacesRequestInProgress) {
      //           return CircularProgressIndicator();
      //         } else if (state is PlacesSuccess) {
      //           return PlaceCard(place: state.place);
      //         } else {
      //           // PlacesFailure
      //           return Text((state as PlacesFailure).message);
      //         }
      //       }),
      //     ],
      //   ),
      // ),
      body: FutureBuilder(
          future: getRandomFeed(),
          builder: (context, snapshot) {
            Widget child;
            if (snapshot.hasData) {
              child = ListView(
                children:
                    (_pendingPost == null ? <Widget>[] : <Widget>[_pendingPost])
                      ..addAll(_feed.map((Place place) => Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Post(place: place),
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
          }),
    );
  }
}
