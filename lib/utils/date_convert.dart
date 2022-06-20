DateTime stringToDate(String dateString) {
  final dateArray = dateString.split('/');
  return DateTime.parse('${dateArray[2]}-${dateArray[1]}-${dateArray[0]}');
}
