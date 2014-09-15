library cloudy;

import 'dart:collection';
import 'dart:convert';
import 'dart:async';
import 'package:hub/hub.dart';
import 'package:dispatch/dispatch.dart';
import 'package:route/client.dart';
import 'dart:html';

part 'base.dart';
 
Function navigatePage(String path,String title){
  if(!window.history.supportsState){
      window.location.assign(path);
      (window.document as HtmlDocument).title = title;
  } else {
    window.history.pushState(null, title, path);
  }
};

class CloudyHistoryNotifier extends HistoryNotifier{
  Router interRouter;

  CloudyHistoryNotifier(): super(){
    this.interRouter =  new Router();
  };

  void _handleInternal(url,Function handler){
    this.interRouter.addHandler(url,handler);
  }

  Future boot(){
    return super.boot().then((){
      this.interRouter.listen();
    });
  }

}
