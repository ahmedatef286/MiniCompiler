import 'services/regular_expressions.dart';

void main() {
  tokenize("""lw \$t0, num1
 lw \$t1, num2
 add \$t2, \$t0, \$t1 
 sw \$t2, sum """);
}
