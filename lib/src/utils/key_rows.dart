import 'enums.dart';

class KeyRows {
  static final List<String> numbersRow = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
  ];

  static final List<String> alphabetsTopRow = [
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Y',
    'U',
    'I',
    'O',
    'P',
  ];

  static final List<String> alphabetsMiddleRow = [
    'A',
    'S',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
  ];

  static final List<String> alphabetsBottomRow = [
    SpecialKey.capsLock.name,
    'Z',
    'X',
    'C',
    'V',
    'B',
    'N',
    'M',
    SpecialKey.backspace.name,
  ];

  static final List<String> symbolsTopRow = [
    '+',
    '×',
    '÷',
    '=',
    '/',
    '_',
    '<',
    '>',
    '[',
    ']',
  ];

  static final List<String> symbolsMiddleRow = [
    '!',
    '@',
    '#',
    '\$',
    '%',
    '^',
    '&',
    '(',
    ')',
  ];

  static final List<String> symbolsBottomRow = [
    '-',
    '*',
    "'",
    '"',
    ':',
    ';',
    '|',
    '?',
    SpecialKey.backspace.name,
  ];

  static final List<String> lastRow = [
    SpecialKey.symbols.name,
    ',',
    SpecialKey.space.name,
    '.',
    SpecialKey.enter.name,
  ];

  static final List<String> numericRow = [
    '1',
    '2',
    '3',
    SpecialKey.backspace.name,
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    ',',
    '*',
    '0',
    '.',
    SpecialKey.enter.name,
  ];

  static final List<String> numericSpecialCases = [
    '-',
    ',',
    '*',
    '.',
  ];
}
