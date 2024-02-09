import 'package:flutter/material.dart';

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<SmsMessage> _allCBEFirstMonthMessages = [];
  List<SmsMessage> _allCBESecondMonthMessages = [];
  List<SmsMessage> _allCBEThirdMonthMessages = [];
  List<SmsMessage> _allCBEFourthMonthMessages = [];
  List<SmsMessage> _allCBEFifthMonthMessages = [];
  List<SmsMessage> _allCBESixthMnthMessages = [];

  List<SmsMessage> _allCBEFirstMonthDebitMessages = [];
  List<SmsMessage> _allCBEFirstMonthCreditMessages = [];
  List<SmsMessage> _allCBESecondMonthDebitMessages = [];
  List<SmsMessage> _allCBESecondMonthCreditMessages = [];
  List<SmsMessage> _allCBEThirdMonthDebitMessages = [];
  List<SmsMessage> _allCBEThirdMonthCreditMessages = [];
  List<SmsMessage> _allCBEFourthMonthDebitMessages = [];
  List<SmsMessage> _allCBEFourthMonthCreditMessages = [];
  List<SmsMessage> _allCBEFifthMonthDebitMessages = [];
  List<SmsMessage> _allCBEFifthMonthCreditMessages = [];
  List<SmsMessage> _allCBESixthMonthDebitMessages = [];
  List<SmsMessage> _allCBESixthMonthCreditMessages = [];

  double totalFirstMonthCredit = 0;
  double totalFirstMonthDebit = 0;
  double totalSecondMonthCredit = 0;
  double totalSecondMonthDebit = 0;
  double totalThirdMonthCredit = 0;
  double totalThirdMonthDebit = 0;
  double totalFourthMonthCredit = 0;
  double totalFourthMonthDebit = 0;
  double totalFifthMonthCredit = 0;
  double totalFifthMonthDebit = 0;
  double totalSixthMonthCredit = 0;
  double totalSixthMonthDebit = 0;

  double currentBalance = 0;

  @override
  void initState() {
    super.initState();
    requestSmsPermission();
  }

  Future<void> requestSmsPermission() async {
    final status = await Permission.sms.status;
    if (status.isDenied) {
      // Request SMS permission if not granted
      final response = await Permission.sms.request();
      if (response.isGranted) {
        print(status);
        getAllMessages();
      }
    } else if (status.isGranted) {
      print(status);
      getAllMessages();
    }
  }

  Future<void> getAllMessages() async {
    SmsQuery query = SmsQuery();
    List<SmsMessage> messages = await query.getAllSms;

    debugPrint("Total Messages: ${messages.length}");

    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(Duration(days: 7));
    final firstMonth = now.subtract(Duration(days: 30));
    final secondMonth = now.subtract(Duration(days: 60));
    final thirdMonth = now.subtract(Duration(days: 90));
    final fourthMonth = now.subtract(Duration(days: 120));
    final fifthMonth = now.subtract(Duration(days: 150));
    final sixthMonth = now.subtract(Duration(days: 180));

    for (var message in messages) {
      if (message.address == "CBE") {
        if (message.date!.isAfter(firstMonth)) {
          setState(() {
            _allCBEFirstMonthMessages.add(message);
          });
        } else if (message.date!.isAfter(secondMonth) &&
            message.date!.isBefore(firstMonth)) {
          setState(() {
            _allCBESecondMonthMessages.add(message);
          });
        } else if (message.date!.isAfter(thirdMonth) &&
            message.date!.isBefore(secondMonth)) {
          setState(() {
            _allCBEThirdMonthMessages.add(message);
          });
        } else if (message.date!.isAfter(fourthMonth) &&
            message.date!.isBefore(thirdMonth)) {
          setState(() {
            _allCBEFourthMonthMessages.add(message);
          });
        } else if (message.date!.isAfter(fifthMonth) &&
            message.date!.isBefore(fourthMonth)) {
          setState(() {
            _allCBEFifthMonthMessages.add(message);
          });
        } else if (message.date!.isAfter(sixthMonth) &&
            message.date!.isBefore(fifthMonth)) {
          setState(() {
            _allCBESixthMnthMessages.add(message);
          });
        }
      }
    }
    debugPrint(
        "Total first month Messages: ${_allCBEFirstMonthMessages.length}");
    debugPrint(
        "Total second month Messages: ${_allCBESecondMonthMessages.length}");
    debugPrint(
        "Total third month Messages: ${_allCBEThirdMonthMessages.length}");
    debugPrint(
        "Total fourth month Messages: ${_allCBEFourthMonthMessages.length}");
    debugPrint(
        "Total fifth month Messages: ${_allCBEFifthMonthMessages.length}");
    debugPrint(
        "Total sixth month Messages: ${_allCBESixthMnthMessages.length}");

// filter first month debit and credit messages
    for (var message in _allCBEFirstMonthMessages) {
      if (message.body!.contains("debited")) {
        setState(() {
          _allCBEFirstMonthDebitMessages.add(message);
        });
      } else if (message.body!.contains("Credited") ||
          message.body!.contains("credited")) {
        setState(() {
          _allCBEFirstMonthCreditMessages.add(message);
        });
      }
    }
    debugPrint(
        "Total first month debit Messages: ${_allCBEFirstMonthDebitMessages.length}");
    debugPrint(
        "Total first month credit Messages: ${_allCBEFirstMonthCreditMessages.length}");

    // filter second month debit and credit messages
    for (var message in _allCBESecondMonthMessages) {
      if (message.body!.contains("debited")) {
        setState(() {
          _allCBESecondMonthDebitMessages.add(message);
        });
      } else if (message.body!.contains("Credited") ||
          message.body!.contains("credited")) {
        setState(() {
          _allCBESecondMonthCreditMessages.add(message);
        });
      }
    }
    debugPrint(
        "Total second month debit Messages: ${_allCBESecondMonthDebitMessages.length}");
    debugPrint(
        "Total second month credit Messages: ${_allCBESecondMonthCreditMessages.length}");

    // filter third month debit and credit messages
    for (var message in _allCBEThirdMonthMessages) {
      if (message.body!.contains("debited")) {
        setState(() {
          _allCBEThirdMonthDebitMessages.add(message);
        });
      } else if (message.body!.contains("Credited") ||
          message.body!.contains("credited")) {
        setState(() {
          _allCBEThirdMonthCreditMessages.add(message);
        });
      }
    }
    debugPrint(
        "Total third month debit Messages: ${_allCBEThirdMonthDebitMessages.length}");
    debugPrint(
        "Total third month credit Messages: ${_allCBEThirdMonthCreditMessages.length}");

    // filter fourth month debit and credit messages
    for (var message in _allCBEFourthMonthMessages) {
      if (message.body!.contains("debited")) {
        setState(() {
          _allCBEFourthMonthDebitMessages.add(message);
        });
      } else if (message.body!.contains("Credited") ||
          message.body!.contains("credited")) {
        setState(() {
          _allCBEFourthMonthCreditMessages.add(message);
        });
      }
    }
    debugPrint(
        "Total fourth month debit Messages: ${_allCBEFourthMonthDebitMessages.length}");
    debugPrint(
        "Total fourth month credit Messages: ${_allCBEFourthMonthCreditMessages.length}");

    // filter fifth month debit and credit messages
    for (var message in _allCBEFifthMonthMessages) {
      if (message.body!.contains("debited")) {
        setState(() {
          _allCBEFifthMonthDebitMessages.add(message);
        });
      } else if (message.body!.contains("Credited") ||
          message.body!.contains("credited")) {
        setState(() {
          _allCBEFifthMonthCreditMessages.add(message);
        });
      }
    }
    debugPrint(
        "Total fifth month debit Messages: ${_allCBEFifthMonthDebitMessages.length}");
    debugPrint(
        "Total fifth month credit Messages: ${_allCBEFifthMonthCreditMessages.length}");

    // filter sixth debit and credit messages
    for (var message in _allCBESixthMnthMessages) {
      if (message.body!.contains("debited")) {
        setState(() {
          _allCBESixthMonthDebitMessages.add(message);
        });
      } else if (message.body!.contains("Credited") ||
          message.body!.contains("credited")) {
        setState(() {
          _allCBESixthMonthCreditMessages.add(message);
        });
      }
    }
    debugPrint(
        "Total sixth month debit Messages: ${_allCBESixthMonthDebitMessages.length}");
    debugPrint(
        "Total sixth month credit Messages: ${_allCBESixthMonthCreditMessages.length}");

    // extract the first month total amount money debited
    for (var message in _allCBEFirstMonthDebitMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalFirstMonthDebit += credit!;
      }
    }
    debugPrint("Total first month debit amount is: ${totalFirstMonthDebit}");

    // extract the first month total amount money credited
    for (var message in _allCBEFirstMonthCreditMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalFirstMonthCredit += credit!;
      }
    }
    debugPrint("Total first month credit amount is: ${totalFirstMonthCredit}");

    // extract the second month total amount money debited
    for (var message in _allCBESecondMonthDebitMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalSecondMonthDebit += credit!;
      }
    }
    debugPrint("Total second month debit amount is: ${totalSecondMonthDebit}");

    // extract the second month total amount money credited
    for (var message in _allCBESecondMonthCreditMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalSecondMonthCredit += credit!;
      }
    }
    debugPrint(
        "Total second month credit amount is: ${totalSecondMonthCredit}");

    // extract the third month total amount money debited
    for (var message in _allCBEThirdMonthDebitMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalThirdMonthDebit += credit!;
      }
    }
    debugPrint("Total third month debit amount is: ${totalThirdMonthDebit}");

    // extract the third month total amount money credited
    for (var message in _allCBEThirdMonthCreditMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalThirdMonthCredit += credit!;
      }
    }
    debugPrint("Total third month credit amount is: ${totalThirdMonthCredit}");

    // extract the fourth month total amount money debited
    for (var message in _allCBEFourthMonthDebitMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalFourthMonthDebit += credit!;
      }
    }
    debugPrint("Total fourth month debit amount is: ${totalFourthMonthDebit}");

    // extract the fourth month total amount money credited
    for (var message in _allCBEFourthMonthCreditMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalFourthMonthCredit += credit!;
      }
    }
    debugPrint(
        "Total fourth month credit amount is: ${totalFourthMonthCredit}");

    // extract the fifth month total amount money debited
    for (var message in _allCBEFifthMonthDebitMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalFifthMonthDebit += credit!;
      }
    }
    debugPrint("Total fifth month debit amount is: ${totalFifthMonthDebit}");

    // extract the fifth month total amount money credited
    for (var message in _allCBEFifthMonthCreditMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalFifthMonthCredit += credit!;
      }
    }
    debugPrint("Total fifth month credit amount is: ${totalFifthMonthCredit}");

    // extract the sixth month total amount money debited
    for (var message in _allCBESixthMonthDebitMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalSixthMonthDebit += credit!;
      }
    }
    debugPrint("Total sixth month debit amount is: ${totalSixthMonthDebit}");

    // extract the sixth month total amount money credited
    for (var message in _allCBESixthMonthCreditMessages) {
      final creditMatch = RegExp(r"ETB ([\d,]+)").firstMatch(message.body!);
      if (creditMatch != null) {
        final amountString =
            creditMatch.group(1)!.replaceAll(",", ""); // Remove commas
        double? credit = double.tryParse(amountString.toString());

        totalSixthMonthCredit += credit!;
      }
    }
    debugPrint("Total sixth month credit amount is: ${totalSixthMonthCredit}");

    // extract the current balance
    final creditMatch = RegExp(r"ETB ([\d,]+)")
        .allMatches(_allCBEFirstMonthMessages[0].body!)
        .toList();
    final amountString = creditMatch[creditMatch.length - 1]
        .group(1)!
        .replaceAll(",", ""); // Remove commas
    double? credit = double.tryParse(amountString.toString());
    currentBalance = credit!;

    print("Current Balance is: $currentBalance");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: _allCBEFirstMonthMessages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _allCBEFirstMonthMessages[index].body!,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _allCBEFirstMonthMessages[index].sender!,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          );
        },
      )),
    );
  }
}
