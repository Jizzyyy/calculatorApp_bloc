import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:starterproject_arkabloc/utils/themecubit.dart';
import 'package:starterproject_arkabloc/views/calcbloc/calcbloc_bloc.dart';
import 'package:starterproject_arkabloc/views/calcbloc/calcbloc_state.dart';
import 'package:starterproject_arkabloc/views/calcbloc/calcbloc_event.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String displayValue = "0";
    // final isDark = context.select((ThemeCubit c) => c.state);

    return Scaffold(
      backgroundColor: Color(0xFF6DD5C3),
      appBar: AppBar(
        title: const Text(
          "Bloc & Cubit Demo",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        // actions: [
        //   // Tombol Ganti Tema (CUBIT)
        //   IconButton(
        //     icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
        //     onPressed: () {
        //       // CUBIT: Langsung panggil fungsi
        //       context.read<ThemeCubit>().toggleTheme();
        //     },
        //   ),
        // ],
        backgroundColor: Color(0xFF6DD5C3),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Display area
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenHeight * 0.03,
              ),
              child: BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) {
                  if (state is CalculatorResult) {
                    displayValue = state.displayValue;
                  }
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      displayValue,
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                  );
                },
              ),
            ),
          ),
          // Operator buttons row
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: 8,
            ),
            child: BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                String activeOp = "";
                if (state is CalculatorResult) {
                  activeOp = state.activeOperator;
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOperatorButton(
                      context,
                      "+",
                      activeOp == "+",
                      screenWidth,
                    ),
                    _buildOperatorButton(
                      context,
                      "-",
                      activeOp == "-",
                      screenWidth,
                    ),
                    _buildOperatorButton(
                      context,
                      "x",
                      activeOp == "x",
                      screenWidth,
                    ),
                    _buildOperatorButton(
                      context,
                      "/",
                      activeOp == "/",
                      screenWidth,
                    ),
                  ],
                );
              },
            ),
          ),
          // Number pad
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNumberRow(context, ["7", "8", "9"], screenWidth),
                  _buildNumberRow(context, ["4", "5", "6"], screenWidth),
                  _buildNumberRow(context, ["1", "2", "3"], screenWidth),
                  _buildBottomRow(context, screenWidth),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperatorButton(
    BuildContext context,
    String operator,
    bool isActive,
    double screenWidth,
  ) {
    final buttonSize = screenWidth * 0.14;

    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF6DD5C3),
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(buttonSize / 2),
          onTap: () {
            context.read<CalculatorBloc>().add(OperatorPressed(operator));
          },
          child: Center(
            child: Text(
              operator,
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w300,
                color: isActive ? Color(0xFF6DD5C3) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberRow(
    BuildContext context,
    List<String> numbers,
    double screenWidth,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers
          .map((number) => _buildNumberButton(context, number, screenWidth))
          .toList(),
    );
  }

  Widget _buildBottomRow(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNumberButton(context, ".", screenWidth),
        _buildNumberButton(context, "0", screenWidth),
        _buildBackspaceButton(context, screenWidth),
        _buildClearButton(context, screenWidth),
        _buildEqualsButton(context, screenWidth),
      ],
    );
  }

  Widget _buildNumberButton(
    BuildContext context,
    String number,
    double screenWidth,
  ) {
    return InkWell(
      onTap: () {
        context.read<CalculatorBloc>().add(NumberPressed(number));
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: screenWidth * 0.15,
        height: screenWidth * 0.15,
        alignment: Alignment.center,
        child: Text(
          number,
          style: TextStyle(
            fontSize: screenWidth * 0.08,
            fontWeight: FontWeight.w300,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton(BuildContext context, double screenWidth) {
    return InkWell(
      onTap: () {
        context.read<CalculatorBloc>().add(BackspacePressed());
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: screenWidth * 0.15,
        height: screenWidth * 0.15,
        alignment: Alignment.center,
        child: Icon(
          Icons.backspace_outlined,
          size: screenWidth * 0.06,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildClearButton(BuildContext context, double screenWidth) {
    return InkWell(
      onTap: () {
        context.read<CalculatorBloc>().add(ClearPressed());
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: screenWidth * 0.15,
        height: screenWidth * 0.15,
        alignment: Alignment.center,
        child: Text(
          "ac",
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildEqualsButton(BuildContext context, double screenWidth) {
    return Container(
      width: screenWidth * 0.18,
      height: screenWidth * 0.15,
      decoration: BoxDecoration(
        color: Color(0xFF6DD5C3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            context.read<CalculatorBloc>().add(CalculateResult());
          },
          child: Center(
            child: Text(
              "=",
              style: TextStyle(
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
