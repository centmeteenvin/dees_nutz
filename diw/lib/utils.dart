import 'package:flutter/material.dart';

Future<T?> showProcessIndicatorWhileWaitingOnFuture<T>(BuildContext context, Future<T>? future) async {
  var futureValue;
  if (future == null) return null;
  await showDialog(
      context: context,
      builder: (context) => FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              futureValue = snapshot.data;
              Navigator.of(context).pop();
              return Container();
            },
          ));
  return futureValue;
}
