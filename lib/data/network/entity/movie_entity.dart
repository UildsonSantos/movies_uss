class UpcomingMovies {
  List<MovieEntity> results;

  UpcomingMovies({
    required this.results,
  });
}

class MovieEntity {
  String id;
  String resultId;
  PrimaryImage? primaryImage;
  TitleText titleText;
  TitleText originalTitleText;
  ReleaseYear releaseYear;
  ReleaseDate releaseDate;

  MovieEntity({
    required this.id,
    required this.resultId,
    required this.primaryImage,
    required this.titleText,
    required this.originalTitleText,
    required this.releaseYear,
    required this.releaseDate,
  });
}

class TitleText {
  String text;

  TitleText({
    required this.text,
  });
}

class PrimaryImage {
  String id;
  int width;
  int height;
  String url;
  Caption caption;

  PrimaryImage({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.caption,
  });
}

class Caption {
  String plainText;

  Caption({
    required this.plainText,
  });
}

class ReleaseDate {
  int day;
  int month;
  int year;

  ReleaseDate({
    required this.day,
    required this.month,
    required this.year,
  });
}

class ReleaseYear {
  int year;
  dynamic endYear;

  ReleaseYear({
    required this.year,
    required this.endYear,
  });
}

class TitleType {
  String text;
  String id;
  bool isSeries;
  bool isEpisode;
  List<Category>? categories;
  bool? canHaveEpisodes;

  TitleType({
    required this.text,
    required this.id,
    required this.isSeries,
    required this.isEpisode,
    this.categories,
    this.canHaveEpisodes,
  });
}

class Category {
  String value;

  Category({
    required this.value,
  });
}
