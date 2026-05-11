import 'package:flutter/widgets.dart';
import 'breakpoints.dart';

enum ScreenType { compact, medium, expanded, large }

ScreenType screenTypeOf(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;

  if (width >= Breakpoints.large) return ScreenType.large;
  if (width >= Breakpoints.expanded) return ScreenType.expanded;
  if (width >= Breakpoints.medium) return ScreenType.medium;
  return ScreenType.compact;
}

class AdaptiveBuilder extends StatelessWidget {
  final WidgetBuilder compact;
  final WidgetBuilder? medium;
  final WidgetBuilder? expanded;
  final WidgetBuilder? large;

  const AdaptiveBuilder({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
  });

  @override
  Widget build(BuildContext context) {
    final tier = screenTypeOf(context);

    switch (tier) {
      case ScreenType.large:
        return (large ?? expanded ?? medium ?? compact)(context);

      case ScreenType.expanded:
        return (expanded ?? medium ?? compact)(context);

      case ScreenType.medium:
        return (medium ?? compact)(context);

      case ScreenType.compact:
        return compact(context);
    }
  }
}
