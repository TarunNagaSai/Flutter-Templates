import 'package:animations/src/home/slivers/header_sliver.dart';
import 'package:animations/src/home/slivers/stacked_header.dart';
import 'package:animations/src/home/slivers/welcome_sliver.dart';
import 'package:flutter/material.dart';

/// A list of slivers used in the Home screen's CustomScrollView.
final List<Widget> sliverList = [
  SliverFillRemaining(child: WelcomeSliver()),

  /// Clips arts
  /// layout animations (Grid or Staggered or Masonry or List)
  /// Hero animations
  /// Loaders all type of loaders
  /// Cards
  /// Accessability Features
  /// Confetti
  /// Custom Toasts, Custom Cards, Custom Bottom Sheets, Alerts, Dialogs
  /// flutter_staggered_grid_view
  /// Parallax effects
  HeaderSliver(),
  SliverToBoxAdapter(child: Divider(height: 2)),
  SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, i) => ListTile(
        leading: CircleAvatar(child: Text('0')),
        title: Text('List tile #$i'),
      ),
      childCount: 30,
    ),
  ),
];
