import 'dart:math';

import 'package:flutter/material.dart';
import 'package:serendipity/data/avatars.dart';
import 'package:serendipity/models/models.dart';
import 'package:serendipity/screens/detail/detail_screen.dart';
import 'package:serendipity/widgets/widgets.dart';

const double _kStarHeight = 40.0;
const double _kStarPadding = 4.0;

/// A widget containing information from a completed activity,
/// represented as a [Card] widget with [Place] and [DateTime]
/// information. This widget is often passed around for the [Place]
/// in lieu of maintaining a separate class for [Post] data.
class Post extends StatefulWidget {
  /// Whether or not the user owns this post.
  final bool userOwns;

  /// The place represented by this post.
  final Place place;

  /// The date and time this post was made.
  final DateTime dateTime;

  /// A list of people present.
  /// The avatar index for this demo.
  final List<int> peoplePresent;

  Post({
    @required this.place,
    this.userOwns = false,
    DateTime dateTime,
    List<int> peoplePresent,
  })  : assert(place != null, 'Place cannot be null.'),
        this.dateTime = dateTime ?? _randomDate,
        this.peoplePresent = peoplePresent ?? _randomPeoplePresent;

  @override
  _PostState createState() => _PostState();

  /// Picks a random date from 2019
  static DateTime get _randomDate =>
      DateTime(2019, Random().nextInt(12) + 1, Random().nextInt(30) + 1);

  /// Picks at most 5 random avatars
  static List<int> get _randomPeoplePresent => List.generate(
      Random().nextInt(4) + 1,
      (index) => Random().nextInt(Avatars.avatars.length));
}

class _PostState extends State<Post> with AutomaticKeepAliveClientMixin {
  /// The user's rating, if they own the post
  int _userRating;

  /// Add keep alive to maintain state (namely `_userRating`), when in a ListView.
  @override
  bool get wantKeepAlive => true;

  Widget _buildStarRating() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _userRating == null
              ? Text('How was your experience?')
              : Text('Thanks for submitting your review!'),
          SizedBox(
            height: _kStarHeight + 2 * _kStarPadding,
            width: _kStarHeight * 5,
            child: ListView.builder(
              itemExtent: _kStarHeight,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: _userRating == null || _userRating == 0
                      ? () => setState(() => _userRating = index + 1)
                      : null,
                  child: Image.asset(
                    _userRating == null || index + 1 > _userRating
                        ? 'assets/star_empty.png'
                        : 'assets/star_full.png',
                    width: _kStarHeight,
                    height: _kStarHeight,
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => DetailScreen(widget))),
      child: Card(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                widget.place.photoReferences[0].getRequestUrlForWidth(
                    MediaQuery.of(context).size.width.toInt()),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AvatarBar(avatarIndices: widget.peoplePresent),
                  Text(
                    widget.dateTime.toString().split(' ')[0],
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: widget.userOwns
                  ? Text('You recently completed an activity at:')
                  : Text('An Activity was recently completed at:'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                widget.place.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star, color: Colors.amber, size: 14),
                  SizedBox(width: 5),
                  Text('${widget.place.rating} / 5'),
                ],
              ),
            ),
            if (widget.userOwns) _buildStarRating(),
          ],
        ),
      ),
    );
  }
}
