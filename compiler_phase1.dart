void main() {
  String
      registerRegex = // this part for numbers |  and this part for alphanumeric
      r"[$](([0-9]|[12][0-9]|3[0-1])|(v[01]|a[0-3]|t[0-9]|s[0-7]|ra))";

  String commasRegex = r"\s*,\s*";

  RegExp logical = RegExp(r'^\s*(andi|or|s[lr]l)\s+(' +
      registerRegex +
      commasRegex +
      r'){2}\s*\d+\s*)|((and|or)\s*(' +
      registerRegex +
      commasRegex +
      r'){2}' +
      registerRegex +
      r'\s*$');

  RegExp arithmetic = RegExp(r"^\s*(mul|subu?|addu?)\s+(" +
      registerRegex +
      commasRegex +
      r"){2}" +
      registerRegex +
      r"\s*$");

  final match = logical.firstMatch('andi \$1,\$2,100');
  // print(match?.group(0).toString().split(" "));
  print(logical.hasMatch('andi \$1,\$2,100'));
}
