import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import '../../../core/core.dart';

part 'generated/search_state.g.dart';



@CopyWith()
class SearchState extends CommonState {
  const SearchState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.route,
    this.priceRange = const RangeValues(0, 1000000),
    this.themes = const {},
    this.select = const [],
    this.room = const Room(),
    this.range,
    this.address,
    this.floor,
    this.people = 1,
    this.checkIn,
    this.checkOut,
    this.selectTheme,
    this.searchList = const []
  });

  final RangeValues priceRange;
  final Map<String?, List<Facility>?> themes;
  final List<Facility> select;
  final Room room;
  final String? range;
  final String? address;
  final int people;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? floor;
  final Facility? selectTheme;
  final List<Room> searchList;

  @override
  List<Object?> get props => [...super.props, priceRange, themes, select, room, range, address, people, checkIn, checkOut, floor, selectTheme, searchList];
}
