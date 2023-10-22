import 'dart:io';

import 'package:logger/logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

part 'server.g.dart';

final Logger logger= Logger(level: Level.info,);

class EchoService {
  Router get router => _$EchoServiceRouter(this);

  @Route.get('/')
  Future<Response> helloWorld(Request request) async {
    return Response.ok("HomePage");
  }

  @Route.get('/<foo>')
  Future<Response> echo(Request request, String foo) async {
    return Response.ok(foo);
  }
}

class WebHookService {
  Router get router => _$WebHookServiceRouter(this);

  @Route.post('/staging/webhook')
  Future<Response> echo(Request request) async {
    final body = await request.readAsString();
    logger.i(body);
    print(body);
    return Response.ok(body);
  }
}


void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(args[1]);
  final service = WebHookService();
  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(service.router);

  // For running in containers, we respect the PORT environment variable.
  final server = await serve(handler, ip, port);
  print('Listener Created on $ip:$port.');
}
