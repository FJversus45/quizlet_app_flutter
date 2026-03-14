import 'dart:io';
import 'package:flutter/material.dart';

class ParserUtil<T> {
  static DateTime parseJsonDate(String? dateString) {
    try {
      return DateTime.parse(dateString!);
    } catch (e) {
      return DateTime.now();
    }
  }

  static bool parseJsonBoolean(Map? json, String param) {
    try {
      Object? result = json![param];
      if (result == null) return false;
      return result as bool;
    } catch (e) {
      return false;
    }
  }

  static int getJsonListCount(List<dynamic>? json) {
    try {
      return json!.length;
    } catch (e) {
      return 0;
    }
  }

  List<T> parseJsonList({
    required List<dynamic>? json,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    try {
      final data = List<Map<String, dynamic>>.from(json!);
      return List<T>.from(
        data.map(
          (e) => fromJson(e),
        ),
      );
    } catch (e) {
      return [];
    }
  }

  static num parseJsonNum(Map? json, String param) {
    try {
      Object? result = json![param];

      if (result == null) return 0;
      if (result is String) return num.parse(result);
      return result as num;
    } catch (e) {
      return 0;
    }
  }

  static double parseJsonDouble(Map? json, String param) {
    try {
      Object? result = json![param];

      if (result == null) return 0.0;
      var convertedResult = double.parse(result.toString());
      return convertedResult;
    } catch (e) {
      return 0.0;
    }
  }

  static String _getMonth(
    int month, [
    bool shorten = false,
  ]) {
    String result;
    switch (month) {
      case 1:
        result = 'January';
        break;
      case 2:
        result = 'Febuary';
        break;
      case 3:
        result = 'March';
        break;
      case 4:
        result = 'April';
        break;
      case 5:
        result = 'May';
        break;
      case 6:
        result = 'June';
        break;
      case 7:
        return 'July';
      case 8:
        result = 'August';
        break;
      case 9:
        result = 'September';
        break;
      case 10:
        result = 'October';
        break;
      case 11:
        result = 'November';
        break;
      default:
        result = 'December';
        break;
    }

    if (shorten) return result.substring(0, 3);
    return result;
  }

  static String _appendDateSuffix(int day) {
    switch (day) {
      case 1:
      case 21:
      case 31:
        return '${day}st';
      case 2:
      case 22:
        return '${day}nd';
      case 3:
      case 23:
        return '${day}rd';

      default:
        return '${day}th';
    }
  }

  ///Formats [date] to string like -> `9 Jul 2021, 11:34 PM`
  ///
  ///Or 09/07/2021 when [forLoan] is `true`
  static String formatDateTime(
    DateTime date, {
    bool forEvent = false,
    bool forTransaction = false,
    bool forUpcomingListing = false,
    bool forLoan = false,
  }) {
    try {
      final date0 = date.toLocal();

      if (forLoan) {
        return "${date0.day.toString().padLeft(2, '0')}/${date0.month.toString().padLeft(2, '0')}/${date0.year}";
      }

      final time = TimeOfDay.fromDateTime(date0);
      String period = 'AM';

      if (time.period == DayPeriod.pm) {
        period = 'PM';
      }
      if (forEvent) {
        return '${date0.day} ${_getMonth(date0.month)} ${date0.year}';
      }

      if (forUpcomingListing) {
        return '${_appendDateSuffix(date0.day)} ${_getMonth(date0.month, true)}, ${date0.year}';
      }

      if (forTransaction) {
        return "${_appendDateSuffix(date0.day)} ${_getMonth(date0.month, true)}, ${date0.year} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
      }

      return "${date0.day} ${_getMonth(date0.month, true)} ${date0.year}, ${time.hourOfPeriod}:${time.minute.toString().padLeft(2, '0')} $period";
    } catch (e) {
      return '';
    }
  }

  ///Truncates 0 decimals in integers.
  ///900.0 becomes 900.
  ///If [amount] is a double, it's returned in 2 decimal places
  static String _truncateAmountDecimalIfPossible(num amount) {
    try {
      if (amount.truncate() == amount) return amount.truncate().toString();
      return amount.toStringAsFixed(2);
    } catch (e) {
      return amount.toStringAsFixed(2);
    }
  }

  ///Formats a string amount and appends [currencyPrefix].
  static String formatCurrency(
    String number, {
    String? currencyPrefix,
  }) {
    number = _truncateAmountDecimalIfPossible(num.parse(number));
    currencyPrefix = currencyPrefix ?? '';
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

    mathFunc(Match match) => '${match[1]},';

    String result = number.replaceAllMapped(reg, mathFunc);
    return "$currencyPrefix$result";
  }

  static String formatBidAmount(String number) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

    mathFunc(Match match) => '${match[1]},';

    String result = number.replaceAllMapped(reg, mathFunc);
    return result;
  }

//timeline/get_timeline_feeds_v2?type=submission&parentPostId=64c5533be1a520e4bf4af0b1&page=1
  static String formatBidDuration(DateTime date) {
    try {
      final duration = date.toLocal().difference(DateTime.now());

      if (duration.isNegative) return '';
      final durations = duration.toString().split(':');

      final seconds = num.parse(durations[2]).toInt();
      int days = 0;
      int hours = (int.tryParse(durations[0]) ?? 0);

      if (hours > 24) {
        // days = (hours / 24).ceil();
        days = (hours ~/ 24);
        // hours = (days * 24) - hours;
        hours = hours - (days * 24);
      }
      if (days > 0) return '${days}d ${hours}h ${durations[1]}m ${seconds}s';
      return '${hours}h ${durations[1]}m ${seconds}s';
    } catch (e) {
      return '';
    }
  }

