import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_static_utility/flutter_static_utility.dart';

import '../style.dart';

class EditTextFieldWidget extends StatelessWidget {
  const EditTextFieldWidget({
    Key? key,
    this.hint = "",
    this.label = "",
    this.isPassword = false,
    this.isPhone = false,
    this.isCode = false,
    this.controller,
    this.max,
    this.enabled = true,
    this.isNumber = false,
    this.regexPassword = true,
    this.onChange,
    this.onClick,
    this.focusNode,
    this.errorWidget,
    this.suffixWidget,
    this.onFieldSubmitted,
    this.subLabelWidget,
    this.isEmail = false,
    this.noneBorder = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputAction = TextInputAction.done,
    this.textColor = black,
    this.fillColor,
    this.isUserId = false,
    this.fill = true,
  }) : super(key: key);

  final String hint;
  final String label;
  final FocusNode? focusNode;
  final int maxLines;
  final int minLines;
  final int? max;
  final bool enabled;
  final bool isPassword;
  final bool isNumber;
  final bool isPhone;
  final bool isEmail;
  final bool isCode;
  final bool noneBorder;
  final bool regexPassword;
  final bool isUserId;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String)? onClick;
  final Function(String)? onFieldSubmitted;
  final Widget? suffixWidget;
  final Widget? errorWidget;
  final Widget? subLabelWidget;
  final Color textColor;
  final Color? fillColor;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      label,
                      style: enabled ? textTheme(context).krBody1.copyWith(color: textColor) : textTheme(context).krBody1.copyWith(color: gray1),
                    ),
                  ),
                  const Spacer(),
                  Container(margin: const EdgeInsets.only(bottom: 16), child: subLabelWidget)
                ],
              ),
        GestureDetector(
          onTap: () {
            if (onClick != null) {
              onClick!(controller?.text ?? "");
            }
            return;
          },
          child: TextFormField(
            focusNode: focusNode ?? FocusNode(),
            autofocus: false,
            autofillHints: getAutoFillHints(isPhone, isEmail, isPassword, isUserId),
            keyboardType: isPhone || isNumber
                ? TextInputType.number
                : isEmail
                    ? TextInputType.emailAddress
                    : maxLines > 1
                        ? TextInputType.multiline
                        : TextInputType.text,
            textInputAction: textInputAction,
            maxLength: max,
            maxLines: maxLines,
            minLines: minLines,
            enabled: enabled,
            controller: controller,
            onFieldSubmitted: onFieldSubmitted,
            inputFormatters: [
              if (isNumber) FilteringTextInputFormatter.digitsOnly,
              if (isPhone) MultiMaskedTextInputFormatter(masks: ['xxx-xxxx-xxxx', 'xxx-xxx-xxxx'], separator: '-')
            ],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) return null;
              if (isEmail && !checkEmailRegex(email: value)) return '이메일 형식을 확인해주세요';
              if (isCode && !checkSMSCodeRegex(code: value, length: 6)) return '6자리의 숫자를 입력해주세요 ';
              if (isPassword && !checkPasswordRegex(password: value, min: 8, max: 20) && regexPassword) return '8자 이상의 대소문자 영문, 숫자, 특수문자를 포함해주세요';
              // if (isNumber && !checkSMSCodeRegex(code: value, length: 10)) return '10자의 숫자를 입력해주세요.';
              return null;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: gray5, width: noneBorder ? 0.0 : 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: noneBorder ? white.withOpacity(0) : gray5, width: noneBorder ? 0.0 : 1.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: gray7, width: noneBorder ? 0.0 : 1.0),
              ),
              fillColor: enabled ? fillColor : gray7,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: noneBorder ? white : Theme.of(context).primaryColor, width: 1.0),
              ),
              errorStyle: textTheme(context).krSubtext1.copyWith(color: Colors.red),
              hintText: hint,
              filled:  fillColor == null ? !enabled : true,
              counterText: "",
              suffixIcon: suffixWidget,
              hintStyle: textTheme(context).krBody1.copyWith(color: enabled ? textColor : black),
            ),
            obscureText: isPassword,
            enableSuggestions: true,
            autocorrect: !isPassword,
            onChanged: (text) {
              if (onChange != null) {
                onChange!(text);
              }
            },
            style: textTheme(context).krBody1.copyWith(color: enabled ? textColor : gray1),
            cursorColor: textColor,
          ),
        ),
        errorWidget ?? Container(),
      ],
    );
  }

  getAutoFillHints(bool isPhone, bool isEmail, bool isPassword, bool isUserId) {
    if (isPhone) {
      return [AutofillHints.telephoneNumber];
    } else if (isEmail) {
      return [AutofillHints.email];
    } else if (isPassword) {
      return [AutofillHints.password];
    } else if (isCode) {
      return [AutofillHints.oneTimeCode];
    } else if (isUserId) {
      return [AutofillHints.username];
    }
  }
}

class MultiMaskedTextInputFormatter extends TextInputFormatter {
  late List<String> _masks;
  late String _separator;
  String? _prevMask;

  MultiMaskedTextInputFormatter({required List<String> masks, required String separator}) {
    _separator = (separator.isNotEmpty) ? separator : '';

    if (masks.isNotEmpty) {
      _masks = masks;
      _masks.sort((l, r) => l.length.compareTo(r.length));
      _prevMask = masks[0];
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    final oldText = oldValue.text;

    if (newText.isEmpty || newText.length < oldText.length) {
      return newValue;
    }

    final pasted = (newText.length - oldText.length).abs() > 1;
    final mask = _masks.firstWhere((value) {
      final maskValue = pasted ? value.replaceAll(_separator, '') : value;
      return newText.length <= maskValue.length;
    }, orElse: () => '');

    if (mask.isEmpty) {
      return oldValue;
    }

    final needReset = (_prevMask != mask || newText.length - oldText.length > 1);
    _prevMask = mask;

    if (needReset) {
      final text = newText.replaceAll(_separator, '');
      String resetValue = '';
      int sep = 0;

      for (int i = 0; i < text.length; i++) {
        if (mask[i + sep] == _separator) {
          resetValue += _separator;
          ++sep;
        }
        resetValue += text[i];
      }

      return TextEditingValue(
        text: resetValue,
        selection: TextSelection.collapsed(offset: resetValue.length),
      );
    }

    if (newText.length < mask.length && mask[newText.length - 1] == _separator) {
      final text = '$oldText$_separator${newText.substring(newText.length - 1)}';
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }

    return newValue;
  }
}
