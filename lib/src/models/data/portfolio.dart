import '../from_json.dart';
import 'portfolio_position.dart';

class Portfolio {
  final List<PortfolioPosition> positions;

  Portfolio(this.positions);

  factory Portfolio.fromJson(Map<String, dynamic> data) => Portfolio(
        listFromJson(data, 'positions', (d) => PortfolioPosition.fromJson(d)),
      );

  @override
  String toString() => 'Portfolio(positions: $positions)';
}
