import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TabNavigator extends ChangeNotifier {
  TabNavigator(this._initialPage) {
    _navigationStack.add(_initialPage);
  }
  final TabItem _initialPage;

  final List<TabItem> _navigationStack = [];

  TabItem get currentPage => _navigationStack.last;

  String? get previousPageType => _navigationStack.length == 1
      ? null
      : _navigationStack[_navigationStack.length - 2]
          .child
          .runtimeType
          .toString()
          .replaceAll('View', '')
          .replaceAll('Page', '');

  void push(TabItem page) {
    _navigationStack.add(page);
    notifyListeners();
  }

  void pop() {
    if (_navigationStack.length > 1) {
      _navigationStack.removeLast();
      notifyListeners();
    }
  }

  void popToRoot() {
    _navigationStack
      ..clear()
      ..add(_initialPage);

    notifyListeners();
  }

  void popUntil(TabItem? page) {
    if (page == null) return popToRoot();
    final pageIndex = _navigationStack.indexOf(page);
    if (pageIndex > -1) {
      _navigationStack.removeWhere(
        (navigationPage) =>
            _navigationStack.indexOf(navigationPage) > pageIndex,
      );
      notifyListeners();
    }
  }

  void pushAndRemoveUntil(TabItem newPage, TabItem untilPage) {
    popUntil(untilPage);
    push(newPage);
  }

  void pushReplacement(TabItem page) {
    _navigationStack
      ..clear()
      ..add(page);
    notifyListeners();
  }
}

class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {
  const TabNavigatorProvider({
    required this.navigator,
    required super.child,
    super.key,
  }) : super(notifier: navigator);

  final TabNavigator navigator;

  static TabNavigator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
        ?.navigator;
  }
}

class TabItem extends Equatable {
  TabItem({required this.child}) : id = const Uuid().v1();

  final Widget child;
  final String id;

  @override
  List<Object?> get props => [child, id];
}
