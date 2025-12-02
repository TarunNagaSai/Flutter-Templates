import 'package:animations/src/home/slivers/stacked_header.dart';
import 'package:animations/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeaderSliver extends StatefulWidget {
  const HeaderSliver({super.key});

  @override
  State<HeaderSliver> createState() => _HeaderSliverState();
}

class _HeaderSliverState extends State<HeaderSliver>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: StickyHeaderDelegate(
        builder: (isPinned, sizeWidth) {
          return Stack(
            children: [
              Align(alignment: Alignment.centerRight, child: ThemeWidget()),
              AnimatedBuilder(
                animation: AlwaysStoppedAnimation(isPinned ? 0.96 : 1.0),
                builder: (context, child) {
                  return Container(
                    width: sizeWidth * (isPinned ? 0.96 : 1.0),
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Cards',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
        minHeight: 80,
        maxHeight: 120,
      ),
      pinned: true,
    );
  }
}

/// A widget that toggles between light and dark theme icons with animation.
class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Consumer(
        builder: (context, ref, _) {
          isDark = Theme.of(context).brightness == Brightness.dark;
          return IconButton(
            tooltip: 'Toggle Theme',
            onPressed: () {
              ref.read(themeModeProvider.notifier).state = isDark
                  ? ThemeMode.light
                  : ThemeMode.dark;
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                // Slide down old icon, slide up new icon
                final inAnimation = Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(animation);
                if (child.key == const ValueKey('dark')) {
                  // dark icon coming up
                  return ClipRect(
                    child: SlideTransition(position: inAnimation, child: child),
                  );
                } else {
                  // light icon coming up
                  return ClipRect(
                    child: SlideTransition(position: inAnimation, child: child),
                  );
                }
              },
              child: isDark
                  ? const Icon(
                      Icons.light_mode,
                      key: ValueKey('light'),
                      color: Colors.amber,
                    )
                  : const Icon(
                      Icons.dark_mode,
                      key: ValueKey('dark'),
                      color: Colors.black,
                    ),
            ),
          );
        },
      ),
    );
  }
}
