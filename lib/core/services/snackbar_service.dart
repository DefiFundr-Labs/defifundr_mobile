import 'package:flutter/material.dart';

import '../../feature/common/models/snackbar_data_model.dart';

class SnackbarService extends ChangeNotifier {
  SnackbarService._internal();
  static final SnackbarService _instance = SnackbarService._internal();
  factory SnackbarService() => _instance;

  final List<SnackbarData> _queue = [];
  final int _maxQueueLength = 5;
  bool _isSnackbarVisible = false;
  SnackbarData? _currentSnackbarData;

  SnackbarData? get currentSnackbarData => _currentSnackbarData;

  void showSuccessSnackbar({required String title, required String message}) {
    if (_queue.length == _maxQueueLength) throw Exception("Snackbar queue is full");
    final snackbarData = SnackbarData(title: title, message: message, isError: false);
    if (_queue.isNotEmpty || _isSnackbarVisible) return _queue.add(snackbarData);
    return _displaySnackbar(snackbarData);
  }

  void showErrorSnackbar({required String title, required String message}) {
    if (_queue.length == _maxQueueLength) throw Exception("Snackbar queue is full");
    final snackbarData = SnackbarData(title: title, message: message, isError: true);
    if (_queue.isNotEmpty || _isSnackbarVisible) return _queue.add(snackbarData);
    return _displaySnackbar(snackbarData);
  }

  void _displaySnackbar(SnackbarData snackbarData) {
    _currentSnackbarData = snackbarData;
    _isSnackbarVisible = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 4), _insertFromQueue);
  }

  void _insertFromQueue() {
    if (_queue.isEmpty) {
      _isSnackbarVisible = false;
      _currentSnackbarData = null;
      notifyListeners();
      return;
    }
    _displaySnackbar(_queue.removeAt(0));
  }
}
