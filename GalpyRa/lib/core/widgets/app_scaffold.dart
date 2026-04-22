import 'package:flutter/material.dart';
import '../../config/theme/colors.dart';

/// Base scaffold widget with common app structure
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.backgroundColor,
    this.showBackButton = true,
    this.centerTitle = true,
    this.resizeToAvoidBottomInset = true,
    this.appBarElevation = 0,
    this.onBackPressed,
    this.useGradientAppBar = false,
  });

  final Widget body;
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Color? backgroundColor;
  final bool showBackButton;
  final bool centerTitle;
  final bool resizeToAvoidBottomInset;
  final double appBarElevation;
  final VoidCallback? onBackPressed;
  final bool useGradientAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: title != null || titleWidget != null
          ? _buildAppBar(context)
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    if (useGradientAppBar) {
      return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
          ),
          child: AppBar(
            title: titleWidget ?? Text(title!),
            centerTitle: centerTitle,
            elevation: appBarElevation,
            backgroundColor: Colors.transparent,
            actions: actions,
            leading: leading ??
                (showBackButton && Navigator.canPop(context)
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: onBackPressed ?? () => Navigator.pop(context),
                      )
                    : null),
          ),
        ),
      );
    }

    return AppBar(
      title: titleWidget ?? Text(title!),
      centerTitle: centerTitle,
      elevation: appBarElevation,
      actions: actions,
      leading: leading ??
          (showBackButton && Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: onBackPressed ?? () => Navigator.pop(context),
                )
              : null),
    );
  }
}
