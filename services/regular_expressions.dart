class StringPair {
  String key;
  String value;

  StringPair(this.key, this.value);
  @override
  String toString() {
    return 'Token: ' + this.key + ', Lexeme: ' + this.value;
  }
}

class Instruction {
  StringPair instructionTokenAndLexeme;
  List<StringPair> operands;
  String operandsTokensAndLexemes = "";

  Instruction(this.instructionTokenAndLexeme, this.operands) {
    for (int i = 0; i < operands.length; i++) {
      operandsTokensAndLexemes +=
          "| | | | -- ${operands[i].key}: ${operands[i].value}" +
              ((i == operands.length - 1) ? "" : "\n");
    }
  }

  String toString() {
    return '| |--${instructionTokenAndLexeme.key} instruction' +
        "\n" +
        '| | |--${instructionTokenAndLexeme.key}: ${instructionTokenAndLexeme.value}' +
        (operands.isNotEmpty
            ? ("\n" + "| | |--Operands" + "\n" + operandsTokensAndLexemes)
            : "");
  }
}

//common
String _identifierRegex = r"([a-z]|[A-Z]|[.]|[_])([a-z]|[A-Z]|[.]|[_]|[0-9])*";
String _registerRegex =
    r"[$](([0-9]|[12][0-9]|3[0-1])|zero|(v[01]|a[0-3]|t[0-9]|s[0-7]|ra))";
String _integerRegex = r"[0-9]+";
String _commaRegex = r"(\s)*,(\s)*";
String _colonRegex = r"(\s)*[:](\s)*";
String _commentRegex = r"(#.*)*";

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
    _commentRegex +
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
    _commentRegex +
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
    _commentRegex +
    r"(\s)*$");

//////////////////////branch and jump
/////////////////
String _branchOpOnlyLabel = r"(j|b)";
String _jumpOp1Register = r"(jr)";
String _branchOp2Register = r"(beq|bne|bgt|bge|blt|ble)";

//
String _branchExpressionLabelRegex =
    r"(\s)*" + _branchOpOnlyLabel + r"(\s)+" + _identifierRegex;
//
String _jumpExpression1Register =
    r"(\s)*" + _jumpOp1Register + r"(\s)+" + _registerRegex;
//
String _branchExpression2RegisterLabel = r"(\s)*" +
    _branchOp2Register +
    r"(\s)+" +
    _registerRegex +
    _commaRegex +
    _registerRegex +
    _commaRegex +
    _identifierRegex;
//
String _Label = r"(\s)*" + _identifierRegex + _colonRegex;
////regex
RegExp branchJumpExpression = RegExp(r"^" +
    _branchExpressionLabelRegex +
    r"|" +
    _jumpExpression1Register +
    r"|" +
    _branchExpression2RegisterLabel +
    r"|" +
    _Label +
    _commentRegex +
    r"(\s)*$");

////////////////////////////comment regex
///regex
RegExp commentFullLine = RegExp(r"^" + r"(\s)*" + _commentRegex + r"(\s)*$");

///////////////////////////////////////////////////////////////////////////////////////////////////
/////tokens and lexems
Map<String, String> regexTokens = {
  _registerRegex: "Register",
  _commaRegex: "Comma",
  _colonRegex: "Colon",
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
  r"beq": "BranchOnEqual",
  r"bne": "BranchOnNotEqual",
  r"bgt": "BranchOnGreaterThan",
  r"bge": "BranchOnGreaterThanOrEqual",
  r"blt": "BranchOnLessThan",
  r"ble": "BranchOnLessThanOrEqual",
  r"j": "JumpUnconditional",
  r"b": "BranchUnconiditional",
  r"jr": "JumpRegister",

  _identifierRegex:
      "Identifier", //moved it to last so that it doesn't match incorrectly early
  _integerRegex: "Integer",
  _commentRegex: "Comment",
};

List<StringPair> outputTokensAndLexemes = [];
Map<String, String> outputSymbolTable = {};

//FOCUSImplement el function el bet2asem
void tokenizeAndParse(String input) {
  bool hasError = false;
  int i = 0;
  List<int> errorIndicies = [];
  List<String> errorLines = [];
  List<String> lines = input.split("\n");
  for (String line in lines) {
    if (arithmeticExpressionrRegex.hasMatch(line) ||
        branchJumpExpression.hasMatch(line) ||
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
            if (regex.value == "Identifier") {
              //differentiate between indentifiers and labels
              if (arithmeticExpressionrRegex.hasMatch(line)) {
                outputTokensAndLexemes.add(StringPair(regex.value, lexeme));
              } else {
                outputTokensAndLexemes.add(StringPair("Label", lexeme));
                break;
              }
            }

            if (regex.value == "Comment") {
              break;
            }

            //save token and lexeme
            outputTokensAndLexemes.add(StringPair(regex.value, lexeme));
            //save identifiers in symbole table

            break;
          }
        }
      }
      outputTokensAndLexemes.add(StringPair("Escape", "\n"));
    } else {
      hasError = true;
      errorIndicies.add(i);
      errorLines.add(line);
      print('Incorrect expression');
    }
    i++;
  }
  if (hasError) {
    print("Syntax errors found in the following lines :-");
    errorIndicies.forEach((element) {
      print("Line $element => ${errorLines[element]}");
    });
  } else {
    print('\nOutput (Tokens and Symbol Table)\n');
    outputTokensAndLexemes.forEach(
      (element) {
        if (element.key != "Escape")
          print(element); //used to determine line breaks
      },
    );
    print('\nSymbol Table\n');

    outputSymbolTable.forEach((key, value) {
      print('Name: $key, Type: $value');
    });

    _parse(outputTokensAndLexemes);
  }
}

void _parse(List<StringPair> outputTokensAndLexemesIn) {
  List<Instruction> instructions = [];

  while (outputTokensAndLexemesIn.isNotEmpty) {
    int firstEscape = outputTokensAndLexemesIn
        .indexWhere((element) => element.key == "Escape");
    List<StringPair> line = outputTokensAndLexemesIn.take(firstEscape).toList();
    outputTokensAndLexemesIn.removeRange(0, firstEscape + 1);
    instructions
        .add(Instruction(line[0], line.getRange(1, line.length).toList()));
  }
  print("Program\n|-- TextSection");
  for (Instruction inst in instructions) {
    print(inst);
  }
  print("|-- Exit");
}
