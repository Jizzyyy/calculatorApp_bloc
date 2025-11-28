import 'package:bloc/bloc.dart';
import 'package:starterproject_arkabloc/views/calcbloc/index.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  String _displayValue = "0";
  String _operator = "";
  String _previousValue = "";
  String _currentOperator = ""; 
  bool _shouldResetDisplay = false; 

  CalculatorBloc() : super(CalculatorInitial()) {
    on<NumberPressed>(_onNumberPressed);
    on<OperatorPressed>(_onOperatorPressed);
    on<CalculateResult>(_onCalculateResult);
    on<ClearPressed>(_onClearPressed);
    on<BackspacePressed>(_onBackspacePressed);
  }

  void _onNumberPressed(NumberPressed event, Emitter<CalculatorState> emit) {
    // Handle decimal point
    if (event.number == ".") {
      if (_shouldResetDisplay) {
        _displayValue = "0.";
        _shouldResetDisplay = false;
      } else if (!_displayValue.contains(".")) {
        _displayValue += ".";
      }
    } else {
      // Handle regular numbers
      if (_shouldResetDisplay || _displayValue == "0" || _displayValue == "Error") {
        _displayValue = event.number;
        _shouldResetDisplay = false;
      } else {
        _displayValue += event.number;
      }
    }
    emit(CalculatorResult(_displayValue, _currentOperator));
  }

  void _onOperatorPressed(OperatorPressed event, Emitter<CalculatorState> emit) {
    // If there's a previous operation, calculate it first (chain operation)
    if (_operator.isNotEmpty && _previousValue.isNotEmpty && !_shouldResetDisplay) {
      _calculateAndUpdate();
    }

    _operator = event.operator;
    _currentOperator = event.operator;
    _previousValue = _displayValue;
    _shouldResetDisplay = true;
    
    emit(CalculatorResult(_displayValue, _currentOperator));
  }

  void _calculateAndUpdate() {
    try {
      double prev = double.parse(_previousValue);
      double current = double.parse(_displayValue);
      double result = 0;

      if (_operator == "+") {
        result = prev + current;
      } else if (_operator == "-") {
        result = prev - current;
      } else if (_operator == "x") {
        result = prev * current;
      } else if (_operator == "/") {
        if (current != 0) {
          result = prev / current;
        } else {
          _displayValue = "Error";
          return;
        }
      }

      // Format result to avoid unnecessary decimals
      if (result % 1 == 0) {
        _displayValue = result.toInt().toString();
      } else {
        _displayValue = result.toStringAsFixed(8);
        // Remove trailing zeros
        _displayValue = _displayValue.replaceAll(RegExp(r'0*$'), '');
        _displayValue = _displayValue.replaceAll(RegExp(r'\.$'), '');
      }
    } catch (e) {
      _displayValue = "Error";
    }
  }

  void _onCalculateResult(CalculateResult event, Emitter<CalculatorState> emit) {
    if (_previousValue.isEmpty || _operator.isEmpty) {
      emit(CalculatorResult(_displayValue, ""));
      return;
    }

    _calculateAndUpdate();
    
    _operator = "";
    _currentOperator = "";
    _previousValue = "";
    _shouldResetDisplay = true;
    
    emit(CalculatorResult(_displayValue, ""));
  }

  void _onClearPressed(ClearPressed event, Emitter<CalculatorState> emit) {
    _displayValue = "0";
    _operator = "";
    _currentOperator = "";
    _previousValue = "";
    _shouldResetDisplay = false;
    emit(CalculatorResult(_displayValue, ""));
  }

  void _onBackspacePressed(BackspacePressed event, Emitter<CalculatorState> emit) {
    if (_displayValue == "Error" || _displayValue == "0" || _shouldResetDisplay) {
      _displayValue = "0";
    } else if (_displayValue.length > 1) {
      _displayValue = _displayValue.substring(0, _displayValue.length - 1);
    } else {
      _displayValue = "0";
    }
    emit(CalculatorResult(_displayValue, _currentOperator));
  }
}

