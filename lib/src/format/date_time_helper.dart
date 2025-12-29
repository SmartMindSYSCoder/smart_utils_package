import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:logger/logger.dart';

mixin DateTimeHelper {
  // DateTimeHelpersMethods._();

  // static final DateTimeHelpersMethods _instance = DateTimeHelpersMethods._();
  //
  // static DateTimeHelpersMethods get instance => _instance;

  var logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          // number of method calls to be displayed
          errorMethodCount: 8,
          // number of method calls if stacktrace is provided
          lineLength: 120,
          // width of the output
          colors: true,
          // Colorful log messages
          printEmojis: false,
          // Print an emoji for each log message
          dateTimeFormat:
              DateTimeFormat.none // Should each log print contain a timestamp
          ));

  ///... format dateTime ..........................................

  static const String apiTimeOfDayFormat = 'hh:mm a';

  static DateTime parseTimeFromStringToDateTime(String matchTime) {
    DateTime dateTime =
        intl.DateFormat(apiTimeOfDayFormat, 'en').parse(matchTime);
    return dateTime;
  }

  static TimeOfDay? convertStringToTimeOfDay(String? time) {
    if (time != null) {
      return TimeOfDay.fromDateTime(parseTimeFromStringToDateTime(time));
    }
    return null;
  }

  static String showFormattedDate(DateTime date,
      {bool withTime = false,
      bool onlyTime = false,
      bool onlyDay = false,
      bool onlyYearAndMonth = false,
      bool onlyTimeWithAMPM = false,
      bool dateWithDayName = false,
      String? localeCod = 'en',
      String? separator = '-'}) {
    if (onlyTime) {
      return intl.DateFormat('hh:mm', localeCod ?? Get.locale!.languageCode)
          .format(date);
    }

    if (onlyTimeWithAMPM) {
      return intl.DateFormat('hh:mm a', localeCod ?? Get.locale!.languageCode)
          .format(date);
    }

    if (withTime) {
      return intl.DateFormat('hh:mm a  dd $separator MM $separator yyyy',
              localeCod ?? Get.locale!.languageCode)
          .format(date);
    }

    if (dateWithDayName) {
      return intl.DateFormat('EE $separator dd $separator MM $separator yyyy',
              localeCod ?? Get.locale!.languageCode)
          .format(date);
    }

    if (onlyDay) {
      return intl.DateFormat('dd', localeCod ?? Get.locale!.languageCode)
          .format(date);
    }

    if (onlyYearAndMonth) {
      return intl.DateFormat(
              'MMMM $separator yyyy', localeCod ?? Get.locale!.languageCode)
          .format(date);
    }
    //'d MMMM, yyyy \'at\' h:mma'

    return intl.DateFormat('yyyy${separator}MM${separator}dd',
            localeCod ?? Get.locale!.languageCode)
        .format(date);
  }

  String getDayOfTimeFromDateTimOrFromStringAsString(
      {DateTime? dateTime, String? timeAsString}) {
    TimeOfDay? timeOfDay;

    if (dateTime != null) {
      timeOfDay = TimeOfDay.fromDateTime(dateTime);
    }

    if (timeAsString != null) {
      DateTime dateTime = parseTimeFromStringToDateTime(timeAsString);
      timeOfDay = TimeOfDay.fromDateTime(dateTime);
      logger.d(timeOfDay.toString());
    }

    if (timeOfDay != null) {
      // DefaultMaterialLocalizations().formatTimeOfDay(timeOfDay);
      final localizations = MaterialLocalizations.of(Get.context!);
      final formattedTimeOfDay = localizations.formatTimeOfDay(timeOfDay);
      return formattedTimeOfDay;
    } else {
      return '00:00';
    }
  }

  static String getDayName(DateTime dateTime) {
    return intl.DateFormat.EEEE(Get.locale!.languageCode).format(dateTime);
  }

  // bool checkIfMatchHalfHasEnd(String endTime) {
  //   TimeOfDay current = TimeOfDay.fromDateTime(DateTime.now());
  //
  //   DateTime currentDateTime = intl.DateFormat(apiTimeOfDayFormat, 'en')
  //       .parse(DefaultMaterialLocalizations().formatTimeOfDay(current));
  //
  //   DateTime endMatchTime =
  //       intl.DateFormat(apiTimeOfDayFormat, 'en').parse(endTime);
  //
  //   return currentDateTime.isAfter(endMatchTime);
  // }
  ///...
  // String getTotalEstimateTime(String halfStartTime, String halfEndTime) {
  //   // logger.d('$halfStartTime    $halfEndTime');
  //   DateTime startTime =
  //       intl.DateFormat(apiTimeOfDayFormat, 'en').parse(halfStartTime);
  //   DateTime endTime =
  //       intl.DateFormat(apiTimeOfDayFormat, 'en').parse(halfEndTime);
  //   // logger.d(endTime.difference(startTime).inMinutes);
  //   return endTime.difference(startTime).inMinutes.toString();
  // }
  ///...
  // String getEstimateTimeAsMAndSeconds(
  //     String halfStartTime, String halfEndTime) {
  //   // logger.d('$halfStartTime    $halfEndTime');
  //   DateTime startTime =
  //       intl.DateFormat(apiTimeOfDayFormat, 'en').parse(halfStartTime);
  //   DateTime endTime =
  //       intl.DateFormat(apiTimeOfDayFormat, 'en').parse(halfEndTime);
  //   // logger.d(endTime.difference(startTime).inMinutes);
  //   return showDurationInString(endTime.difference(startTime));
  //   // return endTime.difference(startTime).inMinutes.toString();
  // }

  String showDurationInString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  bool isCurrentDateInRange(DateTimeRange dateTimeRange) {
    final currentDate = DateTime.now();
    return currentDate.isAfter(dateTimeRange.start) &&
        currentDate.isBefore(dateTimeRange.end);
  }

  static DateTime? fromString(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;

    try {
      // Try ISO 8601 format first
      return DateTime.parse(dateStr);
    } catch (e) {
      // Try alternative formats
      try {
        return _parseAlternativeFormat(dateStr);
      } catch (_) {
        return null;
      }
    }
  }

  /// Parse alternative date formats
  static DateTime? _parseAlternativeFormat(String dateStr) {
    // Remove any time part if present
    final datePart = dateStr.split(' ')[0];

    // Try DD-MM-YYYY or DD/MM/YYYY
    if (datePart.contains('-') || datePart.contains('/')) {
      final separator = datePart.contains('-') ? '-' : '/';
      final parts = datePart.split(separator);

      if (parts.length == 3) {
        // Check if format is DD-MM-YYYY
        if (parts[0].length <= 2) {
          return DateTime(
              int.parse(parts[2]), // year
              int.parse(parts[1]), // month
              int.parse(parts[0]) // day
              );
        }
        // Otherwise assume YYYY-MM-DD
        else {
          return DateTime(
              int.parse(parts[0]), // year
              int.parse(parts[1]), // month
              int.parse(parts[2]) // day
              );
        }
      }
    }

    return null;
  }

  /// Convert DateTime to ISO 8601 String
  /// Format: "2024-01-15T10:30:00.000Z"
  static String? toISOString(DateTime? date) {
    return date?.toIso8601String();
  }

  /// Convert DateTime to simple date String
  /// Format: "2024-01-15"
  static String? toSimpleString(DateTime? date) {
    if (date == null) return null;
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Convert DateTime to formatted String
  /// Format: "15/01/2024"
  static String toFormattedString(DateTime? date,
      {String format = 'yyyy-MM-dd'}) {
    if (date == null) return '';
    return intl.DateFormat(format).format(date);
  }

  /// Convert DateTime to display String
  /// Format: "15 Jan 2024"
  static String? toDisplayString(DateTime? date) {
    if (date == null) return null;

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// Convert DateTime to time String
  /// Format: "10:30 AM"
  static String? toTimeString(DateTime? date, {bool use24Hour = false}) {
    if (date == null) return null;

    if (use24Hour) {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      final hour =
          date.hour == 0 ? 12 : (date.hour > 12 ? date.hour - 12 : date.hour);
      final period = date.hour >= 12 ? 'PM' : 'AM';
      return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
    }
  }

  /// Convert DateTime to date and time String
  /// Format: "15 Jan 2024, 10:30 AM"
  static String? toDateTimeString(DateTime? date, {bool use24Hour = false}) {
    if (date == null) return null;
    return '${toDisplayString(date)}, ${toTimeString(date, use24Hour: use24Hour)}';
  }

  /// Get relative time string (e.g., "2 hours ago", "in 3 days")
  static String? toRelativeString(DateTime? date) {
    if (date == null) return null;

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.isNegative) {
      // Future date
      final futureDiff = date.difference(now);
      if (futureDiff.inDays > 365) {
        return 'in ${(futureDiff.inDays / 365).floor()} years';
      } else if (futureDiff.inDays > 30) {
        return 'in ${(futureDiff.inDays / 30).floor()} months';
      } else if (futureDiff.inDays > 0) {
        return 'in ${futureDiff.inDays} days';
      } else if (futureDiff.inHours > 0) {
        return 'in ${futureDiff.inHours} hours';
      } else if (futureDiff.inMinutes > 0) {
        return 'in ${futureDiff.inMinutes} minutes';
      } else {
        return 'in a few seconds';
      }
    } else {
      // Past date
      if (difference.inDays > 365) {
        return '${(difference.inDays / 365).floor()} years ago';
      } else if (difference.inDays > 30) {
        return '${(difference.inDays / 30).floor()} months ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'just now';
      }
    }
  }

  /// Check if date is today
  static bool isToday(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime? date) {
    if (date == null) return false;
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime? date) {
    if (date == null) return false;
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Get age from date of birth
  static int? getAge(DateTime? dateOfBirth) {
    if (dateOfBirth == null) return null;

    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;

    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }

    return age;
  }

  /// Add days to date
  static DateTime? addDays(DateTime? date, int days) {
    return date?.add(Duration(days: days));
  }

  /// Subtract days from date
  static DateTime? subtractDays(DateTime? date, int days) {
    return date?.subtract(Duration(days: days));
  }

  /// Get start of day (00:00:00)
  static DateTime? startOfDay(DateTime? date) {
    if (date == null) return null;
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day (23:59:59)
  static DateTime? endOfDay(DateTime? date) {
    if (date == null) return null;
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  static String getFriendlyDateGroup(DateTime date,
      {String dateFormat = 'dd, MMM yyyy'}) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final inputDate = DateTime(date.year, date.month, date.day);

    if (inputDate == today) {
      return "Today";
    } else if (inputDate == yesterday) {
      return "Yesterday";
    }

    // Format: dd, MMM yyyy  (e.g. 05, Feb 2024)
    return intl.DateFormat(dateFormat).format(date);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay matchTime) {
    // print('now => $hour:$minute');
    // print('match => ${matchTime.hour}:${matchTime.minute}');
    if (hour < matchTime.hour) return -1;
    if (hour > matchTime.hour) return 1;
    if (minute < matchTime.minute) return -1;
    if (minute > matchTime.minute) return 1;
    return 0;
  }

  static String formatDate(DateTime date) {
    return intl.DateFormat('yyyy-MM-dd').format(date);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static int daysBetween(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }
}
