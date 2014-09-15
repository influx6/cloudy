library cloudy;

import 'dart:collection';
import 'dart:convert';
import 'dart:async';
import 'package:hub/hub.dart';
import 'package:dispatch/dispatch.dart';
import 'package:route/server.dart';

part 'base.dart';

class CloudyHistoryNotifier extends HistoryNotifier{
  final HttpServer server;
  Router interRouter;

  CloudyHistoryNotifier(this.server): super(){
    this.interRouter =  new Router(s);
  }

  bool get isActive => this._active.on();

  void _handleInternal(url,Function handler){
    this.interRouter.serve(url).listen(handler);
  }

}
