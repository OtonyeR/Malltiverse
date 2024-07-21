import 'package:flutter/material.dart';

// Assuming product.rating is an integer between 0 and 5
Widget buildStarRating(String rating) {
  final Color colour = Color.fromRGBO(255, 198, 87, 1);
  int ratingNumber = int.parse(rating).toInt();
  if (ratingNumber == 5) {
    return Row(
        children: List.generate(
            ratingNumber,
            (index) => Icon(
                  Icons.star,
                  color: colour,
                  size: 16,
                )));
  } else {
    return Row(
      children: [
        ...List.generate(
            ratingNumber,
            (index) => Icon(
                  Icons.star,
                  color: colour,
                  size: 16,
                )),
        ...List.generate(
            5 - ratingNumber,
            (index) => Icon(
                  Icons.star_border,
                  color: colour,
                  size: 16,
                )),
      ],
    );
  }
}
