import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/Constants/colors.dart';
import 'package:ui_project/Constants/imagePath.dart';
import 'package:ui_project/Functions/getSubtotal.dart';
import 'package:ui_project/Screens/ordersView/orders_View.dart';
import 'package:ui_project/toast/customToast.dart';
import 'package:page_transition/page_transition.dart';

import '../../widgets/customAppbar.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  void CheckCard() {
    if (cardNumber.text == '') {
      cardExist = false;
    } else {
      for (int i = 0; i < cardNumber.text.length;) {
        if (cardNumber.text[i] == '2' || cardNumber.text[i] == '5') {
          card = ProductImages.Mastercard;
          for (int i = 0; i < cardNumber.text.length; i++) {}
          cardExist = true;
          break;
        } else if (cardNumber.text[i] == '4') {
          card = ProductImages.Visa;
          cardExist = true;
          break;
        }
        // else if (cardNumber.text[i] == '3') {
        //   card = ProductImages.American;
        //   cardExist = true;
        //   break;
        // }
        else {
          card = ProductImages.wrongCard;
          cardExist = false;
          break;
        }
      }
    }
  }

  TextStyle Pricing = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: TextColors.textColor3);

  TextStyle Total = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w700, color: TextColors.textColor3);

  TextStyle PricingTitle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: TextColors.textColor4);

  int subTotal = 0;

  TextStyle TextFieldStyle = const TextStyle(
      color: TextColors.textColor4, fontSize: 12, fontWeight: FontWeight.w600);

  TextEditingController cardHolder = TextEditingController();
  late String card_Holder = '';
  TextEditingController cardNumber = TextEditingController();
  late String card_Number = '';

  TextEditingController cardExp = TextEditingController();
  late String card_Exp = '';
  TextEditingController cardCVV = TextEditingController();
  late String card_CVV = '';

  String card = '';
  bool cardExist = false;
  FocusNode Holder = FocusNode();
  FocusNode Number = FocusNode();
  FocusNode Exp = FocusNode();
  FocusNode CVV = FocusNode();

  @override
  void initState() {
    subTotal = SubTotal.getSubTotal();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: const CustomAppBar(
                screenName: 'Add Card',
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 50, 0, 0),
              child: Text(
                'CARD HOLDER',
                style: TextFieldStyle,
              ),
            ),
            // Name TextField
            Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: TextField(
                focusNode: Holder,
                style: const TextStyle(color: TextColors.textColor3),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 23, horizontal: 10),
                  suffixIcon: IconButton(
                    onPressed: () {
                      cardHolder.clear();
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: TextColors.textColor4,
                    ),
                  ),
                  hintStyle:
                      TextStyle(color: TextColors.textColor4.withOpacity(0.4)),
                  hintText: 'eg. Sheikh Taha',
                  filled: true,
                  fillColor: TextColors.textColor1,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: TextColors.textColor2, width: 0.5),
                  ),
                ),
                controller: cardHolder,
                onSubmitted: (String value) {
                  card_Holder = cardHolder.text;
                  FocusScope.of(context).requestFocus(Number);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: Text(
                'CARD NUMBER',
                style: TextFieldStyle,
              ),
            ),
            // CardNumber TextField
            Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: TextField(
                keyboardType: TextInputType.number,
                focusNode: Number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CardNumberInputFormatter()
                ],
                style: const TextStyle(color: TextColors.textColor3),
                decoration: InputDecoration(
                  prefixIcon: cardNumber.text == ''
                      ? null
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(card),
                        ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 23, horizontal: 10),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        card = '';
                        cardNumber.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: TextColors.textColor4,
                    ),
                  ),
                  hintStyle:
                      TextStyle(color: TextColors.textColor4.withOpacity(0.4)),
                  hintText: 'eg. 0987 0986 5543 0980',
                  filled: true,
                  fillColor: TextColors.textColor1,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: TextColors.textColor2, width: 0.5),
                  ),
                ),
                controller: cardNumber,
                onSubmitted: (String value) {
                  card_Number = cardNumber.text;
                  FocusScope.of(context).requestFocus(Exp);
                },
                onChanged: (String value) {
                  setState(
                    () {
                      CheckCard();
                    },
                  );
                },
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // EXPDATE TextField
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'EXP DATE',
                              style: TextFieldStyle,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                DateInputFormatter()
                              ],
                              keyboardType: TextInputType.datetime,
                              focusNode: Exp,
                              style:
                                  const TextStyle(color: TextColors.textColor3),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 23, horizontal: 10),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cardExp.clear();
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: TextColors.textColor4,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                    color:
                                        TextColors.textColor4.withOpacity(0.4)),
                                hintText: 'eg. 10/23',
                                filled: true,
                                fillColor: TextColors.textColor1,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      color: TextColors.textColor2, width: 0.5),
                                ),
                              ),
                              controller: cardExp,
                              onSubmitted: (String value) {
                                card_Exp = cardExp.text;
                                FocusScope.of(context).requestFocus(CVV);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  // CVV TextField
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'CVV',
                              style: TextFieldStyle,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                              keyboardType: TextInputType.number,
                              focusNode: CVV,
                              style:
                                  const TextStyle(color: TextColors.textColor3),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 23, horizontal: 10),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cardCVV.clear();
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: TextColors.textColor4,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                    color:
                                        TextColors.textColor4.withOpacity(0.4)),
                                hintText: 'eg. 3456',
                                filled: true,
                                fillColor: TextColors.textColor1,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      color: TextColors.textColor2, width: 0.5),
                                ),
                              ),
                              controller: cardCVV,
                              onSubmitted: (String value) {
                                card_CVV = cardCVV.text;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: TextColors.textColor1.withOpacity(1),
                    border:
                        Border.all(width: 0.5, color: TextColors.textColor2),
                    boxShadow: const [
                      BoxShadow(
                        color: TextColors.textColor2,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: .5,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(top: 67, bottom: 5),
                  height: MediaQuery.of(context).size.height * 0.28,
                  width: 359,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal', style: PricingTitle),
                              Text('\$$subTotal', style: Pricing)
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Fee', style: PricingTitle),
                              Text('\$2', style: Pricing)
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total', style: PricingTitle),
                              Text('\$${subTotal + 2}', style: Total)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: PrimaryColors.primaryBlue,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                fixedSize: Size(327, 56)),
                            onPressed: () {
                              if (cardHolder.text == '' ||
                                  cardNumber.text == '' ||
                                  cardExp.text == '' ||
                                  cardCVV.text == '') {
                                CustomToast.showToast(
                                    'Fill the above textfields');
                              } else if (cardExist == false) {
                                CustomToast.showToast(
                                    'Please Enter correct card number');
                              } else {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    curve: Curves.linear,
                                    type: PageTransitionType.rightToLeft,
                                    child: const OrderView(),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              "Proceed To checkout",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String enteredData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < enteredData.length; i++) {
      buffer.write(enteredData[i]);
      int index = i + 1;
      if (index % 4 == 0 && enteredData.length != index) {
        buffer.write(" ");
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String enteredData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < enteredData.length; i++) {
      buffer.write(enteredData[i]);
      int index = i + 1;
      if (index % 2 == 0 && enteredData.length != index) {
        buffer.write("/");
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}
