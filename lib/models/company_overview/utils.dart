class StringToIntConverter {
  const StringToIntConverter();

  static int? fromJson(String json) => int.parse(json);

  static String toJson(int? object) => object == null ? '' : '$object';
}

class StringToDobuleConverter {
  const StringToDobuleConverter();

  static double? fromJson(String json) => double.parse(json);

  static String toJson(double? object) => object == null ? '' : '$object';
}