  static String getFileName(String file) {
    try {
      return file.split(Platform.pathSeparator).last;
    } catch (e) {
      return '';
    }
  }

  static bool isVideo(String filePath) {
    try {
      final allowedExtensions = ['mp4', 'mov', '3gp', 'avi', 'mkv'];
      final fileExtension = filePath.split('.').last.toLowerCase();
      return allowedExtensions.contains(fileExtension);
    } catch (e) {
      return false;
    }
  }

  static bool isAudio(String filePath) {
    try {
      final allowedExtensions = ['mp3', 'wav', 'm4a', 'aac'];
      final fileExtension = filePath.split('.').last.toLowerCase();
      return allowedExtensions.contains(fileExtension);
    } catch (e) {
      return false;
    }
  }

  static bool isImage(String filePath) {
    try {
      final allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
      final fileExtension = filePath.split('.').last.toLowerCase();
      return allowedExtensions.contains(fileExtension);
    } catch (e) {
      return false;
    }
  }

  static bool isPDF(String filePath) {
    try {
      final allowedExtensions = ['pdf'];

      final fileExtension = filePath.split('.').last.toLowerCase();
      return allowedExtensions.contains(fileExtension);
    } catch (e) {
      return false;
    }
  }

  static bool isAllowedFileExtension(String filePath) {
    try {
      final allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'mp3', 'wav'];

      final fileExtension = filePath.split('.').last.toLowerCase();
      return allowedExtensions.contains(fileExtension);
    } catch (e) {
      return false;
    }
  }

  static String getFileMimeType(String filePath) {
    try {
      final extension =
          filePath.split(Platform.pathSeparator).last.split('.').last;

      switch (extension.toLowerCase()) {
        case 'mp4':
          return 'video/mp4';
        case 'mov':
          return 'video/quicktime';
        case 'gif':
          return 'image/gif';
        case 'png':
          return 'image/png';
        case 'heic':
          return 'image/heic';
        case 'jpg':
        case 'jpeg':
          return 'image/jpeg';
        case 'mp3':
          return 'audio/mp3';
        case 'wav':
          return 'audio/wav';
        case 'm4a':
          return 'audio/m4a';
        default:
          return '';
      }
    } catch (e) {
      return '';
    }
  }

  static int parseJsonInt(Map? json, String param) {
    try {
      json = json as Map;

      Object? result = json[param];

      if (result == null) return 0;
      var convertResultToDouble = double.parse(result.toString());
      var convertResultToInt = convertResultToDouble.toInt();
      return convertResultToInt;
    } catch (e) {
      return 0;
    }
  }
}
