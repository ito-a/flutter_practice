import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    @Default('tarou') String name,
    @Default(0) int age,
  }) = _User;
}
