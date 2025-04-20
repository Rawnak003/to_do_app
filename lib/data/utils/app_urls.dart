class AppURLs{
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";
  static const String registerURL = "$_baseUrl/Registration";
  static const String loginURL = "$_baseUrl/Login";
  static const String profileUpdateURL = "$_baseUrl/ProfileUpdate";
  static const String addNewTaskURL = "$_baseUrl/createTask";
  static const String taskStatusCountURL = "$_baseUrl/taskStatusCount";
  static String taskListURL(String status) => "$_baseUrl/listTaskByStatus/$status";
  static String updateTaskStatusURL(String id, String status) => "$_baseUrl/updateTaskStatus/$id/$status";
  static String deleteTaskUrl(String taskId) => '$_baseUrl/deleteTask/$taskId';

  static String verifyEmailURL(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String verifyPinURL(String email, String pin) => '$_baseUrl/RecoverVerifyOtp/$email/$pin';
  static const String resetPasswordURL = "$_baseUrl/RecoverResetPassword";
}

