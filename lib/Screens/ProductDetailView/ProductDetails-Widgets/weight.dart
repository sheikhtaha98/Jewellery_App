import 'package:flutter/material.dart';
import 'package:ui_project/Constants/colors.dart';

class Weight extends StatefulWidget {
  final List ItemDetails;
  const Weight({super.key, required this.ItemDetails});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  bool ShowDesc = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Weight',
                  style: TextStyle(
                      color: TextColors.textColor3,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 10,
                ),
                (!ShowDesc)
                    ? IconButton(
                        onPressed: () {
                          setState(
                            () {
                              ShowDesc = true;
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(
                            () {
                              ShowDesc = false;
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_drop_up,
                          size: 30,
                        ),
                      )
              ],
            ),
            (ShowDesc)
                ? Container(
                    width: 360,
                    height: 72,
                    child: Text(
                      widget.ItemDetails[0]['Weight'],
                      style: const TextStyle(
                          color: TextColors.textColor2,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                : Container(),
            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1,
              color: SecondaryColors.secondaryGrey00.withOpacity(0.8),
            ),
          ],
        ),
      ],
    );
  }
}
