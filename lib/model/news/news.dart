class News {
  late String _title;
  late String _image;
  late String _source;
  late String _sourceImage;
  late String _time;
  late String _description;

  String get title => _title;
  String get image => _image;
  String get source => _source;
  String get sourceImage => _sourceImage;
  String get time => _time;
  String get description => _description;

  News(
      {required String title,
      required String image,
      required String source,
      required String sourceImage,
      required String time,
      required String description}) {
    _title = title;
    _image = image;
    _source = source;
    _sourceImage = sourceImage;
    _time = time;
    _description = description;
  }
}
