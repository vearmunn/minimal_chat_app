String getExactTime(DateTime date) {
  return '${date.hour < 10 ? '0${date.hour}' : date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute}';
}
