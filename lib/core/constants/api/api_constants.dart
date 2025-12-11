class ApiConstants {
  ApiConstants._();

  static const Map<String, String> headerType = {
    'Content-Type': 'application/json',
  };
  static const String baseUrl =
      'http://10.0.2.2:8080/api/v1'; // for Android emulator
  // For iOS simulator, use http://localhost:8080/api/v1

  // Auth
  static const String loginUrl = "$baseUrl/auth/login";
  static const String registerUrl = "$baseUrl/auth/register";

  // Profile
  static const String profileUrl = "$baseUrl/user/profile";

  // Post
  static const String postUrl = "$baseUrl/post";
  static String getLikePostUrl(String postId) => "$postUrl/$postId/like";

  // Comment
  static String getCommentUrl(String postId) => "$postUrl/$postId/comment";
}
