import 'package:equatable/equatable.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class CalculatorResult extends CalculatorState {
  final String displayValue;
  final String activeOperator;

  const CalculatorResult(this.displayValue, [this.activeOperator = ""]);

  @override
  List<Object> get props => [displayValue, activeOperator];
}
