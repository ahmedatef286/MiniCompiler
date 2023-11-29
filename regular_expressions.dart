//common
String identifierRegex = r"([a-zA-z]|[.]|[_])([a-zA-z]|[.]|[_]|[0-9])*";
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
String dataTransferOpLabelRegex = r"lw|sw|la";
String dataTransferOpRegisterOnlyRegex = r"move";
String dataTransferOpRegisterOffsetRegex = r"lw|sw";
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
    r"[)]";
//
String dataTransferExpressionImmediateRegex = r"(\s)*" +
    dataTransferOpImmediateRegex +
    r"(\s)+" +
    registerRegex +
    commaRegex +
    integerRegex;
//
RegExp dataTransferExpressionRegex = RegExp(r"^" +
    dataTransferExpressionLabelRegex +
    r"|" +
    dataTransferExpressionRegisterOnlyRegex +
    r"|" +
    dataTransferExpressionRegisterOffsetRegex +
    r"|" +
    dataTransferExpressionImmediateRegex +
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

//FOCUSImplement el function el bet2asem
void tokenize(String input) {
  if (arithmeticExpressionrRegex.hasMatch(input)) {
  } else if (dataTransferExpressionRegex.hasMatch(input)) {}
}
