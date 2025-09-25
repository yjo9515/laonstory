part of 'mypage_bloc.dart';

class MypageEvent extends CommonEvent {
  const MypageEvent();
}

class PickImage extends MypageEvent {
   PickImage({required this.source, required this.userType});

   final ImageSource source;
   final UserType userType;
}