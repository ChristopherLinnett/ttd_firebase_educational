import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttd_firebase_educational/core/common/app/providers/tab_navigator.dart';
import 'package:ttd_firebase_educational/core/common/app/providers/user_provider.dart';
import 'package:ttd_firebase_educational/src/auth/domain/entities/user.dart';
import 'package:ttd_firebase_educational/src/dashboard/presentation/providers/dashboard_controller.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;
  Orientation get orientation => mediaQuery.orientation;

  UserProvider get userProvider => read<UserProvider>();

  LocalUser? get user => userProvider.user;

  DashboardController get dashboardController => read<DashboardController>();

  TabNavigator get tabNavigator => read<TabNavigator>();

  void pop() => tabNavigator.pop();

  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}
