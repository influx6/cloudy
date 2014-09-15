part of cloudy;

abstract class HistoryNotifier{
  final Distributor delegate = Distributor.create('new-notifies');
  Switch _active;

  HistoryNotifier(){
    this._active = Switch.create();
    this._active.switchOn();
  }

  bool get isActive => this._active.on();

  void register(UrlPattern url,String shoutId){
    this._handleInternal(url,(path){
      if(!this.isActive) return null;
      this.delegate.emit({
        'url':url,
        'path': path,
        'parsed': url.parse(path),
        'message': shoutId
      });
    });
  }

  void _handleInternal(url,Function n);

  Future boot(){
    return new Future((){
      this._active.switchOn();
    });
  }

  Future shutdown(){
    return new Future((){
      this._active.switchOff();
    });
  }

  void bind(Function n) => this.delegate.on(n)
  void bindOnce(Function n); => this.delegate.onOnce(n);
  void unbind(Function n) => this.delegate.off(n);
  void unbindOnce(Function n) => this.delegate.offOnce(n);

}

class CloudyHistory extends Dispatcher{
  AtomicMap history;
  HistoryNotifier notifier;
  List _recents;
  int _curpos = -1;

  CloudyHistory([this.notifier]){
    this.history = AtomicMap.create();
    this._recents = new List();
    this.notifier.bind(this._recents.add);
    this.notifier.bind(this._delegateNotices);
  }

  void _delegateNotices(m){
    this.dispatch(m);
  }

  dynamic push(String key,String path){
    this.history.update(key,path);
    this.notifier.register(key,)
  }

  dynamic unpush(String key){
    return this.destroy(key);
  }

  Map get last => Enums.last(this._recents);
  Map get first => Enums.first(this._recents);
  Map get nth(int n) => Enums.nth(this._recents,n);

  Map get cur([int i]){
    i = Funcs.switchUnless(i,0);
    if(Valids.match(this._curpos,-1)){
      this._curpos = this._recents.length - 1;
      this_cursor += i;
      return this._recents[curpos];
    }

    var rs = this._curpos + i;
    if(rs <= 0){
      this._curpos = 0;
      return this.first;
    }
    if(rs >= this.length){
      this._curpos = this.length - 1;
      return this.last;
    }

    return this._recents[rs];
  }

  Map get next => this.cur(1);
  Map get prev => this.cur(-1);
}

class CloudyPages extends Dispatcher{

}

class CloudyPage{

}
