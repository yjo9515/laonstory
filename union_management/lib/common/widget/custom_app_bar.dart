import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.backButton, this.onBack, this.textTitle, this.actions, this.bottom, this.widgetTitle, this.leadingAction, this.color, this.divider = true}) : super();

  final bool? backButton;
  final Function()? onBack;
  final String? textTitle;
  final List<Widget>? actions;
  final Widget? leadingAction;
  final Widget? widgetTitle;
  final PreferredSizeWidget? bottom;
  final Color? color;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
            bottom: bottom,
            elevation: 0,
            leading: leadingAction ??
                (backButton ?? false ? IconButton(splashRadius: 24, onPressed: onBack, icon: const Icon(Icons.arrow_back_ios_new), color: Theme.of(context).appBarTheme.foregroundColor) : Container()),
            title: widgetTitle ??
                (textTitle != null
                    ? Text(textTitle!)
                    : Hero(
                        tag: 'title',
                        child: SvgPicture.asset(
                          "assets/icons/title_icon.svg",
                          height: 16,
                        ),
                      )),
            centerTitle: true,
            actions: actions,
            backgroundColor: color ?? Theme.of(context).appBarTheme.backgroundColor),
        if (divider) Divider(height: 1, thickness: 1, color: Theme.of(context).dividerColor),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (divider ? 1 : 0));
}
