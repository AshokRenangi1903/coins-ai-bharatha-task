import 'package:flutter/material.dart';

class EachTile extends StatelessWidget {
  var s, p, c, tileColor;
  EachTile({super.key, this.c, this.p, this.s, this.tileColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: tileColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            s,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹ ' + c,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),

                // p  value
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    children: [
                      Icon(
                          (p[0] == '-')
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: p[0] == '-' ? Colors.red : Colors.green),
                      Text(
                        p[0] == '-' ? p.substring(1) + '%' : p + '%',
                        style: TextStyle(
                            color: p[0] == '-' ? Colors.red : Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
