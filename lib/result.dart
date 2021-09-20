import "package:flutter/material.dart";

class Result extends StatelessWidget {
  final prob;

  Result(this.prob);

  @override
  Widget build(BuildContext context) {
    if (prob < 0) {
      return Card(
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Probability of TBM: --%"),
              Text("Enter patient data above"),
            ],
          ),
        ),
      );
    } else if (prob <= 5) {
      return Card(
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Probability of TBM: ${prob}%"),
              Text(
                  "Very unlikely to be TB meningitis. Consider another diagnosis in your differential."),
            ],
          ),
        ),
      );
    } else if (prob > 5 && prob < 40) {
      return Card(
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Probability of TBM: ${prob}%"),
              Text(
                  "Possible TB meningitis. Consider further diagnostic testing."),
            ],
          ),
        ),
      );
    } else {
      return Card(
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Probability of TBM: ${prob}%"),
              Text(
                  "Likely TB meningitis. Consider initiating appropriate therapy"),
            ],
          ),
        ),
      );
    }
  }
}
