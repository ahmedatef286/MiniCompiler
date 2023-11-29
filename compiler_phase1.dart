void main() {
  String identifierRegex = r"([a-zA-z]|[.]|[_])([a-zA-z]|[.]|[_]|[0-9])*";
  String registerRegex =
      r"[$](([0-9]|[12][0-9]|3[0-1])|(v[01]|a[0-3]|t[0-9]|s[0-7]|ra))";
  String integerRegex = r"[0-9]+";
  String commaRegex = r"(\s)*,(\s)*";
  String arithmaticOpRegex = r"(mul|sub|add)";
  String commandRegex = r"(\s)*" + arithmaticOpRegex + r"(\s)+";

  RegExp arithmeticExpression = RegExp(r"^" +
      commandRegex +
      registerRegex +
      commaRegex +
      registerRegex +
      commaRegex +
      registerRegex +
      r"(\s)*$");
  print(arithmeticExpression.hasMatch('add \$0      , \$1, \$31    '));
}
