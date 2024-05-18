class Convertion {
  static String convertTime(int time) {
    // convert creation time to time ago from milliseconds
    DateTime now = DateTime.now();
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    Duration diff = now.difference(date);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} years ago";
    } else if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} months ago";
    } else if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} weeks ago";
    } else if (diff.inDays > 0) {
      return "${diff.inDays} days ago";
    } else if (diff.inHours > 0) {
      return "${diff.inHours} hours ago";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }
}
