extension DateTimeFormatting on DateTime {
  /// "16/10/2023".
  String formatAsShortDate() {
    return "${this.day}/${this.month}/${this.year}";
  }

  /// "October 16, 2023".
  String formatAsLongDate() {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return "${months[this.month - 1]} ${this.day}, ${this.year}";
  }

  /// "09:30".
  String formatAsTime() {
    return "${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}";
  }

  /// "16/10/2023 09:30".
  String formatAsDateTime() {
    return "${this.formatAsShortDate()} ${this.formatAsTime()}";
  }

  /// "Oct 16".
  String formatAsMonthDay() {
    final months = [
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
    return "${months[this.month - 1]} ${this.day}";
  }

  /// "09:30 AM".
  String formatAsTimeWithAMPM() {
    String period = this.hour < 12 ? 'AM' : 'PM';
    int hour12 = this.hour > 12 ? this.hour - 12 : this.hour;
    if (hour12 == 0) {
      hour12 = 12; // 12:00 AM is midnight
    }
    return "${hour12.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')} $period";
  }
}