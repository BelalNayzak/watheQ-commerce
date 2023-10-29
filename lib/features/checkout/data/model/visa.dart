class Visa {
  final String id;
  final String ccv;
  final String cardNumber;
  final String pin;
  final String date1;
  final String date2;

  Visa({
    required this.id,
    required this.ccv,
    required this.cardNumber,
    required this.pin,
    required this.date1,
    required this.date2,
  });

  factory Visa.fromJson(Map<String, dynamic> json) {
    return Visa(
      id: json['id'] as String,
      ccv: json['ccv'] as String,
      cardNumber: json['cardNumber'] as String,
      pin: json['pin'] as String,
      date1: json['date1'] as String,
      date2: json['date2'] as String,
    );
  }
}