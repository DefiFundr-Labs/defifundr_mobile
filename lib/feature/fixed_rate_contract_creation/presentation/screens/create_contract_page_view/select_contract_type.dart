import 'package:defifundr_mobile/core/shared/buttons/custom_radio_button.dart';
import 'package:flutter/material.dart';

class SelectContractTypeScreen extends StatefulWidget {
  const SelectContractTypeScreen({super.key});

  @override
  State<SelectContractTypeScreen> createState() => _SelectContractTypeState();
}

class _SelectContractTypeState extends State<SelectContractTypeScreen> {
  ContractType? selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            CustomRadioButton(
              label: "Fixed rate",
              subLabel:
                  "For contracts that have a fixed rate each payment cycle.",
              value: ContractType.fixed_rate,
              groupValue: selected,
              onChanged: (value) {
                setState(() {
                  selected = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomRadioButton(
              label: "Pay as you go",
              subLabel:
                  "For contracts that require time sheets or work submissions each payment cycle.",
              value: ContractType.pay_as_you_go,
              groupValue: selected,
              onChanged: (value) {
                setState(() {
                  selected = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomRadioButton(
              label: "Milestone",
              subLabel:
                  "For contracts with milestones that get paid each time they're completed.",
              value: ContractType.milestone,
              groupValue: selected,
              onChanged: (value) {
                setState(() {
                  selected = value;
                });
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

enum ContractType { fixed_rate, pay_as_you_go, milestone }
