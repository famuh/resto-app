import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  String menuName;

  MenuItem({Key? key, required this.menuName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(153, 196, 196, 196),
                      // border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Text(
                    menuName,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ));
           
  }
}
