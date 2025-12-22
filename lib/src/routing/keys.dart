
// path: lib/src/routing/keys.dart
import 'package:flutter/widgets.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');

final GlobalKey<NavigatorState> newsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'news');

final GlobalKey<NavigatorState> deliveryNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'delivery');

final GlobalKey<NavigatorState> profileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'profile');
