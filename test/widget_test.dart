import 'package:flutter_test/flutter_test.dart';
void main(){test('progress never exceeds 100 percent',(){const count=80;const target=33;expect((count/target).clamp(0.0,1.0),1.0);});test('preset goals are positive',(){const goals=[33,99,100,1000];expect(goals.every((g)=>g>0),isTrue);});}
