import 'package:dart_frog/dart_frog.dart';

int _count = 0;

Handler middleware(Handler handler) {
  return (context) {
    _count++;
    return handler(context.provide<int>(() => _count));
  };
}
