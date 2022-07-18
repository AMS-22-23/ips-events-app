import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:core_components/core_components.dart';

class EventsSnackBars {
  static void _showSnackbar({
    required BuildContext context,
    required String message,
    required String title,
    required ContentType contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorSnackbar({
    required BuildContext context,
    required String message,
  }) {
    _showSnackbar(
      context: context,
      message: message,
      title: t(LocaleKeys.errorOcurred),
      contentType: ContentType.failure,
    );
  }

  static void showSuccessSnackbar({
    required BuildContext context,
    required String message,
  }) {
    _showSnackbar(
      context: context,
      message: message,
      title: t(LocaleKeys.success),
      contentType: ContentType.success,
    );
  }
}
