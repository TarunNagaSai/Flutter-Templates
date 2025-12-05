import 'package:animations/src/home/slivers/stacked_header.dart';
import 'package:animations/src/providers/theme_provider.dart';
import 'package:animations/src/providers/title_animation_provider.dart';
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
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: !isPinned
                  ? null
                  : BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                    ),
            ),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, top: 40),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .end,
                children: [
                  Consumer(
                    builder: (context, ref, _) {
                      final title = ref.watch(titleModeProvider);
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          title,
                          key: ValueKey(title),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  ThemeWidget(isPinned: isPinned),
                ],
              ),
            ),
          );
        },
        minHeight: 120,
        maxHeight: 160,
      ),
      pinned: true,
    );
  }
}

/// A widget that toggles between light and dark theme icons with animation.
class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key, required this.isPinned});
  final bool isPinned;
  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget>
    with TickerProviderStateMixin {
  bool isDark = false;
  late final Animation<double> _fade;
  late final AnimationController _fadeAnimationController;

  @override
  void initState() {
    super.initState();

    /// Fade Animation
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fade = CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeIn,
    );
  }

  void checkFade() {
    if (widget.isPinned) {
      _fadeAnimationController.forward();
      return;
    } else {
      _fadeAnimationController.reverse();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFade();
    return FadeTransition(
      opacity: _fade,
      child: Padding(
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
                      child: SlideTransition(
                        position: inAnimation,
                        child: child,
                      ),
                    );
                  } else {
                    // light icon coming up
                    return ClipRect(
                      child: SlideTransition(
                        position: inAnimation,
                        child: child,
                      ),
                    );
                  }
                },
                child: isDark
                    ? const Icon(
                        Icons.light_mode,
                        key: ValueKey('light'),
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.dark_mode,
                        key: ValueKey('dark'),
                        color: Colors.white,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
