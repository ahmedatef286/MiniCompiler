import 'regular_expressions.dart';

void main() {
  //testing arithematic
  // print(arithmeticExpressionrRegex.hasMatch('add \$1      , \$1, \$31    '));
  //testing data transfer

  //print(dataTransferExpressionRegex.hasMatch('lw \$1 , 100(\$31)'));
  tokenize("""lw \$t0, num1
 lw \$t1, num2
 add \$t2, \$t0, \$t1 
 sw \$t2, sum """);
}
