//common
String identifierRegex = r"([a-z]|[A-Z]|[.]|[_])([a-z]|[A-Z]|[.]|[_]|[0-9])*";
String registerRegex =
    r"[$](([0-9]|[12][0-9]|3[0-1])|(v[01]|a[0-3]|t[0-9]|s[0-7]|ra))";
String integerRegex = r"[0-9]+";
String commaRegex = r"(\s)*,(\s)*";

/////////////////////arithmatic operations
///building blocks
String arithmaticOp3RegisterRegex = r"(mul|sub|add|addu|subu)";
String arithmaticOp2RegisterRegex = r"(mult|div)";
String arithmaticOpRImmediateRegex = r"(addi|addiu)";
//
String airthematicExpression3RegisterRegex = r"(\s)*" +
    arithmaticOp3RegisterRegex +
    r"(\s)+" +
    r"(" +
    registerRegex +
    commaRegex +
    r"){2}" +
    registerRegex;
//
String airthematicExpression2RegisterRegex = r"(\s)*" +
    arithmaticOp2RegisterRegex +
    r"(\s)+" +
    registerRegex +
    commaRegex +
    registerRegex;
//
String airthematicExpressionImmediateRegex = r"(\s)*" +
    arithmaticOpRImmediateRegex +
    r"(\s)+" +
    r"(" +
    registerRegex +
    commaRegex +
    r"){2}" +
    integerRegex;

///regex
RegExp arithmeticExpressionrRegex = RegExp(r"^" +
    airthematicExpressionImmediateRegex +
    r"|" +
    airthematicExpression2RegisterRegex +
    r"|" +
    airthematicExpression3RegisterRegex +
    r"(\s)*$");

/////////////////////data transfer
///building blocks
String dataTransferOpLabelRegex = r"(lw|sw|la)";
String dataTransferOpRegisterOnlyRegex = r"move";
String dataTransferOpRegisterOffsetRegex = r"(lw|sw)";
String dataTransferOpImmediateRegex = r"li";
//
String dataTransferExpressionLabelRegex = r"(\s)*" +
    dataTransferOpLabelRegex +
    r"(\s)+" +
    registerRegex +
    commaRegex +
    identifierRegex;
//
String dataTransferExpressionRegisterOnlyRegex = r"(\s)*" +
    dataTransferOpRegisterOnlyRegex +
    r"(\s)+" +
    registerRegex +
    commaRegex +
    registerRegex;
//
String dataTransferExpressionRegisterOffsetRegex = r"(\s)*" +
    dataTransferOpRegisterOffsetRegex +
    r"(\s)+" +
    registerRegex +
    commaRegex +
    integerRegex +
    r"[(]" +
    registerRegex +
    r"[)]$";
//
String dataTransferExpressionImmediateRegex = r"(\s)*" +
    dataTransferOpImmediateRegex +
    r"(\s)+" +
    registerRegex +
    commaRegex +
    integerRegex;
//
RegExp dataTransferExpressionRegex = RegExp(r"^" +
    /*  dataTransferExpressionLabelRegex +
    r"|" +
    dataTransferExpressionRegisterOnlyRegex +
    r"|" + */
    dataTransferExpressionRegisterOffsetRegex +
    /*   r"|" +
    dataTransferExpressionImmediateRegex + */
    r"(\s)*$");

/* 
  //logical operations
  String logicalOpRegisterRegex = r"(and|or)";
  String logicalOpImmediateRegex = r"(andi|or|sll|srl)";
  String logicalOpRegex =
      logicalOpImmediateRegex + r"|" + logicalOpRegisterRegex;


  RegExp logical = RegExp(r'^\s*' +
      logicalOpRegex +
      '\s+(' +
      registerRegex +
      commaRegex +
      r'){2}\s*\d+\s*)|((and|or)\s*(' +
      registerRegex +
      commaRegex +
      r'){2}' +
      registerRegex +
      r'\s*$');

  final match = logical.firstMatch('andi \$1,\$2,100');
  // print(match?.group(0).toString().split(" "));
  print(logical.hasMatch('andi \$1,\$2,100')); */

//////////////////////////////////////
/////tokens and lexems
Map<String, String> regexTokens = {
  registerRegex: "Register",
  commaRegex: "Comma",
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

  identifierRegex:
      "Identifier", //moved it to last so that it doesn't match incorrectly early
  integerRegex: "Integer",
};
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
            print('Token: ${regex.value}, lexeme: ${lexeme}');
            break;
          }
        }
      }
    }
  }
}
