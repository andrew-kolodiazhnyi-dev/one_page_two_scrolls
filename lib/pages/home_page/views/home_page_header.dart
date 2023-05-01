import 'dart:math';

import 'package:flutter/material.dart';

class HomePageHeader extends SliverPersistentHeaderDelegate {
  final String title;
  final String subtitle;
  final String backgroungImagePath;

  HomePageHeader({
    required this.title,
    required this.subtitle,
    required this.backgroungImagePath,
  });

  MediaQueryData get mediaQueryData =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window);

  final double _initialAvatarSize =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height *
          0.15;
  final double _endAvatarSize = kToolbarHeight * 0.8;
  final double _padding4 = 4;
  final double _padding8 = 8;

  TextStyle get titleTextStyle => const TextStyle(fontSize: 24);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        /// Title lenght calculations
        Size titleSize = _calculateTextSize(
          context,
          title,
          titleTextStyle,
        );
        if (titleSize.width > constraints.maxWidth) {
          titleSize = Size(constraints.maxWidth - _padding4, titleSize.height);
        }

        /// Calculations for Title, if it is bigger than max width, Title will be shortened
        final maxEndTitleWidth =
            constraints.maxWidth - _padding4 - _endAvatarSize;
        final endTitleWidth = titleSize.width > maxEndTitleWidth
            ? maxEndTitleWidth
            : titleSize.width;

        /// Calculations for avatar start and end position (top left corner)
        final leftAvatarStart =
            constraints.maxWidth / 2 - _initialAvatarSize / 2;
        final topAvatarStart =
            constraints.maxHeight / 2 - _initialAvatarSize / 2;
        final leftAvatarEnd = constraints.maxWidth / 2 -
            (_endAvatarSize + _padding4 + endTitleWidth) / 2;
        final topAvatarEnd = mediaQueryData.padding.top +
            kToolbarHeight / 2 -
            _endAvatarSize / 2;

        /// Calculations for Title start and end position (top left corner)
        final leftTitleStart =
            constraints.maxWidth / 2 - titleSize.width / 2.01;
        final leftTitleEnd = leftAvatarEnd + _endAvatarSize + _padding4;
        final topTitleStart =
            maxExtent / 2 + _initialAvatarSize / 2 + _padding8;
        final topTitleEnd = mediaQueryData.padding.top +
            kToolbarHeight / 2 -
            titleSize.height / 2;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            _buildBackground(
              context,
              shrinkOffset,
              constraints,
            ),
            _buildAvatar(
              shrinkOffset: shrinkOffset,
              leftAvatarStart: leftAvatarStart,
              leftAvatarEnd: leftAvatarEnd,
              topAvatarStart: topAvatarStart,
              topAvatarEnd: topAvatarEnd,
            ),
            _buildTitle(
              shrinkOffset: shrinkOffset,
              topTitleStart: topTitleStart,
              topTitleEnd: topTitleEnd,
              leftTitleStart: leftTitleStart,
              leftTitleEnd: leftTitleEnd,
              constraints: constraints,
              maxEndTitleWidth: maxEndTitleWidth,
            ),
            _buildSubtitle(
              shrinkOffset: shrinkOffset,
              topTitleStart: topTitleStart,
              titleSize: titleSize,
              topTitleEnd: topTitleEnd,
            ),
          ],
        );
      },
    );
  }

  Visibility _buildSubtitle({
    required double shrinkOffset,
    required double topTitleStart,
    required Size titleSize,
    required double topTitleEnd,
  }) {
    return Visibility(
      visible: _calculateOpacity(shrinkOffset, maxExtent / 4) == 1,
      child: Positioned(
        top: _interpolationEaseOutCubic(
          inputValue: shrinkOffset,
          start: topTitleStart + titleSize.height,
          end: topTitleEnd,
        ),
        left: 0,
        right: 0,
        child: Opacity(
          opacity: _calculateOpacity(shrinkOffset, maxExtent / 8),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Positioned _buildTitle({
    required double shrinkOffset,
    required double topTitleStart,
    required double topTitleEnd,
    required double leftTitleStart,
    required double leftTitleEnd,
    required BoxConstraints constraints,
    required double maxEndTitleWidth,
  }) {
    return Positioned(
      top: _interpolationEaseOutCubic(
        inputValue: shrinkOffset,
        start: topTitleStart,
        end: topTitleEnd,
      ),
      left: _interpolationEaseOutCubic(
        inputValue: shrinkOffset,
        start: leftTitleStart,
        end: leftTitleEnd,
      ),
      child: SizedBox(
        width: _interpolationEaseOutCubic(
          inputValue: shrinkOffset,
          start: constraints.maxWidth,
          end: maxEndTitleWidth,
        ),
        child: Text(
          title,
          style: titleTextStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }

  Positioned _buildAvatar({
    required double shrinkOffset,
    required double leftAvatarStart,
    required double leftAvatarEnd,
    required double topAvatarStart,
    required double topAvatarEnd,
  }) {
    return Positioned(
      left: _interpolationEaseOutCubic(
        inputValue: shrinkOffset,
        start: leftAvatarStart,
        end: leftAvatarEnd,
        exponent: 4,
      ),
      top: _interpolationEaseOutCubic(
        inputValue: shrinkOffset,
        start: topAvatarStart,
        end: topAvatarEnd,
        exponent: 4,
      ),
      child: Container(
        /// Here avatar can be placed
        decoration: const BoxDecoration(
          color: Colors.purple,
          shape: BoxShape.circle,
        ),
        height: _interpolationEaseOutCubic(
          inputValue: shrinkOffset,
          start: _initialAvatarSize,
          end: _endAvatarSize,
        ),
        width: _interpolationEaseOutCubic(
          inputValue: shrinkOffset,
          start: _initialAvatarSize,
          end: _endAvatarSize,
        ),
      ),
    );
  }

  Widget _buildBackground(
    BuildContext context,
    double shrinkOffset,
    BoxConstraints constraints,
  ) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: constraints.maxHeight / 2,
          width: constraints.maxWidth,
          child: Opacity(
            opacity: _calculateOpacity(shrinkOffset, maxExtent / 3),
            child: Image.asset(
              backgroungImagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: constraints.maxHeight / 2,
        )
      ],
    );
  }

  /// Calculating opacity from 1 to 0, inputValue is an scroll offset and
  /// endValue max value when opacity should be 0
  double _calculateOpacity(
    double inputValue,
    double endValue,
  ) {
    return 1 - ((inputValue - endValue) / endValue).clamp(0, 1);
  }

  /// Calculating size of TextWidget
  Size _calculateTextSize(
    BuildContext context,
    String text,
    TextStyle textStyle,
  ) {
    return (TextPainter(
      text: TextSpan(text: text, style: textStyle),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;
  }

  /// Calculating interpolation with exponent if needed
  double _interpolationEaseOutCubic({
    required double inputValue,
    required double start,
    required double end,
    num exponent = 2,
  }) {
    final result = start +
        (1 - pow(1 - (inputValue / maxExtent), exponent)) * (end - start);
    return result;
  }

  @override
  double get maxExtent => mediaQueryData.size.height / 3;

  @override
  double get minExtent => kToolbarHeight + mediaQueryData.padding.top;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
