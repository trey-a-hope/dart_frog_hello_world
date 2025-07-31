// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/index.dart' as index;
import '../routes/echo/[message].dart' as echo_$message;
import '../routes/counter/counter.dart' as counter_counter;

import '../routes/counter/_middleware.dart' as counter_middleware;

void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(buildRootHandler()).handler;
  final server = await serve(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/counter', (context) => buildCounterHandler()(context))
    ..mount('/echo', (context) => buildEchoHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildCounterHandler() {
  final pipeline = const Pipeline().addMiddleware(counter_middleware.middleware);
  final router = Router()
    ..all('/counter', (context) => counter_counter.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildEchoHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/<message>', (context,message,) => echo_$message.onRequest(context,message,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}

