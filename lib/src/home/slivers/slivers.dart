import 'package:animations/src/home/slivers/accessability_slivers.dart';
import 'package:animations/src/home/slivers/cards_sliver.dart';
import 'package:animations/src/home/slivers/clip_art_widgets.dart';
import 'package:animations/src/home/slivers/custom_popups_slivers.dart';
import 'package:animations/src/home/slivers/header_sliver.dart';
import 'package:animations/src/home/slivers/live_activities.dart';
import 'package:animations/src/home/slivers/loading_slivers.dart';
import 'package:animations/src/home/slivers/local_custom_notifications.dart';
import 'package:animations/src/home/slivers/parallax_effects.dart';
import 'package:animations/src/home/slivers/scrollable_layouts.dart';
import 'package:animations/src/home/slivers/thankyou_sliver.dart';
import 'package:animations/src/home/slivers/welcome_sliver.dart';
import 'package:flutter/material.dart';

/// wrap a class around this file
///

/// Global keys for each sliver section
GlobalKey welcomeKey = GlobalKey();
GlobalKey headerKey = GlobalKey();
GlobalKey cardsKey = GlobalKey();
GlobalKey clipArtsKey = GlobalKey();
GlobalKey layoutsKey = GlobalKey();
GlobalKey loadersKey = GlobalKey();
GlobalKey popupsKey = GlobalKey();
GlobalKey accessabilityKey = GlobalKey();
GlobalKey parallaxKey = GlobalKey();
GlobalKey notificationsKey = GlobalKey();
GlobalKey liveActivitiesKey = GlobalKey();
GlobalKey thankYouKey = GlobalKey();

class SliverSections {
  /// A list of global keys corresponding to each sliver section.
  static List<GlobalKey> sliverKeys = [
    welcomeKey,
    headerKey,
    cardsKey,
    clipArtsKey,
    layoutsKey,
    loadersKey,
    popupsKey,
    accessabilityKey,
    parallaxKey,
    notificationsKey,
    liveActivitiesKey,
    thankYouKey,
  ];

  /// A list of slivers used in the Home screen's CustomScrollView.
  static final List<Widget> sliverList = [
    /// Welcome Sliver
    WelcomeSliver(),

    /// Header Sliver
    HeaderSliver(),

    /// Cards and Hero animations
    CardsSliver(),

    /// Clips arts
    ClipArtWidgets(),

    /// layout animations (Grid or Staggered or Masonry or List) flutter_staggered_grid_view
    ScrollableLayouts(),

    /// Loaders all type of loaders
    LoadingSlivers(),

    /// Custom Toasts, Custom Cards, Custom Bottom Sheets, Alerts, Dialogs,Confetti
    CustomPopupsSlivers(),

    /// Accessability Features
    AccessabilitySlivers(),

    /// Parallax effects
    ParallaxEffects(),

    /// Custom Notifications
    LocalCustomNotifications(),

    ///Dynamic isLand
    LiveActivities(),

    /// Thank you Sliver
    ThankyouSliver(),
  ];

  /// Generates a list of sliver widgets wrapped with their corresponding global keys.
  static List<Widget> generateSliverList() {
    final updatedSliverList = <Widget>[];
    for (int index = 0; index < sliverKeys.length; index++) {
      if (index > 1) {
        updatedSliverList.add(
          KeyedSubtree(
            key: sliverKeys[index],
            child: SliverToBoxAdapter(child: sliverList[index]),
          ),
        );
      } else {
        updatedSliverList.add(
          KeyedSubtree(key: sliverKeys[index], child: sliverList[index]),
        );
      }
    }
    return updatedSliverList;
  }

  static Future<void> scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx != null) {
      await Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        alignment: 0, // 0 = top, 0.5 = center, 1.0 = bottom
        curve: Curves.easeInOut,
      );
    }
  }
}
