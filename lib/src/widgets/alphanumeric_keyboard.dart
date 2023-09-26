import 'package:flutter/material.dart';

import '../utils/enums.dart';
import '../utils/key_rows.dart';

class AlphanumericKeyboard extends StatefulWidget {
  const AlphanumericKeyboard(
      {required this.controller,
      this.height = 260,
      this.backgroundColor = const Color(0xff0a0a0a),
      this.actionKeyColor = const Color(0xff171717),
      this.alphanumericKeyColor = const Color(0xff2d2d2d),
      this.showSpaceKeyIcon = false,
      this.numericKeyTextStyle,
      this.alphaNumericKeyTextStyle,
      this.spaceKeyIcon,
      this.enterKeyIcon,
      this.backspaceKeyIcon,
      this.symbolsKeyIcon,
      this.alphabetKeyIcon,
      this.capsLockKeyIcon,
      this.capsUnlockKeyIcon,
      this.firstLetterCapitalizationColor,
      super.key});

  final double height;
  final TextEditingController controller;
  final Color backgroundColor;
  final Color actionKeyColor;
  final Color alphanumericKeyColor;
  final bool showSpaceKeyIcon;
  final TextStyle? numericKeyTextStyle;
  final TextStyle? alphaNumericKeyTextStyle;
  final IconData? spaceKeyIcon;
  final IconData? enterKeyIcon;
  final IconData? backspaceKeyIcon;
  final IconData? symbolsKeyIcon;
  final IconData? alphabetKeyIcon;
  final IconData? capsLockKeyIcon;
  final IconData? capsUnlockKeyIcon;
  final Color? firstLetterCapitalizationColor;

  @override
  State<AlphanumericKeyboard> createState() => _AlphanumericKeyboardState();
}

class _AlphanumericKeyboardState extends State<AlphanumericKeyboard> {
  Capitalization capitalization = Capitalization.onlyFirstLetter;

  KeyBoardType keyboardType = KeyBoardType.alphanumeric;

  Widget keyboardRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys
          .map(
            (e) => e == SpecialKey.space.name
                ? Expanded(child: actionKey(SpecialKey.space))
                : e.length > 1
                    ? actionKey(SpecialKey.values
                        .firstWhere((element) => element.name == e))
                    : keys[0] == '1'
                        ? numberKey(e)
                        : alphabetKey(e),
          )
          .toList(),
    );
  }

  Widget numberKey(String kKey) {
    return InkWell(
      onTap: () {
        widget.controller.text += kKey;
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: widget.alphanumericKeyColor,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(
          minWidth: 30,
          minHeight: 35,
        ),
        margin: const EdgeInsets.all(3.5),
        child: Center(
          child: Text(
            kKey,
            style: widget.numericKeyTextStyle ??
                const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }

  Widget alphabetKey(String kKey) {
    return InkWell(
      onTap: () {
        widget.controller.text += capitalization == Capitalization.lowerCase
            ? kKey.toLowerCase()
            : kKey;
        if (capitalization == Capitalization.onlyFirstLetter) {
          setState(() {
            capitalization = Capitalization.lowerCase;
          });
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: widget.alphanumericKeyColor,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(
          minWidth: 30,
          minHeight: 40,
        ),
        margin: const EdgeInsets.all(3.5),
        child: Center(
          child: Text(
            capitalization == Capitalization.lowerCase
                ? kKey.toLowerCase()
                : kKey,
            style: widget.alphaNumericKeyTextStyle ??
                const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }

  Widget? getActionKeyIcon(SpecialKey key) {
    IconData iconData;
    Color iconColor = Colors.white;
    double iconSize = 24;

    if (key == SpecialKey.capsLock) {
      iconData = capitalization == Capitalization.upperCase
          ? widget.capsLockKeyIcon ?? Icons.arrow_circle_up
          : widget.capsUnlockKeyIcon ?? Icons.arrow_upward;

      if (capitalization == Capitalization.onlyFirstLetter) {
        iconColor = widget.firstLetterCapitalizationColor ?? Colors.blue;
      }
    } else if (key == SpecialKey.backspace) {
      iconData = widget.backspaceKeyIcon ?? Icons.backspace_outlined;
    } else if (key == SpecialKey.space) {
      iconData = widget.spaceKeyIcon ?? Icons.space_bar;
      if (widget.showSpaceKeyIcon == false) {
        iconColor = widget.actionKeyColor;
      }
    } else if (key == SpecialKey.enter) {
      iconData = widget.enterKeyIcon ?? Icons.keyboard_return;
    } else {
      iconData = keyboardType == KeyBoardType.alphanumeric
          ? widget.symbolsKeyIcon ?? Icons.emoji_symbols
          : widget.alphabetKeyIcon ?? Icons.abc;
    }

    return Icon(
      iconData,
      color: iconColor,
      size: iconSize,
    );
  }

  Widget actionKey(SpecialKey kKey) {
    return InkWell(
      onTap: () {
        if (kKey == SpecialKey.backspace) {
          if (widget.controller.text.isNotEmpty) {
            widget.controller.text = widget.controller.text
                .substring(0, widget.controller.text.length - 1);
          }
        } else if (kKey == SpecialKey.space) {
          widget.controller.text += ' ';
        } else if (kKey == SpecialKey.enter) {
          widget.controller.text += '\n';
        } else if (kKey == SpecialKey.capsLock) {
          setState(() {
            switch (capitalization) {
              case Capitalization.lowerCase:
                capitalization = Capitalization.onlyFirstLetter;
                break;
              case Capitalization.onlyFirstLetter:
                capitalization = Capitalization.upperCase;
                break;
              case Capitalization.upperCase:
                capitalization = Capitalization.lowerCase;
                break;
            }
          });
        } else if (kKey == SpecialKey.symbols) {
          setState(() {
            if (keyboardType == KeyBoardType.alphanumeric) {
              keyboardType = KeyBoardType.symbols;
            } else {
              keyboardType = KeyBoardType.alphanumeric;
            }
          });
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: widget.actionKeyColor,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(
          minWidth: 30,
          minHeight: 40,
        ),
        margin: const EdgeInsets.all(3.5),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: getActionKeyIcon(kKey),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      color: widget.backgroundColor,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          keyboardRow(KeyRows.numbersRow),
          keyboardRow(keyboardType == KeyBoardType.alphanumeric
              ? KeyRows.alphabetsTopRow
              : KeyRows.symbolsTopRow),
          keyboardRow(keyboardType == KeyBoardType.alphanumeric
              ? KeyRows.alphabetsMiddleRow
              : KeyRows.symbolsMiddleRow),
          keyboardRow(keyboardType == KeyBoardType.alphanumeric
              ? KeyRows.alphabetsBottomRow
              : KeyRows.symbolsBottomRow),
          keyboardRow(KeyRows.lastRow),
        ],
      ),
    );
  }
}
