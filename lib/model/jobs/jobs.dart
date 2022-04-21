class Jobs {
  late String _title;
  late String _image;
  late String _time;
  late String _description;

  String get title => _title;
  String get image => _image;
  String get time => _time;
  String get description => _description;

  Jobs(
      {required String title,
      required String image,
      required String time,
      required String description}) {
    _title = title;
    _image = image;
    _time = time;
    _description = description;
  }
}
