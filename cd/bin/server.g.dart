// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$EchoServiceRouter(EchoService service) {
  final router = Router();
  router.add(
    'GET',
    r'/',
    service.helloWorld,
  );
  router.add(
    'GET',
    r'/<foo>',
    service.echo,
  );
  return router;
}

Router _$WebHookServiceRouter(WebHookService service) {
  final router = Router();
  router.add(
    'POST',
    r'/staging/webhook',
    service.echo,
  );
  return router;
}
