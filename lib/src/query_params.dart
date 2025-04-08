/// Helper class to construct uri for the ImageTransformation class
class URLQueryParams {
  final Map<String, String> _values = {};

  // Appends a parameter to the query with received key.
  void append(String key, dynamic value) {
    if (value != null && value.toString().isNotEmpty) {
      final sanitizedValue = _sanitizeInput(value.toString());
      _values[key] = Uri.encodeQueryComponent(sanitizedValue);
    }
  }

  // Removes a parameter from query by key.
  void remove(String key) {
    _values.remove(key);
  }

  // Convert to query string like the next example:
  // * param1=value1&param2=value2
  @override
  String toString() {
    return _values.entries
        .map((entry) => '${Uri.encodeQueryComponent(entry.key)}=${entry.value}')
        .join('&');
  }

  String toUrl(String url) {
    if (url.isEmpty) throw ArgumentError('URL cannot be empty');

    final Uri parsedUri = Uri.parse(url);
    final String normalizedUrl = parsedUri.normalizePath().toString();

    return Uri.parse('$normalizedUrl?${toString()}').toString();
  }

  String _sanitizeInput(String input) {
    final pattern = RegExp(r'[<>\"\;(){}]');
    return input.replaceAll(pattern, '');
  }
}
