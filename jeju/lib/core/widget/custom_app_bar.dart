import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.backButton = false,
    this.onBack,
    this.textTitle,
    this.actions = const [],
    this.bottom,
    this.widgetTitle,
    this.leadingAction,
    this.color,
    this.tag,
  }) : super();

  final bool backButton;
  final Function()? onBack;
  final String? textTitle;
  final List<Widget> actions;
  final Widget? leadingAction;
  final Widget? widgetTitle;
  final PreferredSizeWidget? bottom;
  final Color? color;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return tag == null
        ? AppBar(
            bottom: bottom,
            elevation: 0,
            leadingWidth: 64,
            leading: leadingAction ??
                (backButton
                    ? Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: IconButton(
                            splashRadius: 24,
                            onPressed: () {
                              onBack?.call();
                              FocusManager.instance.primaryFocus?.unfocus();
                              context.pop();
                            },
                            icon: const SvgImage('assets/icons/ic_arrow_back.svg')))
                    : Container()),
            title: widgetTitle ??
                (textTitle != null
                    ? Text(textTitle!, style: context.textTheme.krSubtitle1)
                    : const Hero(
                        tag: 'logo',
                        child: SvgImage(
                          "assets/icons/ic_logo_horizontal.svg",
                          height: 57,
                        ),
                      )),
            centerTitle: true,
            actions: actions,
            backgroundColor: color ?? Theme.of(context).appBarTheme.backgroundColor)
        : Hero(
            tag: tag!,
            child: AppBar(
                bottom: bottom,
                elevation: 0,
                leadingWidth: 64,
                leading: leadingAction ??
                    (backButton
                        ? Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: IconButton(
                                splashRadius: 24,
                                onPressed: () {
                                  onBack?.call();
                                  context.pop();
                                },
                                icon: const SvgImage('assets/icons/ic_arrow_back.svg')))
                        : Container()),
                title: widgetTitle ??
                    (textTitle != null
                        ? Text(textTitle!, style: context.textTheme.krSubtitle1)
                        : const Hero(
                            tag: 'logo',
                            child: SvgImage(
                              "assets/images/logo_image.svg",
                              height: 57,
                            ),
                          )),
                centerTitle: true,
                actions: actions,
                backgroundColor: color ?? Theme.of(context).appBarTheme.backgroundColor),
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
