import 'regular_expressions.dart';

void main() {
  //testing arithematic
  print(arithmeticExpressionrRegex.hasMatch('add \$1      , \$1, \$31    '));
  //testing data transfer
  print(dataTransferExpressionRegex.hasMatch('lw \$1,100(\$2)'));
}
