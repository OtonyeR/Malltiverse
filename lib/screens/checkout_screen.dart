import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malltiverse/components/colors.dart';
import 'package:malltiverse/providers/history_provider.dart';
import 'package:malltiverse/screens/nav_screen.dart';
import 'dart:math';

import '../models/order_item.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class CheckOutScreen extends ConsumerStatefulWidget {
  const CheckOutScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends ConsumerState<CheckOutScreen> {
  final Random random = Random();

  final PageController _checkoutController = PageController();

  //Form Keys
  final _formKeyDelivery =
      GlobalKey<FormState>(); //Delivery Details Page Form key
  final _formKeyPayment =
      GlobalKey<FormState>(); //Payment details page form key

  TextEditingController deliveryAddress = TextEditingController();
  List<TextEditingController> phoneNumber =
      List.generate(2, (index) => TextEditingController());

  FocusNode deliveryFieldFocus = FocusNode();

  String? _selectedPickup;

  String deliveryDetails = '';
  String contactDetails = '';
  String paymentDetails = '';
  String subTotal = '';
  int discount = 0;
  String delivery = '';
  String total = '';
  int deliveryFee = 1500;
  String itemNumber = '';
  List<String> contacts = [];

  @override
  Widget build(BuildContext context) {
    discount = ref.watch(cartProvider.notifier).discountAmount;

    return Scaffold(
      backgroundColor: mainWhite,
      body: SafeArea(
        child: PageView(
          controller: _checkoutController,
          physics:
              const NeverScrollableScrollPhysics(), // To disable manual swiping
          children: [
            _buildCheckOutPage(),
            _buildPayPage(context),
            _buildConfirmScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckOutPage() {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainWhite,
        leading: Container(
            margin: const EdgeInsets.only(left: 24),
            child: Image.asset('assets/Malltiverse Logo.png')),
        leadingWidth: 105,
        title: const Text(
          'Checkout',
          style: TextStyle(color: mainBlack),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKeyDelivery,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select how to receive your package(s)',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: mainBlack,
                    ),
                  ),
                  const SizedBox(height: 21),
                  (deliveryAddress.text.isNotEmpty ||
                          deliveryFieldFocus.hasFocus == true)
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pickup',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Radio<String>(
                                    value:
                                        'Old Secretariat Complex, Area 1, Garki Abuja, FCT',
                                    groupValue: _selectedPickup,
                                    activeColor: primaryColor,
                                    toggleable: true,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedPickup = value;
                                      });
                                      if (_selectedPickup != null) {
                                        delivery = 'Pick Up';
                                        deliveryDetails = value.toString();
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'Old Secretariat Complex, Area 1, Garki Abuja, FCT',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Radio<String>(
                                    value:
                                        'Sokoto Street, Area 1, Garki Area 1 AMAC',
                                    groupValue: _selectedPickup,
                                    activeColor: primaryColor,
                                    toggleable: true,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedPickup = value;
                                      });
                                      if (_selectedPickup != null) {
                                        delivery = 'Pick Up';
                                        deliveryDetails = value.toString();
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'Sokoto Street, Area 1, Garki Area 1 AMAC',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  const SizedBox(height: 24),
                  if (_selectedPickup == null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: deliveryAddress,
                          focusNode: deliveryFieldFocus,
                          cursorColor: primaryColor,
                          onTap: () {
                            deliveryFieldFocus.hasFocus;
                            delivery = 'Delivery';
                          },
                          onSaved: (value) =>
                              deliveryDetails = deliveryAddress.text,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: const BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: BorderSide(
                                color: mainBlack.withOpacity(0.7),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a delivery address';
                            }
                            if (value.length < 10) {
                              return 'Please make sure the delivery address is accurate';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.579439,
                        child: TextFormField(
                          controller: phoneNumber[0],
                          cursorColor: primaryColor,
                          onSaved: (value) =>
                              contacts.add(phoneNumber[0].toString()),
                          decoration: InputDecoration(
                            hintText: 'Phone no. 1',
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: const BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: BorderSide(
                                color: mainBlack.withOpacity(0.7),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.579439,
                        child: TextFormField(
                          controller: phoneNumber[1],
                          cursorColor: primaryColor,
                          onSaved: (value) =>
                              contacts.add(phoneNumber[1].toString()),
                          decoration: InputDecoration(
                            hintText: 'Phone no. 2',
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: const BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: BorderSide(
                                color: mainBlack.withOpacity(0.7),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.71728971,
                      child: ElevatedButton(
                        onPressed: () {
                          if (cartItems.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Your Cart is Empty!'),
                              ),
                            );
                          } else if (_formKeyDelivery.currentState
                                  ?.validate() ??
                              false) {
                            _checkoutController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Proceed To Payment',
                          style: TextStyle(
                            fontSize: 12,
                            color: mainBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPayPage(BuildContext context) {
    final cartItems = ref.read(cartProvider.notifier).state;
    final List<Product> orderProducts = cartItems;
    final cartNotifier = ref.read(cartProvider.notifier);
    final historyNotifier = ref.read(orderHistoryProvider.notifier);
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: mainWhite,
            leading: IconButton(
              onPressed: () {
                _checkoutController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: mainBlack,
              ),
            ),
            title: const Text(
              'Payment',
              style: TextStyle(color: mainBlack),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: 217, child: Image.asset('assets/Card.png')),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Form(
                        key: _formKeyPayment,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Card Number',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '0000 0000 0000 0000',
                                hintStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: BorderSide(
                                    color: mainBlack.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter card number';
                                }

                                final RegExp regex =
                                    RegExp(r'^\d{4}\s\d{4}\s\d{4}\s\d{4}$');
                                if (!regex.hasMatch(value)) {
                                  return 'Enter a valid card number';
                                }

                                return null;
                              },
                              inputFormatters: [
                                CardNumberInputFormatter(),
                                LengthLimitingTextInputFormatter(19),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Expiry Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 47,
                                child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    hintText: 'MM/YY',
                                    hintStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9),
                                      borderSide: BorderSide(
                                        color: mainBlack.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 5) {
                                      return 'Please enter a valid date';
                                    }
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ExpiryDateInputFormatter(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 22),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'CVV',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                obscuringCharacter: '*',
                                decoration: InputDecoration(
                                  hintText: '123',
                                  hintStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9),
                                    borderSide: BorderSide(
                                      color: mainBlack.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 3) {
                                    return 'Please enter a valid cvv number';
                                  }
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                // validator: ,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.71728971,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKeyPayment.currentState?.validate() ??
                              false) {
                            final order = OrderItem(
                              subTotal: cartNotifier.calcSubTotal().toString(),
                              discount: discount,
                              delivery: deliveryDetails,
                              total: cartNotifier.calcTotal().toString(),
                              paymentDetails: 'Card Payment',
                              deliveryOption: delivery,
                              orderStatus:
                                  0, // Assuming 0 is the initial status
                              statusMessage: 'Order Placed',
                              orderDate: DateTime.now(),
                              orderNumber:
                                  random.nextInt(5000) + random.nextInt(9),
                              product: orderProducts,
                              contacts: contacts,
                              deliveryFee: deliveryFee,
                              productQuantity: cartNotifier.calcTotalQuantity(),
                            );

                            cartNotifier.checkout();
                            historyNotifier.addOrder(order);
                            _checkoutController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );

                            // Create the order and add it to the order history
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Pay Now',
                          style: TextStyle(
                            fontSize: 12,
                            color: mainBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }

  Widget _buildConfirmScreen() {
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Image.asset('assets/Group 2240.png'),
      Positioned.fill(
          child: Column(
        children: [
          const SizedBox(height: 32),
          const Text(
            'Payment Successful',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.275),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            spacing: 13,
            children: const [
              CircleAvatar(
                radius: 52,
                backgroundColor: primaryColor,
                child: Icon(
                  Icons.check,
                  size: 52,
                  color: mainWhite,
                ),
              ),
              Text(
                'Payment Successful',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'Thank you for your purchase',
                style: TextStyle(fontWeight: FontWeight.w400),
              )
            ],
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.71728971,
            child: ElevatedButton(
              onPressed: () {
                _checkoutController.dispose();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => MainScreen(index: 0),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Back To Home',
                style: TextStyle(
                  fontSize: 12,
                  color: mainBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      )),
    ])));
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Clean up the input
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Add a slash after the second character if necessary
    if (newText.length > 2) {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    }

    // If the text is too long, limit it to 5 characters (mm/yy)
    if (newText.length > 5) {
      newText = newText.substring(0, 5);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any existing spaces
    String newText = newValue.text.replaceAll(RegExp(r'\s+'), '');

    // Add spaces after every 4 digits
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formattedText += ' ';
      }
      formattedText += newText[i];
    }

    // Update the cursor position
    int cursorPosition = formattedText.length;
    if (newValue.selection.end < formattedText.length) {
      cursorPosition = newValue.selection.end +
          (formattedText
                  .substring(0, newValue.selection.end)
                  .split(' ')
                  .length -
              1);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
