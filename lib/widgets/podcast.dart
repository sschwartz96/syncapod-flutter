import 'package:flutter/material.dart';

import 'package:syncapod/models/podcast.dart';

class PodcastTile extends StatelessWidget {
  final Podcast _podcast;

  const PodcastTile(
    this._podcast,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      height: 100,
      child: Row(
        children: <Widget>[
          Image.network(
            _podcast.image.url,
            width: 100,
            height: 100,
            loadingBuilder: (context, child, p) {
              return p == null
                  ? child
                  : Container(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: p.cumulativeBytesLoaded / p.expectedTotalBytes,
                      ),
                    );
            },
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _podcast.title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    _podcast.subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
