import 'package:flutter/material.dart';

// Assuming product.rating is an integer between 0 and 5
Widget buildStarRating(int rating) {
  final Color colour = Color.fromRGBO(255, 198, 87, 1);
  if (rating == 5) {
    return Row(
        children: List.generate(
            rating,
            (index) => Icon(
                  Icons.star,
                  color: colour,
                  size: 16,
                )));
  } else {
    return Row(
      children: [
        ...List.generate(
            rating,
            (index) => Icon(
                  Icons.star,
                  color: colour,
                  size: 16,
                )),
        ...List.generate(
            5 - rating,
            (index) => Icon(
                  Icons.star_border,
                  color: colour,
                  size: 16,
                )),
      ],
    );
  }
}
