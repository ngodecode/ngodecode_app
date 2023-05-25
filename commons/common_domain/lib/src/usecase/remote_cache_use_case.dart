import 'use_case.dart';

abstract class RemoteCacheUseCase<P, R> extends UseCase {

  Future<R> call(P param) async {
    return onSave(await onCall(param));
  }

  Future<R> onCall(P param);

  Future<R> onSave(R result);

}