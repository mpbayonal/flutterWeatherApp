
import 'package:flutter/cupertino.dart';

/// Vertical spacing [Container] implementing de default spacing
class SpacingContainer extends StatelessWidget {
  static const defaultSpacing = 8.0;

  /// A multiplier for the [AppDefaults.spacing]
  final double multiplier;

  /// (x == width, y == height)
  final SpacingDirection direction;

  const SpacingContainer({
    this.multiplier = 1,
    this.direction = SpacingDirection.y
  });

  @override
  Widget build(BuildContext context) => Container(
    height: direction == SpacingDirection.y ? defaultSpacing * multiplier : null,
    width: direction == SpacingDirection.x ? defaultSpacing * multiplier : null,
  );
}

/// The direction in which the spacing is required
enum SpacingDirection {
  x, y
}