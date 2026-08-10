import 'package:flutter/material.dart';

import '../../screens/auth/splash_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/auth/forgot_password_screen.dart';

import '../../screens/admin/admin_home_screen.dart';
import '../../screens/admin/users_screen.dart';
import '../../screens/admin/apartments_screen.dart';
import '../../screens/admin/reports_screen.dart';
import '../../screens/admin/activity_logs_screen.dart';

import '../../screens/security/security_home_screen.dart';
import '../../screens/security/add_visitor_screen.dart';
import '../../screens/security/visitor_list_screen.dart';
import '../../screens/security/visitor_details_screen.dart';
import '../../screens/security/qr_scanner_screen.dart';
import '../../screens/security/qr_pass_screen.dart';

import '../../screens/resident/resident_home_screen.dart';
import '../../screens/resident/visitor_requests_screen.dart';
import '../../screens/resident/pre_register_screen.dart';
import '../../screens/resident/visitor_history_screen.dart';

import '../../screens/common/profile_screen.dart';
import '../../screens/common/settings_screen.dart';
import '../../screens/common/notifications_screen.dart';
import '../../screens/common/about_screen.dart';
import '../../screens/common/privacy_screen.dart';
import '../../screens/common/help_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';

  static const String adminHome = '/adminHome';
  static const String users = '/users';
  static const String apartments = '/apartments';
  static const String reports = '/reports';
  static const String activityLogs = '/activityLogs';

  static const String securityHome = '/securityHome';
  static const String addVisitor = '/addVisitor';
  static const String visitorList = '/visitorList';
  static const String visitorDetails = '/visitorDetails';
  static const String qrScanner = '/qrScanner';
  static const String qrPass = '/qrPass';

  static const String residentHome = '/residentHome';
  static const String visitorRequests = '/visitorRequests';
  static const String preRegister = '/preRegister';
  static const String visitorHistory = '/visitorHistory';

  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String privacy = '/privacy';
  static const String help = '/help';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        forgotPassword: (context) => const ForgotPasswordScreen(),

        adminHome: (context) => const AdminHomeScreen(),
        users: (context) => const UsersScreen(),
        apartments: (context) => const ApartmentsScreen(),
        reports: (context) => const ReportsScreen(),
        activityLogs: (context) => const ActivityLogsScreen(),

        securityHome: (context) => const SecurityHomeScreen(),
        addVisitor: (context) => const AddVisitorScreen(),
        visitorList: (context) => const VisitorListScreen(),
        visitorDetails: (context) => const VisitorDetailsScreen(),
        qrScanner: (context) => const QrScannerScreen(),
        qrPass: (context) => const QrPassScreen(),

        residentHome: (context) => const ResidentHomeScreen(),
        visitorRequests: (context) => const VisitorRequestsScreen(),
        preRegister: (context) => const PreRegisterScreen(),
        visitorHistory: (context) => const VisitorHistoryScreen(),

        profile: (context) => const ProfileScreen(),
        settings: (context) => const SettingsScreen(),
        notifications: (context) => const NotificationsScreen(),
        about: (context) => const AboutScreen(),
        privacy: (context) => const PrivacyScreen(),
        help: (context) => const HelpScreen(),
      };
}
