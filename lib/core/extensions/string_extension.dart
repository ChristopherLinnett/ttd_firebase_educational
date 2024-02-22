extension StringExtension on String {
  String get obscureEmail {
    //Split into username and domain
    final index = indexOf('@');
    var username = substring(0, index);
    final domain = substring(index + 1);

    username =
        '${username[0]}${'*' * (username.length - 2)}${username[username.length - 1]}';
    return '$username@$domain';
  }
}
