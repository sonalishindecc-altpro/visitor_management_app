import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/visitor_model.dart';
import '../models/apartment_model.dart';
import '../models/notification_model.dart';

class AppState with ChangeNotifier {
  UserModel? _currentUser;
  List<VisitorModel> _visitors = [];
  List<ApartmentModel> _apartments = [];
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  List<VisitorModel> get visitors => _visitors;
  List<ApartmentModel> get apartments => _apartments;
  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  int get unreadNotificationCount =>
      _notifications.where((n) => !n.isRead).length;

  void setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  void setVisitors(List<VisitorModel> visitors) {
    _visitors = visitors;
    notifyListeners();
  }

  void addVisitor(VisitorModel visitor) {
    _visitors.insert(0, visitor);
    notifyListeners();
  }

  void updateVisitor(VisitorModel visitor) {
    final index = _visitors.indexWhere((v) => v.id == visitor.id);
    if (index != -1) {
      _visitors[index] = visitor;
      notifyListeners();
    }
  }

  void setApartments(List<ApartmentModel> apartments) {
    _apartments = apartments;
    notifyListeners();
  }

  void setNotifications(List<NotificationModel> notifications) {
    _notifications = notifications;
    notifyListeners();
  }

  void markNotificationRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearState() {
    _currentUser = null;
    _visitors = [];
    _apartments = [];
    _notifications = [];
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}
