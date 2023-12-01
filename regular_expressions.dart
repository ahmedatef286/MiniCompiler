class StringPair {
  String key;
  String value;

  StringPair(this.key, this.value);
  @override
  String toString() {
    return 'Token : ' + this.key + ' Lexeme : ' + this.value;
  }
}

//common
String _identifierRegex = r"([a-z]|[A-Z]|[.]|[_])([a-z]|[A-Z]|[.]|[_]|[0-9])*";
String _registerRegex =
    r"[$](([0-9]|[12][0-9]|3[0-1])|(v[01]|a[0-3]|t[0-9]|s[0-7]|ra))";
String _integerRegex = r"[0-9]+";
String _commaRegex = r"(\s)*,(\s)*";

/////////////////////arithmatic operations
///building blocks
String _arithmaticOp3RegisterRegex = r"(mul|sub|add|addu|subu)";
String _arithmaticOp2RegisterRegex = r"(mult|div)";
String _arithmaticOpRImmediateRegex = r"(addi|addiu)";
//
String _airthematicExpression3RegisterRegex = r"(\s)*" +
    _arithmaticOp3RegisterRegex +
    r"(\s)+" +
    r"(" +
    _registerRegex +
    _commaRegex +
    r"){2}" +
    _registerRegex;
//
String _airthematicExpression2RegisterRegex = r"(\s)*" +
    _arithmaticOp2RegisterRegex +
    r"(\s)+" +
    _registerRegex +
    _commaRegex +
    _registerRegex;
//
String _airthematicExpressionImmediateRegex = r"(\s)*" +
    _arithmaticOpRImmediateRegex +
    r"(\s)+" +
    r"(" +
    _registerRegex +
    _commaRegex +
    r"){2}" +
    _integerRegex;

///regex
RegExp arithmeticExpressionrRegex = RegExp(r"^" +
    _airthematicExpressionImmediateRegex +
    r"|" +
    _airthematicExpression2RegisterRegex +
    r"|" +
    _airthematicExpression3RegisterRegex +
    r"(\s)*$");

/////////////////////data transfer
///building blocks
String _dataTransferOpLabelRegex = r"(lw|sw|la)";
String _dataTransferOpRegisterOnlyRegex = r"move";
String _dataTransferOpRegisterOffsetRegex = r"(lw|sw)";
String _dataTransferOpImmediateRegex = r"li";
//
String _dataTransferExpressionLabelRegex = r"(\s)*" +
    _dataTransferOpLabelRegex +
    r"(\s)+" +
    _registerRegex +
    _commaRegex +
    _identifierRegex;
//
String _dataTransferExpressionRegisterOnlyRegex = r"(\s)*" +
    _dataTransferOpRegisterOnlyRegex +
    r"(\s)+" +
    _registerRegex +
    _commaRegex +
    _registerRegex;
//
String _dataTransferExpressionRegisterOffsetRegex = r"(\s)*" +
    _dataTransferOpRegisterOffsetRegex +
    r"(\s)+" +
    _registerRegex +
    _commaRegex +
    _integerRegex +
    r"[(]" +
    _registerRegex +
    r"[)]$";
//
String _dataTransferExpressionImmediateRegex = r"(\s)*" +
    _dataTransferOpImmediateRegex +
    r"(\s)+" +
    _registerRegex +
    _commaRegex +
    _integerRegex;
//
RegExp dataTransferExpressionRegex = RegExp(r"^" +
    _dataTransferExpressionLabelRegex +
    r"|" +
    _dataTransferExpressionRegisterOnlyRegex +
    r"|" +
    _dataTransferExpressionRegisterOffsetRegex +
    r"|" +
    _dataTransferExpressionImmediateRegex +
    r"(\s)*$");

/////////////////////logical
///building blocks
String _logicalOp3RegisterRegex = r"(and|or)";
String _logicalOpRImmediateRegex = r"(andi|or|sll|srl)";

//
String _logicalExpression3RegisterRegex = r"(\s)*" +
    _logicalOp3RegisterRegex +
    r"(\s)+" +
    r"(" +
    _registerRegex +
    _commaRegex +
    r"){2}" +
    _registerRegex;
//
String _logicalExpressionImmediateRegex = r"(\s)*" +
    _logicalOpRImmediateRegex +
    r"(\s)+" +
    r"(" +
    _registerRegex +
    _commaRegex +
    r"){2}" +
    _integerRegex;

///regex
RegExp logicalExpressionRegex = RegExp(r"^" +
    _logicalExpression3RegisterRegex +
    r"|" +
    _logicalExpressionImmediateRegex +
    r"(\s)*$");

///////////////////////////////////////////////////////////////////////////////////////////////////
/////tokens and lexems
Map<String, String> regexTokens = {
  _registerRegex: "Register",
  _commaRegex: "Comma",
  r"mul": "Mul",
  r"mult": "Mult",
  r"sub": "Sub",
  r"add": "Add",
  r"addi": "AddImmediate",
  r"subi": "SubImmediate",
  r"addu": "AddUnsigned",
  r"subu": "SubUnsigned",
  r"div": "Div",
  r"[(]": "LeftBracket",
  r"[)]": "RightBracket",
  r"lw": "LoadWord",
  r"sw": "SaveWord",
  r"la": "LoadAddress",
  r"move": "Move",
  r"li": "LoadImmediate",
  r"and": "And",
  r"or": "Or",
  r"andi": "AndImmediate",
  r"sll": "ShiftLeftLogical",
  r"srl": "ShiftRightLogical",

  _identifierRegex:
      "Identifier", //moved it to last so that it doesn't match incorrectly early
  _integerRegex: "Integer",
};

List<StringPair> outputTokensAndLexemes = [];
Map<String, String> outputSymbolTable = {};

//FOCUSImplement el function el bet2asem
void tokenize(String input) {
  List<String> lines = input.split("\n");
  for (String line in lines) {
    if (arithmeticExpressionrRegex.hasMatch(line) ||
        dataTransferExpressionRegex.hasMatch(line)) {
      //
      List<String> lexems = line.split(RegExp(
          r'(?<=[ ,])|(?=[ ,])|(?<=[ (])|(?=[ (])|(?<=[ )])|(?=[ )])')); //positive look ahead and behind ie split by commas and spaces but also include the commas in the produced list
      for (int i = 0; i < lexems.length; i++) {
        lexems[i] = lexems[i].trim();
      }
      lexems.removeWhere((part) => part.isEmpty);
      print(lexems);
      for (String lexeme in lexems) {
        for (var regex in regexTokens.entries) {
          if (RegExp(regex.key).hasMatch(lexeme)) {
            //save token and lexeme
            outputTokensAndLexemes.add(StringPair(regex.value, lexeme));
            //save identifiers in symbole table
            if (regex.value == 'Identifier') {
              outputSymbolTable[lexeme] = 'memoryAddress';
            }
            break;
          }
        }
      }
    }
  }
  outputTokensAndLexemes.forEach(
    (element) {
      print(element);
    },
  );
  print(outputSymbolTable);
}
