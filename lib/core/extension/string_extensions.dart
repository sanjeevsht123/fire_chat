extension StringX on String {
  String get needTranslation => this;
  String get needFurtherWork => this;
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  bool isNotPhoneNumber() {
    try {
      double.parse(this);
      return false;
    } catch (e) {
      return true;
    }
  }

  int get toInt {
    return int.tryParse(this) ?? 0;
  }

  double get toDouble {
    return double.tryParse(this) ?? 0;
  }

  bool get isEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);

  bool get isPassword => RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$')
      .hasMatch(this);

  bool get isPhoneNumber => RegExp(r'^\+?[0-9]\d{0,9}$').hasMatch(this);

  bool get isFullName => !RegExp(r'\s').hasMatch(this);

  bool get isValidNid => RegExp(r'^\d{12}$').hasMatch(this);
  // (RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$').hasMatch(this) ||
  //     RegExp(r'^[a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+$').hasMatch(this) ||
  //     RegExp(r'^[a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+$').hasMatch(this) ||
  //     RegExp(r'^[a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+$')
  //         .hasMatch(this));

  /// convert string to double
  /// check if string is integer
  /// if true, convert to double
  ///
  /// if false, return 0.0
  /// check if string is double
  /// if true, convert to double
  ///
  /// if false, return 0.0
  double get convertToDouble {
    if (this.isInteger) {
      return double.parse(this);
    } else if (this.isDouble) {
      return double.parse(this);
    } else {
      return 0.0;
    }
  }

  /// check if string is integer
  /// if true, return true
  /// if false, return false
  bool get isInteger {
    try {
      int.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// check if string is double
  /// if true, return true
  /// if false, return false
  bool get isDouble {
    try {
      double.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  String get hiddenAmount {
    int length = this.length;
    return this
        .replaceRange(0, length, List.generate(length, (index) => 'X').join());
  }

  String get hiddenWalletId {
    int length = this.length;
    return this.replaceRange(
        0, length - 4, List.generate(length - 4, (index) => 'X').join());
  }

  String reversed(bool reverse) {
    if (reverse) {
      return this.split('').reversed.join();
    } else {
      return this;
    }
  }

  String trimLeadingZeros() => this.replaceFirst(RegExp(r'^0+'), '');

  String toTextWithEllipsis() {
    List<String> words = this.split(' ');
    String truncatedText = '';

    if (words.length > 3) {
      // Join the first three words and add ellipsis
      truncatedText = words.sublist(0, 3).join(' ') + '...';
    } else {
      truncatedText = this;
    }
    return truncatedText;
  }

  bool get isFirstTwoDigitFrom1OR2 => RegExp(r'^[12]').hasMatch(this);
  bool get dateValidationFrom1900To2010 =>
      RegExp(r'^(19\d\d|20(0\d|10))$').hasMatch(this);

  bool get isAmountNotValidate =>
      RegExp(r'^(?!0(\.0+)?$)\d+(\.\d+)?$').hasMatch(this);
}

extension StringNullX on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullNotEmpty => this != null && this!.isNotEmpty;

  bool get isSvg => this != null && this!.toLowerCase().endsWith('.svg');
}

extension StringInterpolation on String {
  String replacePlaceholders(Map<String, dynamic> data) {
    final regex = RegExp(r'\$(\w+)');
    return this.replaceAllMapped(regex, (match) {
      final key = match.group(1);
      if (key != null && data.containsKey(key)) {
        return data[key]?.toString() ?? '';
      }
      return match.group(0) ?? '';
    });
  }
}

extension StringExtension on String {
  String capitalizeEachWord() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }
}

class ErrorInfo {
  ErrorInfo({required this.message, required this.code});
  final String message;
  final String code;
}

extension ErrorInfoExtension on String {
  ErrorInfo extractErrorInfo() {
    final regExp = RegExp(r'^(.*)\s+\(code:\s*([^)]+)\)$');
    final match = regExp.firstMatch(this);
    if (match != null) {
      final extractedMessage = match.group(1)?.trim() ?? this;
      final extractedCode = match.group(2)?.trim() ?? 'N/A';
      return ErrorInfo(message: extractedMessage, code: extractedCode);
    } else {
      return ErrorInfo(message: this, code: 'N/A');
    }
  }
}

extension DoubleX on double {
  String get roundup => this.toStringAsFixed(2);
  String get roundup1 => this.toStringAsFixed(1);
  String get roundup0 => this.toStringAsFixed(0);
}
