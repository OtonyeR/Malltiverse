import 'package:flutter/material.dart';
import 'package:malltiverse/components/colors.dart';

class ProductAd extends StatelessWidget {
  const ProductAd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2481283,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(
              image: AssetImage('assets/#Headphones new collections 1.png'),
              fit: BoxFit.contain)),
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left: 26),
        child: Wrap(
          direction: Axis.vertical,
          spacing: 7,
          children: const [
            SizedBox(
              width: 221,
              height: 56,
              child: Text('Premium Sound, Premium Savings',
                  style: TextStyle(
                    fontSize: 18,
                    color: mainWhite,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Text('Limited offer, hope on and get yours now',
                style: TextStyle(
                  fontSize: 12,
                  color: mainWhite,
                  fontWeight: FontWeight.w500,
                ))
          ],
        ),
      ),
    );
  }
}
