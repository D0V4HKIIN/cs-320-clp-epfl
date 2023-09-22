#include <stdio.h>
#include <stdlib.h>
int a;
#define push stack[stack_pointer++] = 
#define pop stack[--stack_pointer]
#define peek(i) stack[stack_pointer - i]
#define cnst push 
#define drop stack_pointer--
#define getGlobal(i) push globals[i]
#define setGlobal(i) globals[i] = pop
#define getLocal(i) push locals[i]
#define setLocal(i) locals[i] = pop
#define store memory[stack[stack_pointer - 2]] = stack[stack_pointer - 1]; stack_pointer -= 2
#define store8 memory[stack[stack_pointer - 2]] = stack[stack_pointer - 1] & 0x000000ffUL; stack_pointer -= 2
#define load push memory[pop]
#define load8 push *((char*)memory[pop])
#define MAX_STACK_SIZE 10000
int stack[MAX_STACK_SIZE];
int stack_pointer = 0;
int globals[MAX_STACK_SIZE];
char memory[MAX_STACK_SIZE];

void String_concat();
void Std_digitToString();
void Std_printBoolean();
void Std_intToString();
void Std_booleanToString();
void Std_pinMode();
void Std_digitalWrite();
void Std_digitalRead();
void Std_delay();
void Arithmetic_pow();
void Arithmetic_gcd();
void Arithmetic_main();

