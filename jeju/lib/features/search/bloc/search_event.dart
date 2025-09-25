import 'package:flutter/material.dart';

import '../../../core/core.dart';

class SearchEvent extends CommonEvent {
  const SearchEvent();
}

class ChangeRange extends SearchEvent {
  const ChangeRange(this.range);

  final RangeValues range;
}

class SelectRange extends SearchEvent {
  const SelectRange({this.range});

  final String? range;
}

class SelectAddress extends SearchEvent {
  const SelectAddress({this.address});

  final String? address;
}

class SelectCount extends SearchEvent {
  const SelectCount({this.count});

  final int? count;
}

class SelectFloor extends SearchEvent {
  const SelectFloor({this.floor});

  final String? floor;
}

class SelectDate extends SearchEvent {
  const SelectDate({this.date,this.type});
  final DateTime? date;
  final int? type;

}

class SelectTheme extends SearchEvent {
  // const SelectTheme(this.select, {this.facility, this.theme,});
  const SelectTheme( {this.theme});

  // final Map<String?, List<Facility>?> themes;
  // final bool select;
  // final Facility? facility;
  final Facility? theme;
}

class SearchRoom extends SearchEvent {
  SearchRoom({this.body,});
  Map<String, dynamic>? body;
}
