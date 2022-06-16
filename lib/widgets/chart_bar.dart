import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  const ChartBar({Key? key,required this.label,required this.spendingAmount,required this.spendingPctOfTotal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // ignore: sized_box_for_whitespace
      Container(
        height: 20,
        child: FittedBox(child: Text('\$${spendingAmount == 0 ? 0 :spendingAmount.toStringAsFixed(2)}'))),
      const SizedBox(height: 4,),
      // ignore: sized_box_for_whitespace
      Container(
        height: 60,
        width: 10,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,width: 1.0),
              color: const Color.fromRGBO(220, 220, 220, 1),
              borderRadius: BorderRadius.circular(10)
            ),
          ),
          FractionallySizedBox(
            heightFactor: spendingPctOfTotal,
            child: Container(
              decoration: BoxDecoration(
                color:  Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          )
        ],),
      ),
      const SizedBox(height:4),
      Text(label)
    ],);
  }
}