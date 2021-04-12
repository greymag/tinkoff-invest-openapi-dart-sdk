import '../from_json.dart';
import 'operation.dart';

class Operations {
  final List<Operation> operations;

  Operations(this.operations);

  factory Operations.fromJson(Map<String, dynamic> map) {
    return Operations(
      map.requireList('operations', (d) => Operation.fromJson(d)),
    );
  }

  @override
  String toString() => 'Operations(operations: $operations)';
}
