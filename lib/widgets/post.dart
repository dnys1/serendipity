import 'package:flutter/material.dart';
import 'package:serendipity/models/models.dart';

const double _kStarHeight = 40.0;
const double _kStarPadding = 4.0;

class Post extends StatefulWidget {
  /// Whether or not the user owns this post.
  final bool userOwns;

  /// The place represented by this post.
  final Place place;

  const Post({
    @required this.place,
    this.userOwns = false,
  });

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  int _userRating;

  Widget _buildStarRating() {
    return Column(
      children: <Widget>[
        Text('How was your experience?'),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
            padding: const EdgeInsets.only(top: 8.0),
            child: widget.userOwns
                ? Text('You recently completed an activity at:')
                : Text('An Activity was recently completed at:'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.place.name,
                    style: Theme.of(context).textTheme.subtitle2),
                SizedBox(width: 5),
                Icon(Icons.star, color: Colors.amber, size: 14),
                SizedBox(width: 5),
                Text('${widget.place.rating} / 5'),
              ],
            ),
          ),
          if (widget.userOwns)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _userRating == null
                  ? _buildStarRating()
                  : Text('Thanks for submitting your review!'),
            ),
        ],
      ),
    );
  }
}
