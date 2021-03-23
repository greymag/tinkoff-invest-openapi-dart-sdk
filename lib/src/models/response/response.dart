abstract class Response {
  final String trackingId;
  final String status;

  const Response(this.trackingId, this.status);
}

abstract class StdResponse<T> extends Response {
  final T payload;

  const StdResponse(String trackingId, String status, this.payload)
      : super(trackingId, status);
}
