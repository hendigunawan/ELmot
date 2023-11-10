import 'package:flutter/material.dart';
import 'package:online_trading/core/responsive/textsclae.dart';
import 'package:online_trading/helper/constant_style.dart';

class HeaderDesktop extends StatelessWidget {
  const HeaderDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top: size.height * 0.005,
        left: size.width * 0.01,
        right: size.width * 0.01,
      ),
      width: size.width * 1,
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Dashboard",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: ScaleSize.textScaleFactor(context) / 1.2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.only(
                      left: size.width * 0.005, right: size.width * 0.005),
                  width: size.width * 0.16,
                  height: size.height * 0.072,
                  decoration: BoxDecoration(
                      color: bgabu, borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: search,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.014,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            search.clear();
                          },
                          child: const Icon(
                            Icons.close,
                          ),
                        ),
                        border: InputBorder.none),
                  )),
              SizedBox(
                width: size.width * 0.01,
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: size.width * 0.015, right: size.width * 0.015),
                  width: size.width * 0.16,
                  height: size.height * 0.072,
                  decoration: BoxDecoration(
                      color: bgabu, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/facebook.png'),
                        radius: 15,
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
                        "Mr. Dayat",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor:
                            ScaleSize.textScaleFactor(context) / 1.5,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
