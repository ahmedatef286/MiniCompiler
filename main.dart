import './services/regular_expressions.dart';

List<String> assemblyCodes = [
  '''lw \$t0, result
  addi \$t1, \$zero, 5
  addi \$t2, \$zero, 3
  add \$t0, \$t1, \$t2
  sub \$t0, \$t0, \$t2
  sw \$t0, result''',
  '''lw \$t0, mask
  li \$t1, 0xA5
  and \$t2, \$t0, \$t1
  or \$t3, \$t0, \$t1''',
  '''lw \$t0, array
  lw \$t1, 12(\$t0)
  sw \$t1, result''',
  '''li \$t0, 7
  addi \$t1, \$t0, 3
  addi \$t2, \$t0, -2
  add \$t3, \$t1, \$t2
  sw \$t3, result''',
  '''li \$t0, 5
  sll \$t1, \$t0, 2
  sw \$t1, result''',
  '''li \$t0, 10
  li \$t1, 20
  add \$t2, \$t0, \$t1
  sw \$t2, result''',
  '''li \$t0, 15
  li \$t1, 8
  subi \$t2, \$t0, 5
  sub \$t3, \$t2, \$t1
  sw \$t3, result''',
  '''li \$t0, 0x0F
  andi \$t1, \$t0, 0x03
  ori \$t2, \$t0, 0xF0
  sw \$t1, result''',
  '''li \$t0, 0xABCD
  lui \$t1, 0xFFFF
  sw \$t1, result''',
  '''la \$t0, value
  lw \$t1, 0(\$t0)''',
  '''lw \$v0 , num1
  bne \$s0 , \$s2 , L1
  add \$s0, \$s1, \$t3
  b Exit
  Default :
  move \$s3 , \$zero
  Exit :'''
];

void main() {
  //print(dataTransferExpressionRegex.hasMatch('lw \$1 , 100(\$31)'));
//   tokenize("""lw \$t0, num1
//  lw \$t1, num2
//  add \$t2, \$t0, \$t1
//  sw \$t2, sum """);

  tokenizeAndParse(assemblyCodes[10]);
}
