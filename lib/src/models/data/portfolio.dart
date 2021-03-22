import 'portfolio_position.dart';

class Portfolio {
  final List<PortfolioPosition> positions;

  Portfolio(this.positions);

  factory Portfolio.fromJson(Map<String, dynamic> data) => Portfolio(
        (data['positions'] as List)
            .cast<Map<String, dynamic>>()
            .map((d) => PortfolioPosition.fromJson(d))
            .toList(),
      );

  @override
  String toString() => 'Portfolio(positions: $positions)';
}
