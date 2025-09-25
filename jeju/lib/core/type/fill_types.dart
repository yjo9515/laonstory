import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_static_utility/flutter_static_utility.dart';

class NewTextInputType implements TextInputType {
  const NewTextInputType.numberWithOptions({
    this.signed = false,
    this.decimal = false,
  }) : index = 2;

  const NewTextInputType.customNumberWithOptions(
    this.index, {
    this.signed = false,
    this.decimal = false,
  });

  @override
  final int index;

  @override
  final bool? signed;

  @override
  final bool? decimal;

  static const NewTextInputType price = NewTextInputType.numberWithOptions(decimal: false);
  static const NewTextInputType under = NewTextInputType.numberWithOptions(decimal: true);
  static const NewTextInputType code = NewTextInputType.numberWithOptions(signed: true, decimal: false);
  static const NewTextInputType percent = NewTextInputType.numberWithOptions(signed: true, decimal: false);
  static const NewTextInputType accountNumber = NewTextInputType.customNumberWithOptions(11, signed: false, decimal: false);

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}

class FillTypes {
  final TextInputType format;

  const FillTypes({required this.format});

  String? get autofillHints => switch (format) {
        TextInputType.name => AutofillHints.name,
        TextInputType.phone => AutofillHints.telephoneNumber,
        TextInputType.emailAddress => AutofillHints.email,
        TextInputType.visiblePassword => AutofillHints.password,
        NewTextInputType.code => AutofillHints.oneTimeCode,
        _ => null,
      };

  List<TextInputFormatter> get inputFormat => switch (format) {
        TextInputType.phone => [
            MultiMaskedTextInputFormatter(masks: ['xxx-xxxx-xxxx', 'xxx-xxx-xxxx'], separator: '-')
          ],
        NewTextInputType.price => [
            CurrencyTextInputFormatter(
              locale: 'ko',
              decimalDigits: 0,
              symbol: '',
            )
          ],
        NewTextInputType.percent => [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
        _ => [],
      };

  bool get isPassword => switch (format) {
        TextInputType.visiblePassword => true,
        _ => false,
      };

  String? validator(String value) {
    if (value.isEmpty) return null;
    switch (format) {
      case TextInputType.emailAddress:
        if (!checkEmailRegex(email: value)) {
          return '이메일 형식이 올바르지 않습니다.';
        } else {
          return null;
        }
      case TextInputType.visiblePassword:
        if (!checkPasswordRegex(password: value, min: 8, max: 20)) {
          return '비밀번호 형식이 올바르지 않습니다.';
        } else {
          return null;
        }

      case NewTextInputType.percent:
        if (int.parse(value) > 100) {
          return '100 이하의 숫자를 입력해주세요.';
        } else {
          return null;
        }
      default:
        return null;
    }
  }

  TextAlign get align => switch (format) {
        TextInputType.number || NewTextInputType.price || NewTextInputType.under || NewTextInputType.percent => TextAlign.right,
        _ => TextAlign.left,
      };

  TextInputType get keyboard => switch (format) {
        NewTextInputType.accountNumber => TextInputType.number,
        _ => format,
      };
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
