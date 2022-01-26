class ResponseOb{
  MsgState? msgState;
  ErrState? errState;
  dynamic data;

  ResponseOb({this.msgState, this.errState, this.data});
}

enum MsgState{
  loading,
  data,
  error,
  other
}
enum ErrState{
  serverErr,
  notFoundErr,
  unknowErr
}