void Std_printInt(){
	printf("%d\n", pop);
	cnst 0;
}
void Std_printString(){
	printf("%s\n", &memory[pop]);
	cnst 0;
}
void Std_readString(){
	printf("reading string\n");
}
void Std_readInt(){
	printf("reading int\n");
}
void print_state(){
	for(int i = 0; i < stack_pointer; i++){
		printf("%i, ", stack[i]);
	}
	printf("\n");
}
void print_stackpointer(){
	printf("%i\n", stack_pointer);
}
void String_concat() {
  int locals[4] = {peek (2), peek (1), 0, 0};drop;drop;
  getGlobal(0);
  setLocal(3);
  getLocal(0);
  setLocal(2);
  label_1: {
    getLocal(2);
    load; // load8_u
    if (pop){
      getLocal(3);
      getLocal(2);
      load; // load8_u
      store; // store8
      getLocal(3);
      cnst 1;
      push (pop + pop);
      setLocal(3);
      getLocal(2);
      cnst 1;
      push (pop + pop);
      setLocal(2);
      goto label_1;
    } else {
    }
  }
  getLocal(1);
  setLocal(2);
  label_2: {
    getLocal(2);
    load; // load8_u
    if (pop){
      getLocal(3);
      getLocal(2);
      load; // load8_u
      store; // store8
      getLocal(3);
      cnst 1;
      push (pop + pop);
      setLocal(3);
      getLocal(2);
      cnst 1;
      push (pop + pop);
      setLocal(2);
      goto label_2;
    } else {
    }
  }
  label_0: {
    getLocal(3);
    cnst 0;
    store; // store8
    getLocal(3);
    cnst 4;
    a = pop; push (pop % a);
    if (pop){
      getLocal(3);
      cnst 1;
      push (pop + pop);
      setLocal(3);
      goto label_0;
    } else {
    }
  }
  getGlobal(0);
  getLocal(3);
  cnst 1;
  push (pop + pop);
  setGlobal(0);
}
void Std_digitToString() {
  int locals[1] = {peek (1), };drop;
  getGlobal(0);
  getLocal(0);
  cnst 48;
  push (pop + pop);
  store;
  getGlobal(0);
  getGlobal(0);
  cnst 4;
  push (pop + pop);
  setGlobal(0);
}
void Std_printBoolean() {
  int locals[1] = {peek (1), };drop;
  // fn printBoolean(b: Boolean): Unit = {
  //   printString(booleanToString(b))
  // }
  // printString(booleanToString(b))
  // booleanToString(b)
  // b
  getLocal(0);
  Std_booleanToString();
  Std_printString();
}
void Std_intToString() {
  int locals[3] = {peek (1), 0, 0};drop;
  // fn intToString(i: Int(32)): String = {
  //   (if((i < 0)) {
  //     ("-" ++ intToString(-(i)))
  //   } else {
  //     (
  //       val rem: Int(32) =
  //         (i % 10);
  //       val div: Int(32) =
  //         (i / 10);
  //       (if((div == 0)) {
  //         digitToString(rem)
  //       } else {
  //         (intToString(div) ++ digitToString(rem))
  //       })
  //     )
  //   })
  // }
  // (if((i < 0)) {
  //   ("-" ++ intToString(-(i)))
  // } else {
  //   (
  //     val rem: Int(32) =
  //       (i % 10);
  //     val div: Int(32) =
  //       (i / 10);
  //     (if((div == 0)) {
  //       digitToString(rem)
  //     } else {
  //       (intToString(div) ++ digitToString(rem))
  //     })
  //   )
  // })
  // (i < 0)
  // i
  getLocal(0);
  // 0
  cnst 0;
  a = pop; push (pop < a);
  if (pop){
    // ("-" ++ intToString(-(i)))
    // mkString: -
    getGlobal(0);
    cnst 0;
    push (pop + pop);
    cnst 45;
    store; // store8
    getGlobal(0);
    cnst 1;
    push (pop + pop);
    cnst 0;
    store; // store8
    getGlobal(0);
    cnst 2;
    push (pop + pop);
    cnst 0;
    store; // store8
    getGlobal(0);
    cnst 3;
    push (pop + pop);
    cnst 0;
    store; // store8
    getGlobal(0);
    getGlobal(0);
    cnst 4;
    push (pop + pop);
    setGlobal(0);
    // intToString(-(i))
    // -(i)
    // i
    getLocal(0);
    cnst -1;
    push (pop * pop);
    Std_intToString();
    String_concat();
  } else {
    // (
    //   val rem: Int(32) =
    //     (i % 10);
    //   val div: Int(32) =
    //     (i / 10);
    //   (if((div == 0)) {
    //     digitToString(rem)
    //   } else {
    //     (intToString(div) ++ digitToString(rem))
    //   })
    // )
    // (i % 10)
    // i
    getLocal(0);
    // 10
    cnst 10;
    a = pop; push (pop % a);
    setLocal(1);
    // (
    //   val div: Int(32) =
    //     (i / 10);
    //   (if((div == 0)) {
    //     digitToString(rem)
    //   } else {
    //     (intToString(div) ++ digitToString(rem))
    //   })
    // )
    // (i / 10)
    // i
    getLocal(0);
    // 10
    cnst 10;
    a = pop; push (pop / a);
    setLocal(2);
    // (if((div == 0)) {
    //   digitToString(rem)
    // } else {
    //   (intToString(div) ++ digitToString(rem))
    // })
    // (div == 0)
    // div
    getLocal(2);
    // 0
    cnst 0;
    push (pop == pop);
    if (pop){
      // digitToString(rem)
      // rem
      getLocal(1);
      Std_digitToString();
    } else {
      // (intToString(div) ++ digitToString(rem))
      // intToString(div)
      // div
      getLocal(2);
      Std_intToString();
      // digitToString(rem)
      // rem
      getLocal(1);
      Std_digitToString();
      String_concat();
    }
  }
}
void Std_booleanToString() {
  int locals[1] = {peek (1), };drop;
  // fn booleanToString(b: Boolean): String = {
  //   (if(b) {
  //     "true"
  //   } else {
  //     "false"
  //   })
  // }
  // (if(b) {
  //   "true"
  // } else {
  //   "false"
  // })
  // b
  getLocal(0);
  if (pop){
    // mkString: true
    getGlobal(0);
    cnst 0;
    push (pop + pop);
    cnst 116;
    store; // store8
    getGlobal(0);
    cnst 1;
    push (pop + pop);
    cnst 114;
    store; // store8
    getGlobal(0);
    cnst 2;
    push (pop + pop);
    cnst 117;
    store; // store8
    getGlobal(0);
    cnst 3;
    push (pop + pop);
    cnst 101;
    store; // store8
    getGlobal(0);
    cnst 4;
    push (pop + pop);
    cnst 0;
    store; // store8
    getGlobal(0);
    cnst 5;
    push (pop + pop);
    cnst 0;
    store; // store8
    getGlobal(0);
    cnst 6;
    push (pop + pop);
    cnst 0;
    store; // store8
    getGlobal(0);
    cnst 7;
    push (pop + pop);
    cnst 0;
    store; // store8
    getGlobal(0);
    getGlobal(0);
    cnst 8;
    push (pop + pop);
    setGlobal(0);
  } else {
    // mkString: false
    getGlobal(0);
    cnst 0;
    push (pop + pop);
    cnst 102;
    store; // store8
    getGlobal(0);
    cnst 1;
    push (pop + pop);
    cnst 97;
    store; // store8
    getGlobal(0);
    cnst 2;
    push (pop + pop);
    cnst 108;
    store; // store8
    getGlobal(0);
    cnst 3;
    push (pop + pop);
    cnst 115;
    store; // store8
    getGlobal(0);
    cnst 4;
    push (pop + pop);
    cnst 101;
    store; // store8
    getGlobal(0);
    cnst 5;
    push (pop + pop);
    cnst 0;
    store; // store8
    getGlobal(0);
    cnst 6;
    push (pop + pop);
    cnst 0;
    store; // store8
    getGlobal(0);
    cnst 7;
    push (pop + pop);
    cnst 0;
    store; // store8
    getGlobal(0);
    getGlobal(0);
    cnst 8;
    push (pop + pop);
    setGlobal(0);
  }
}
void Std_pinMode() {
  int locals[2] = {peek (2), peek (1), };drop;drop;
  // fn pinMode(a: Int(32), b: Int(32)): Unit = {
  //   error("need to uncomment the implementations in Utils.scala")
  // }
  // error("need to uncomment the implementations in Utils.scala")
  // mkString: need to uncomment the implementations in Utils.scala
  getGlobal(0);
  cnst 0;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 1;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 2;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 3;
  push (pop + pop);
  cnst 100;
  store; // store8
  getGlobal(0);
  cnst 4;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 5;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 6;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 7;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 8;
  push (pop + pop);
  cnst 117;
  store; // store8
  getGlobal(0);
  cnst 9;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 10;
  push (pop + pop);
  cnst 99;
  store; // store8
  getGlobal(0);
  cnst 11;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 13;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 14;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 15;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 16;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 17;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 18;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 19;
  push (pop + pop);
  cnst 104;
  store; // store8
  getGlobal(0);
  cnst 20;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 21;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 22;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 23;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 24;
  push (pop + pop);
  cnst 112;
  store; // store8
  getGlobal(0);
  cnst 25;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 26;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 27;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 28;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 29;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 30;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 31;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 32;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 33;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 34;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 35;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 36;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 37;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 38;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 39;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 40;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 41;
  push (pop + pop);
  cnst 85;
  store; // store8
  getGlobal(0);
  cnst 42;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 43;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 44;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 45;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 46;
  push (pop + pop);
  cnst 46;
  store; // store8
  getGlobal(0);
  cnst 47;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 48;
  push (pop + pop);
  cnst 99;
  store; // store8
  getGlobal(0);
  cnst 49;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 50;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 51;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 52;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 53;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 54;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 55;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  getGlobal(0);
  cnst 56;
  push (pop + pop);
  setGlobal(0);
  Std_printString();
  exit(1);
}
void Std_digitalWrite() {
  int locals[2] = {peek (2), peek (1), };drop;drop;
  // fn digitalWrite(a: Int(32), b: Int(32)): Unit = {
  //   error("need to uncomment the implementations in Utils.scala")
  // }
  // error("need to uncomment the implementations in Utils.scala")
  // mkString: need to uncomment the implementations in Utils.scala
  getGlobal(0);
  cnst 0;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 1;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 2;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 3;
  push (pop + pop);
  cnst 100;
  store; // store8
  getGlobal(0);
  cnst 4;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 5;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 6;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 7;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 8;
  push (pop + pop);
  cnst 117;
  store; // store8
  getGlobal(0);
  cnst 9;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 10;
  push (pop + pop);
  cnst 99;
  store; // store8
  getGlobal(0);
  cnst 11;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 13;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 14;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 15;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 16;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 17;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 18;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 19;
  push (pop + pop);
  cnst 104;
  store; // store8
  getGlobal(0);
  cnst 20;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 21;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 22;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 23;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 24;
  push (pop + pop);
  cnst 112;
  store; // store8
  getGlobal(0);
  cnst 25;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 26;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 27;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 28;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 29;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 30;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 31;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 32;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 33;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 34;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 35;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 36;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 37;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 38;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 39;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 40;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 41;
  push (pop + pop);
  cnst 85;
  store; // store8
  getGlobal(0);
  cnst 42;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 43;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 44;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 45;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 46;
  push (pop + pop);
  cnst 46;
  store; // store8
  getGlobal(0);
  cnst 47;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 48;
  push (pop + pop);
  cnst 99;
  store; // store8
  getGlobal(0);
  cnst 49;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 50;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 51;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 52;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 53;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 54;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 55;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  getGlobal(0);
  cnst 56;
  push (pop + pop);
  setGlobal(0);
  Std_printString();
  exit(1);
}
void Std_digitalRead() {
  int locals[1] = {peek (1), };drop;
  // fn digitalRead(a: Int(32)): Int(32) = {
  //   error("need to uncomment the implementations in Utils.scala")
  // }
  // error("need to uncomment the implementations in Utils.scala")
  // mkString: need to uncomment the implementations in Utils.scala
  getGlobal(0);
  cnst 0;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 1;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 2;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 3;
  push (pop + pop);
  cnst 100;
  store; // store8
  getGlobal(0);
  cnst 4;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 5;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 6;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 7;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 8;
  push (pop + pop);
  cnst 117;
  store; // store8
  getGlobal(0);
  cnst 9;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 10;
  push (pop + pop);
  cnst 99;
  store; // store8
  getGlobal(0);
  cnst 11;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 13;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 14;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 15;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 16;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 17;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 18;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 19;
  push (pop + pop);
  cnst 104;
  store; // store8
  getGlobal(0);
  cnst 20;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 21;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 22;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 23;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 24;
  push (pop + pop);
  cnst 112;
  store; // store8
  getGlobal(0);
  cnst 25;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 26;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 27;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 28;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 29;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 30;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 31;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 32;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 33;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 34;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 35;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 36;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 37;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 38;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 39;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 40;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 41;
  push (pop + pop);
  cnst 85;
  store; // store8
  getGlobal(0);
  cnst 42;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 43;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 44;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 45;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 46;
  push (pop + pop);
  cnst 46;
  store; // store8
  getGlobal(0);
  cnst 47;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 48;
  push (pop + pop);
  cnst 99;
  store; // store8
  getGlobal(0);
  cnst 49;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 50;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 51;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 52;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 53;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 54;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 55;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  getGlobal(0);
  cnst 56;
  push (pop + pop);
  setGlobal(0);
  Std_printString();
  exit(1);
}
void Std_delay() {
  int locals[1] = {peek (1), };drop;
  // fn delay(a: Int(32)): Unit = {
  //   error("need to uncomment the implementations in Utils.scala")
  // }
  // error("need to uncomment the implementations in Utils.scala")
  // mkString: need to uncomment the implementations in Utils.scala
  getGlobal(0);
  cnst 0;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 1;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 2;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 3;
  push (pop + pop);
  cnst 100;
  store; // store8
  getGlobal(0);
  cnst 4;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 5;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 6;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 7;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 8;
  push (pop + pop);
  cnst 117;
  store; // store8
  getGlobal(0);
  cnst 9;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 10;
  push (pop + pop);
  cnst 99;
  store; // store8
  getGlobal(0);
  cnst 11;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 13;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 14;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 15;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 16;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 17;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 18;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 19;
  push (pop + pop);
  cnst 104;
  store; // store8
  getGlobal(0);
  cnst 20;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 21;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 22;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 23;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 24;
  push (pop + pop);
  cnst 112;
  store; // store8
  getGlobal(0);
  cnst 25;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 26;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 27;
  push (pop + pop);
  cnst 109;
  store; // store8
  getGlobal(0);
  cnst 28;
  push (pop + pop);
  cnst 101;
  store; // store8
  getGlobal(0);
  cnst 29;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 30;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 31;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 32;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 33;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 34;
  push (pop + pop);
  cnst 111;
  store; // store8
  getGlobal(0);
  cnst 35;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 36;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 37;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 38;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 39;
  push (pop + pop);
  cnst 110;
  store; // store8
  getGlobal(0);
  cnst 40;
  push (pop + pop);
  cnst 32;
  store; // store8
  getGlobal(0);
  cnst 41;
  push (pop + pop);
  cnst 85;
  store; // store8
  getGlobal(0);
  cnst 42;
  push (pop + pop);
  cnst 116;
  store; // store8
  getGlobal(0);
  cnst 43;
  push (pop + pop);
  cnst 105;
  store; // store8
  getGlobal(0);
  cnst 44;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 45;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 46;
  push (pop + pop);
  cnst 46;
  store; // store8
  getGlobal(0);
  cnst 47;
  push (pop + pop);
  cnst 115;
  store; // store8
  getGlobal(0);
  cnst 48;
  push (pop + pop);
  cnst 99;
  store; // store8
  getGlobal(0);
  cnst 49;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 50;
  push (pop + pop);
  cnst 108;
  store; // store8
  getGlobal(0);
  cnst 51;
  push (pop + pop);
  cnst 97;
  store; // store8
  getGlobal(0);
  cnst 52;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 53;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 54;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  cnst 55;
  push (pop + pop);
  cnst 0;
  store; // store8
  getGlobal(0);
  getGlobal(0);
  cnst 56;
  push (pop + pop);
  setGlobal(0);
  Std_printString();
  exit(1);
}
void Arithmetic_pow() {
  int locals[3] = {peek (2), peek (1), 0};drop;drop;
  // fn pow(b: Int(32), e: Int(32)): Int(32) = {
  //   (if((e == 0)) {
  //     1
  //   } else {
  //     (if(((e % 2) == 0)) {
  //       (
  //         val rec: Int(32) =
  //           pow(b, (e / 2));
  //         (rec * rec)
  //       )
  //     } else {
  //       (b * pow(b, (e - 1)))
  //     })
  //   })
  // }
  // (if((e == 0)) {
  //   1
  // } else {
  //   (if(((e % 2) == 0)) {
  //     (
  //       val rec: Int(32) =
  //         pow(b, (e / 2));
  //       (rec * rec)
  //     )
  //   } else {
  //     (b * pow(b, (e - 1)))
  //   })
  // })
  // (e == 0)
  // e
  getLocal(1);
  // 0
  cnst 0;
  push (pop == pop);
  if (pop){
    // 1
    cnst 1;
  } else {
    // (if(((e % 2) == 0)) {
    //   (
    //     val rec: Int(32) =
    //       pow(b, (e / 2));
    //     (rec * rec)
    //   )
    // } else {
    //   (b * pow(b, (e - 1)))
    // })
    // ((e % 2) == 0)
    // (e % 2)
    // e
    getLocal(1);
    // 2
    cnst 2;
    a = pop; push (pop % a);
    // 0
    cnst 0;
    push (pop == pop);
    if (pop){
      // (
      //   val rec: Int(32) =
      //     pow(b, (e / 2));
      //   (rec * rec)
      // )
      // pow(b, (e / 2))
      // b
      getLocal(0);
      // (e / 2)
      // e
      getLocal(1);
      // 2
      cnst 2;
      a = pop; push (pop / a);
      Arithmetic_pow();
      setLocal(2);
      // (rec * rec)
      // rec
      getLocal(2);
      // rec
      getLocal(2);
      push (pop * pop);
    } else {
      // (b * pow(b, (e - 1)))
      // b
      getLocal(0);
      // pow(b, (e - 1))
      // b
      getLocal(0);
      // (e - 1)
      // e
      getLocal(1);
      // 1
      cnst 1;
      a = pop; push (pop - a);
      Arithmetic_pow();
      push (pop * pop);
    }
  }
}
void Arithmetic_gcd() {
  int locals[2] = {peek (2), peek (1), };drop;drop;
  // fn gcd(a: Int(32), b: Int(32)): Int(32) = {
  //   (if(((a == 0) || (b == 0))) {
  //     (a + b)
  //   } else {
  //     (if((a < b)) {
  //       gcd(a, (b % a))
  //     } else {
  //       gcd((a % b), b)
  //     })
  //   })
  // }
  // (if(((a == 0) || (b == 0))) {
  //   (a + b)
  // } else {
  //   (if((a < b)) {
  //     gcd(a, (b % a))
  //   } else {
  //     gcd((a % b), b)
  //   })
  // })
  // ((a == 0) || (b == 0))
  // (a == 0)
  // a
  getLocal(0);
  // 0
  cnst 0;
  push (pop == pop);
  if (pop){
    cnst 1;
  } else {
    // (b == 0)
    // b
    getLocal(1);
    // 0
    cnst 0;
    push (pop == pop);
  }
  if (pop){
    // (a + b)
    // a
    getLocal(0);
    // b
    getLocal(1);
    push (pop + pop);
  } else {
    // (if((a < b)) {
    //   gcd(a, (b % a))
    // } else {
    //   gcd((a % b), b)
    // })
    // (a < b)
    // a
    getLocal(0);
    // b
    getLocal(1);
    a = pop; push (pop < a);
    if (pop){
      // gcd(a, (b % a))
      // a
      getLocal(0);
      // (b % a)
      // b
      getLocal(1);
      // a
      getLocal(0);
      a = pop; push (pop % a);
      Arithmetic_gcd();
    } else {
      // gcd((a % b), b)
      // (a % b)
      // a
      getLocal(0);
      // b
      getLocal(1);
      a = pop; push (pop % a);
      // b
      getLocal(1);
      Arithmetic_gcd();
    }
  }
}
void main() {
  int locals[0] = {};;
  // printInt(pow(0, 10))
  // printInt(pow(0, 10))
  // pow(0, 10)
  // 0
  cnst 0;
  // 10
  cnst 10;
  Arithmetic_pow();
  Std_printInt();
  drop;
  // (
  //   printInt(pow(1, 5));
  //   printInt(pow(2, 10));
  //   printInt(pow(3, 3));
  //   printInt(gcd(0, 10));
  //   printInt(gcd(17, 99));
  //   printInt(gcd(16, 46));
  //   printInt(gcd(222, 888))
  // )
  // printInt(pow(1, 5))
  // printInt(pow(1, 5))
  // pow(1, 5)
  // 1
  cnst 1;
  // 5
  cnst 5;
  Arithmetic_pow();
  Std_printInt();
  drop;
  // (
  //   printInt(pow(2, 10));
  //   printInt(pow(3, 3));
  //   printInt(gcd(0, 10));
  //   printInt(gcd(17, 99));
  //   printInt(gcd(16, 46));
  //   printInt(gcd(222, 888))
  // )
  // printInt(pow(2, 10))
  // printInt(pow(2, 10))
  // pow(2, 10)
  // 2
  cnst 2;
  // 10
  cnst 10;
  Arithmetic_pow();
  Std_printInt();
  drop;
  // (
  //   printInt(pow(3, 3));
  //   printInt(gcd(0, 10));
  //   printInt(gcd(17, 99));
  //   printInt(gcd(16, 46));
  //   printInt(gcd(222, 888))
  // )
  // printInt(pow(3, 3))
  // printInt(pow(3, 3))
  // pow(3, 3)
  // 3
  cnst 3;
  // 3
  cnst 3;
  Arithmetic_pow();
  Std_printInt();
  drop;
  // (
  //   printInt(gcd(0, 10));
  //   printInt(gcd(17, 99));
  //   printInt(gcd(16, 46));
  //   printInt(gcd(222, 888))
  // )
  // printInt(gcd(0, 10))
  // printInt(gcd(0, 10))
  // gcd(0, 10)
  // 0
  cnst 0;
  // 10
  cnst 10;
  Arithmetic_gcd();
  Std_printInt();
  drop;
  // (
  //   printInt(gcd(17, 99));
  //   printInt(gcd(16, 46));
  //   printInt(gcd(222, 888))
  // )
  // printInt(gcd(17, 99))
  // printInt(gcd(17, 99))
  // gcd(17, 99)
  // 17
  cnst 17;
  // 99
  cnst 99;
  Arithmetic_gcd();
  Std_printInt();
  drop;
  // (
  //   printInt(gcd(16, 46));
  //   printInt(gcd(222, 888))
  // )
  // printInt(gcd(16, 46))
  // printInt(gcd(16, 46))
  // gcd(16, 46)
  // 16
  cnst 16;
  // 46
  cnst 46;
  Arithmetic_gcd();
  Std_printInt();
  drop;
  // printInt(gcd(222, 888))
  // printInt(gcd(222, 888))
  // gcd(222, 888)
  // 222
  cnst 222;
  // 888
  cnst 888;
  Arithmetic_gcd();
  Std_printInt();
  drop;
}