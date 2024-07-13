import 'package:flutter/material.dart';
import 'package:malltiverse/components/widgets/star_rating.dart';
import 'package:malltiverse/models/product.dart';

import '../colors.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final Function() onTap;
  const ProductTile({Key? key, required this.product, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1978,
                  width: MediaQuery.of(context).size.width * 0.42990,
                  color: grey,
                ),
                Positioned.fill(
                    child: Image.asset(
                  product.imageUrl,
                  alignment: Alignment.center,
                  scale: 1.2,
                ))
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: mainBlack),
                ),
                SizedBox(height: 8),
                Text(
                  product.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: mainBlack),
                ),
                SizedBox(height: 8),
                buildStarRating(product.rating),
              ],
            ),
            const SizedBox(height: 13),
            Text(
              product.displayPrice,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
            ),
            const SizedBox(height: 17),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: mainWhite,
                onPrimary: primaryColor,
                side: BorderSide(color: primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: mainBlack),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
