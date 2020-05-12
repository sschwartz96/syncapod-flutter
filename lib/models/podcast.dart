import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:syncapod/providers/podcast.dart';

class Podcast {
  final String id;
  final String title;
  final String type;
  final String author;
  final String subtitle;
  final String link;
  final PodImage image;
  final String explicit;
  final String locale;
  final List<String> keywords;
  final DateTime pubDate;
  final DateTime lastBuildDate;
  final String rssURL;
  final List<PodCategory> category;

  Podcast({
    this.id,
    this.title,
    this.type,
    this.author,
    this.subtitle,
    this.link,
    this.image,
    this.explicit,
    this.locale,
    this.keywords,
    this.pubDate,
    this.lastBuildDate,
    this.rssURL,
    this.category,
  });

  static Podcast fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Podcast(
      id: map['_id'],
      title: map['title'],
      type: map['type'],
      author: map['author'],
      subtitle: map['subtitle'],
      link: map['link'],
      image: PodImage.fromMap(map['image']),
      explicit: map['explicit'],
      locale: map['locale'],
      keywords: List<String>.from(map['keywords']),
      pubDate: DateTime.parse(map['pub_date']),
      lastBuildDate: DateTime.parse(map['last_build_date']),
      rssURL: map['rss'],
      category: List<PodCategory>.from(
          map['category']?.map((x) => PodCategory.fromMap(x))),
    );
  }

  static Podcast fromJson(String source) => fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'type': type,
      'author': author,
      'subtitle': subtitle,
      'link': link,
      'image': image?.toMap(),
      'explicit': explicit,
      'locale': locale,
      'keywords': keywords,
      'pubDate': pubDate?.toIso8601String(),
      'lastBuildDate': lastBuildDate?.toIso8601String(),
      'rssURL': rssURL,
      'category': category?.map((x) => x?.toMap())?.toList(),
    };
  }

  String toJson() => json.encode(toMap());
}

class Episode {
  final String id;
  final String podcastID;
  final String title;
  final String subtitle;
  final String author;
  final String type;
  final PodImage image;
  final DateTime pubDate;
  final String description;
  final String summary;
  final int season;
  final int episode;
  final List<PodCategory> category;
  final String explicit;
  final String mp3URL;
  final int durationMillis;
  Episode({
    this.id,
    this.podcastID,
    this.title,
    this.subtitle,
    this.author,
    this.type,
    this.image,
    this.pubDate,
    this.description,
    this.summary,
    this.season,
    this.episode,
    this.category,
    this.explicit,
    this.mp3URL,
    this.durationMillis,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'podcastID': podcastID,
      'title': title,
      'subtitle': subtitle,
      'author': author,
      'type': type,
      'image': image?.toMap(),
      'pubDate': pubDate?.toIso8601String(),
      'description': description,
      'summary': summary,
      'season': season,
      'episode': episode,
      'category': category?.map((x) => x?.toMap())?.toList(),
      'explicit': explicit,
      'mp3URL': mp3URL,
      'durationMillis': durationMillis,
    };
  }

  String getDescription() {
    return description.replaceAll(RegExp('<img .*?>'), '');
    //       .replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  static Episode fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Episode(
      id: map['_id'],
      podcastID: map['podcast_id'],
      title: map['title'],
      subtitle: map['subtitle'],
      author: map['author'],
      type: map['type'],
      image: PodImage.fromMap(map['image']),
      pubDate: DateTime.parse(map['pub_date']),
      description: map['description'],
      summary: map['summary'],
      season: map['season'],
      episode: map['episode'],
      category: map['category'] == null
          ? null
          : List<PodCategory>.from(
              map['category']?.map((x) => PodCategory.fromMap(x))),
      explicit: map['explicit'],
      mp3URL: map['mp3_url'],
      durationMillis: map['duration_millis'],
    );
  }

  String toJson() => json.encode(toMap());

  static Episode fromJson(String source) => fromMap(json.decode(source));

  MediaItem toMediaItem() {
    return MediaItem(
      title: this.title,
      id: this.mp3URL,
      artUri: this.image.url,
      artist: this.author,
      displaySubtitle: this.subtitle,
      displayTitle: this.title,
      duration: this.durationMillis,
      playable: true,
      album: this.title,
      extras: {"epi_id": this.id, "pod_id": this.podcastID},
    );
  }
}

class PodCategory {
  final List<PodCategory> category;
  final String text;
  PodCategory({this.category, this.text});

  Map<String, dynamic> toMap() {
    return {
      'category': category?.map((x) => x?.toMap())?.toList(),
      'text': text,
    };
  }

  static PodCategory fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PodCategory(
      category: map['category'] == null
          ? null
          : List<PodCategory>.from(
              map['category']?.map((x) => PodCategory.fromMap(x))),
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  static PodCategory fromJson(String source) => fromMap(json.decode(source));
}

class PodImage {
  final String title;
  final String url;

  PodImage({this.title, this.url});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
    };
  }

  static PodImage fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PodImage(
      title: map['title'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  static PodImage fromJson(String source) => fromMap(json.decode(source));
}
