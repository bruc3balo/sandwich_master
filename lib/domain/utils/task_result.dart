sealed class TaskResult<T> {}

class Success<T> extends TaskResult<T> {
  final T data;
  final String message;

  const Success({required this.data, this.message = 'Success'});
}

class Failure<T> extends TaskResult<T> {
  final String message;
  final dynamic trace;

  const Failure({required this.message, this.trace});
}
