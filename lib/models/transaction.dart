import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime data;

  const Transaction({required this.id, required this.title, required this.value, required this.data});
}