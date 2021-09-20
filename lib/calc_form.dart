import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:io" show Platform;
import "dart:math";

import 'package:flutter/rendering.dart';
import 'package:tbm_calculator/result.dart';

class CalcForm extends StatefulWidget {
  @override
  _CalcFormState createState() => _CalcFormState();
}

class _CalcFormState extends State<CalcForm> {
  final csfWbcController = TextEditingController();
  final csfGlucController = TextEditingController();
  final bloodGlucController = TextEditingController();
  bool cragStatus = false;
  bool feverStatus = false;
  bool hivStatus = false;

  int? selectedDiff = 0;

  bool result = false;

  Map patientData = {
    "wbc": 0,
    "diff": 0,
    "csfGluc": 0,
    "bloodGluc": 0,
    "crag": false,
    "fever": false,
    "hiv": false
  };

  double odds = 0;
  int prob = -1;

  DropdownButton androidDropdown() {
    return DropdownButton<int>(
      value: selectedDiff,
      items: <DropdownMenuItem<int>>[
        DropdownMenuItem(
          child: Text("No predominant cell type"),
          value: 0,
        ),
        DropdownMenuItem(
          child: Text("Neutrophilic"),
          value: 1,
        ),
        DropdownMenuItem(
          child: Text("Lymphocytic"),
          value: 2,
        ),
      ],
      onChanged: (value) {
        setState(() {
          selectedDiff = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [
      Text("No predominant cell type"),
      Text("Neutrophilic"),
      Text("Lymphocytic")
    ];
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedDiff = selectedIndex;
        });
      },
      children: pickerItems,
    );
  }

  void submittedData() {
    if (double.parse(csfWbcController.text) < 5) {
      patientData["wbc"] = 2.5 * (-0.0007810009);
    } else {
      patientData["wbc"] =
          double.parse(csfWbcController.text) * (-0.0007810009);
    }

    if (selectedDiff == 1) {
      patientData["diff"] = 1.51411468;
    } else if (selectedDiff == 2) {
      patientData["diff"] = 1.556377121;
    } else {
      patientData["diff"] = 0;
    }

    if (double.parse(csfGlucController.text) < 20) {
      patientData["csfGluc"] = 5.5 * (-0.0407057558);
    } else {
      patientData["csfGluc"] =
          double.parse(csfGlucController.text) * (-0.0407057558);
    }

    if (double.parse(bloodGlucController.text) < 11) {
      patientData["bloodGluc"] = 5.5 * (0.0060103239);
    } else {
      patientData["bloodGluc"] =
          double.parse(bloodGlucController.text) * (0.0060103239);
    }

    if (cragStatus == true) {
      patientData["crag"] = -3.502162269;
    } else {
      patientData["crag"] = 0;
    }

    if (feverStatus == true) {
      patientData["fever"] = 0.4718978543;
    } else {
      patientData["fever"] = 0;
    }

    if (hivStatus == true) {
      patientData["hiv"] = 0.1284248176;
    } else {
      patientData["hiv"] = 0;
    }

    print(patientData);

    odds = exp(patientData["wbc"] +
        patientData["diff"] +
        patientData["csfGluc"] +
        patientData["bloodGluc"] +
        patientData["crag"] +
        patientData["fever"] +
        patientData["hiv"] +
        (-0.6318415877));

    prob = (odds / (1 - odds) * 100).floor();
    print(prob);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("CSF WBC: ", style: TextStyle(fontSize: 16)),
              Container(
                width: 200,
                child: TextField(
                  controller: csfWbcController,
                  decoration: InputDecoration(
                      suffix: Text("cells/mm³"), hintText: "Enter CSF WBC"),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("CSF Differential: ", style: TextStyle(fontSize: 16)),
              Platform.isIOS ? iOSPicker() : androidDropdown(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("CSF Glucose: ", style: TextStyle(fontSize: 16)),
              Container(
                width: 200,
                child: TextField(
                  controller: csfGlucController,
                  decoration: InputDecoration(
                      suffix: Text("mg/dL"), hintText: "Enter WBC Glucose"),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Blood Glucose: ", style: TextStyle(fontSize: 16)),
              Container(
                width: 200,
                child: TextField(
                  controller: bloodGlucController,
                  decoration: InputDecoration(
                      suffix: Text("mg/dL"), hintText: "Enter Blood Glucose"),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Switch(
                    value: cragStatus,
                    activeTrackColor: Colors.redAccent,
                    activeColor: Color(0xFF7a0019),
                    onChanged: (value) {
                      setState(() {
                        cragStatus = !cragStatus;
                        print(cragStatus);
                      });
                    },
                  ),
                  Text("CSF CrAg Positive?"),
                ],
              ),
              Column(
                children: [
                  Switch(
                    value: feverStatus,
                    activeTrackColor: Colors.redAccent,
                    activeColor: Color(0xFF7a0019),
                    onChanged: (value) {
                      setState(() {
                        feverStatus = !feverStatus;
                        print(feverStatus);
                      });
                    },
                  ),
                  Text("Fever?"),
                ],
              ),
              Column(
                children: [
                  Switch(
                    value: hivStatus,
                    activeTrackColor: Colors.redAccent,
                    activeColor: Color(0xFF7a0019),
                    onChanged: (value) {
                      setState(() {
                        hivStatus = !hivStatus;
                        print(hivStatus);
                      });
                    },
                  ),
                  Text("HIV Positive?"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: submittedData,
            child: Text("CALCULATE"),
          ),
          Result(prob),
        ],
      ),
    );
  }
}
