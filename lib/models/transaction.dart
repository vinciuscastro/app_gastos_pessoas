
class Transaction {
  final int? id;
  final String title;
  final double value;
  final DateTime data;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'data': data.toIso8601String(),
    };
  }

  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      value: map['value'],
      data: DateTime.parse(map['data']),
    );
  }
  @override
  String toString() {
    return 'id: $id, titulo: $title, valor: $value, data: $data)';
  }
  const Transaction({required this.id, required this.title, required this.value, required this.data});


}