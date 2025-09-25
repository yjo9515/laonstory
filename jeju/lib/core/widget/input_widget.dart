import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

class InputWidget extends StatelessWidget {

  const InputWidget({
    Key? key,
    this.controller,
    this.onFieldSubmitted,
    this.enabled = true,
    this.hint = '',
    this.onChange,
    this.onTap,
    this.errorWidget,
    this.label = '',
    this.suffixWidget,
    this.filled = true,
    this.labelSuffixWidget,
    this.format = TextInputType.text,
    this.dropdownWidget,
    this.onlySelect = false,
    this.helper = true,
    this.maxLength,
    this.price = false,
    this.nonePadding = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.count = false,
    this.textInputAction = TextInputAction.done,
    this.textAlign,
    this.initialValue,
    this.hintStyle,
    // this.inputFormat,
    this.children = const <Widget>[],
    this.suffix,
    this.inputTextStyle,
    this.showCursor = true,
    this.autofocus = false
  }) : super(key: key);




  final String label;
  final String hint;
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChange;
  final Function()? onTap;
  final bool enabled;
  final bool filled;
  final bool helper;
  final bool onlySelect;
  final Widget? errorWidget;
  final Widget? suffix;
  final Widget? suffixWidget;
  final Widget? labelSuffixWidget;
  final Widget? dropdownWidget;
  final TextInputType format;
  final int? maxLength;
  final bool price;
  final bool nonePadding;
  final int maxLines;
  final int minLines;
  final bool count;
  final TextInputAction textInputAction;
  final TextAlign? textAlign;
  final String? initialValue;
  final TextStyle? hintStyle;
  final List<Widget> children;
  final TextStyle? inputTextStyle;
  final bool showCursor;
  final bool autofocus;
  // final List<TextInputFormatter>? inputFormat;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: context.textTheme.krSubtitle1),
                labelSuffixWidget ?? Container(),
              ],
            ),
          ),
        Padding(
          padding: nonePadding ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (dropdownWidget != null)
                Row(
                  children: [
                    dropdownWidget!,
                    const SizedBox(width: 8),
                  ],
                ),
              if (children.isNotEmpty)
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 10,
                        children: children,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              if (!onlySelect && children.isEmpty && price == false)
                Expanded(
                  child: TextFormField(
                    showCursor: showCursor,
                    style: inputTextStyle,
                    initialValue: controller == null ? initialValue : null,
                    controller: controller,
                    textAlign: textAlign ?? FillTypes(format: format).align,
                    autofocus: autofocus,
                    keyboardType: FillTypes(format: format).keyboard,
                    textInputAction: textInputAction,
                    maxLines: maxLines,
                    minLines: minLines,
                    maxLength: maxLength,
                    enabled: enabled,
                    onFieldSubmitted: onFieldSubmitted,
                    autofillHints: [FillTypes(format: format).autofillHints ?? ''],
                    inputFormatters: FillTypes(format: format).inputFormat,
                    // inputFormatters: inputFormat,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {

                      return FillTypes(format: format).validator(value ?? '');
                    },
                    decoration: InputDecoration(
                        suffix: suffix,
                        filled: filled,
                        fillColor: enabled ? Theme.of(context).inputDecorationTheme.fillColor : context.colorScheme.disableButton,
                        hintText: hint,
                        suffixIcon: suffixWidget,
                        helperText: enabled && helper ? "" : null,
                        counterText: count ? null : "",
                        counterStyle: context.textTheme.krBody1.copyWith(color: black4),
                        hintStyle: hintStyle ?? Theme.of(context).inputDecorationTheme.hintStyle),
                    obscureText: FillTypes(format: format).isPassword,
                    onChanged: (text) {
                      onChange?.call(text);
                    },
                    onTap:() => onTap?.call()
                    ,
                    cursorColor: Theme.of(context).primaryColor,
                  ),
                ),
              if (!onlySelect && children.isEmpty && price)
                Expanded(
                  child: TextFormField(
                    showCursor: showCursor,
                    style: inputTextStyle,
                    initialValue: controller == null ? initialValue : null,
                    controller: controller,
                    textAlign: textAlign ?? FillTypes(format: format).align,
                    autofocus: autofocus,
                    keyboardType: FillTypes(format: format).keyboard,
                    textInputAction: textInputAction,
                    maxLines: maxLines,
                    minLines: minLines,
                    maxLength: maxLength,
                    enabled: enabled,
                    onFieldSubmitted: onFieldSubmitted,
                    autofillHints: [FillTypes(format: format).autofillHints ?? ''],
                    inputFormatters: FillTypes(format: format).inputFormat,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return FillTypes(format: format).validator(value ?? '');
                    },
                    decoration: InputDecoration(
                        suffixText: '원',
                        suffix: suffix,
                        filled: filled,
                        fillColor: enabled ? Theme.of(context).inputDecorationTheme.fillColor : context.colorScheme.disableButton,
                        hintText: hint,
                        suffixIcon: suffixWidget,
                        helperText: enabled && helper ? "" : null,
                        counterText: count ? null : "",
                        counterStyle: context.textTheme.krBody1.copyWith(color: black4),
                        hintStyle: hintStyle ?? Theme.of(context).inputDecorationTheme.hintStyle),
                    obscureText: FillTypes(format: format).isPassword,
                    onChanged: (text) {
                      onChange?.call(text);
                    },
                    onTap:() => onTap?.call()
                    ,
                    cursorColor: Theme.of(context).primaryColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
