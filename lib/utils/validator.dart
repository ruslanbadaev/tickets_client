class Validator {
  static String? groupError(String text) {
    String? errorText;
    if (text.isNotEmpty) {
      if (text.contains('-')) {
      } else {
        errorText = 'ID_MUST_START_WITH_MINUS_SIGN';
      }
      if (text.split('-').length > 2) {
        errorText = 'INVALID_FORMAT ${text.split('-').length}';
      }
      if (text.indexOf('-') != 0) {
        errorText = 'INVALID_FORMAT';
      }
    }
    return errorText;
  }
}
