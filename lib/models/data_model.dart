class DataModel {
  var id;
  var original_language;
  var original_title;
  var overview;
  var poster_path;
  var title;
  var release_date;
  var vote_average;
  var vote_count;
  var popularity;

  DataModel(
      {this.id,
        this.original_language,
        this.original_title,
        this.overview,
        this.poster_path,
        this.title,
        this.vote_average,
        this.vote_count,
        this.release_date,
        this.popularity});

}