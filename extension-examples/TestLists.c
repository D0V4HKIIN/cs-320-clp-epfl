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
void O_isfnined();
void O_get();
void O_getOrElse();
void O_orElse();
void O_toList();
void L_isEmpty();
void L_length();
void L_head();
void L_headOption();
void L_reverse();
void L_reverseAcc();
void L_indexOf();
void L_range();
void L_sum();
void L_concat();
void L_contains();
void L_merge();
void L_split();
void L_mergeSort();
void L_toString();
void L_toString1();
void L_take();
void TestLists_main();

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
void O_isfnined() {
  int locals[3] = {peek (1), 0, 0};drop;
  // fn isfnined(o: Option): Boolean = {
  //   o match {
  //     case None() =>
  //       false
  //     case _ =>
  //       true
  //   }
  // }
  // o match {
  //   case None() =>
  //     false
  //   case _ =>
  //     true
  // }
  // cg for scrut
  // o
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case None() =>
  //   false
  getLocal(1);
  // None()
  // load the scruts class id
  setLocal(2);
  getLocal(2);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // false
    cnst 0;
  } else {
    // case _ =>
    //   true
    getLocal(1);
    // _
    drop;
    cnst 1;
    if (pop){
      // true
      cnst 1;
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void O_get() {
  int locals[5] = {peek (1), 0, 0, 0, 0};drop;
  // fn get(o: Option): Int(32) = {
  //   o match {
  //     case Some(i) =>
  //       i
  //     case None() =>
  //       error("get(None)")
  //   }
  // }
  // o match {
  //   case Some(i) =>
  //     i
  //   case None() =>
  //     error("get(None)")
  // }
  // cg for scrut
  // o
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Some(i) =>
  //   i
  getLocal(1);
  // Some(i)
  // load the scruts class id
  setLocal(3);
  getLocal(3);
  load;
  // class id
  cnst 1;
  push (pop == pop);
  // put arg on stack instead of scrut
  getLocal(3);
  // index is: 0 for scrut o
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  load;
  // i
  // set idLocal
  setLocal(4);
  cnst 1;
  push (pop && pop);
  if (pop){
    // i
    getLocal(4);
  } else {
    // case None() =>
    //   error("get(None)")
    getLocal(1);
    // None()
    // load the scruts class id
    setLocal(2);
    getLocal(2);
    load;
    // class id
    cnst 0;
    push (pop == pop);
    if (pop){
      // error("get(None)")
      // mkString: get(None)
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 103;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 40;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 78;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 111;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 41;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void O_getOrElse() {
  int locals[6] = {peek (2), peek (1), 0, 0, 0, 0};drop;drop;
  // fn getOrElse(o: Option, i: Int(32)): Int(32) = {
  //   o match {
  //     case None() =>
  //       i
  //     case Some(oo) =>
  //       oo
  //   }
  // }
  // o match {
  //   case None() =>
  //     i
  //   case Some(oo) =>
  //     oo
  // }
  // cg for scrut
  // o
  getLocal(0);
  setLocal(2);
  // finished code for scrut
  // case None() =>
  //   i
  getLocal(2);
  // None()
  // load the scruts class id
  setLocal(5);
  getLocal(5);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // i
    getLocal(1);
  } else {
    // case Some(oo) =>
    //   oo
    getLocal(2);
    // Some(oo)
    // load the scruts class id
    setLocal(3);
    getLocal(3);
    load;
    // class id
    cnst 1;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 0 for scrut o
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // oo
    // set idLocal
    setLocal(4);
    cnst 1;
    push (pop && pop);
    if (pop){
      // oo
      getLocal(4);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void O_orElse() {
  int locals[5] = {peek (2), peek (1), 0, 0, 0};drop;drop;
  // fn orElse(o1: Option, o2: Option): Option = {
  //   o1 match {
  //     case Some(_) =>
  //       o1
  //     case None() =>
  //       o2
  //   }
  // }
  // o1 match {
  //   case Some(_) =>
  //     o1
  //   case None() =>
  //     o2
  // }
  // cg for scrut
  // o1
  getLocal(0);
  setLocal(2);
  // finished code for scrut
  // case Some(_) =>
  //   o1
  getLocal(2);
  // Some(_)
  // load the scruts class id
  setLocal(4);
  getLocal(4);
  load;
  // class id
  cnst 1;
  push (pop == pop);
  // put arg on stack instead of scrut
  getLocal(4);
  // index is: 0 for scrut o1
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  load;
  // _
  drop;
  cnst 1;
  push (pop && pop);
  if (pop){
    // o1
    getLocal(0);
  } else {
    // case None() =>
    //   o2
    getLocal(2);
    // None()
    // load the scruts class id
    setLocal(3);
    getLocal(3);
    load;
    // class id
    cnst 0;
    push (pop == pop);
    if (pop){
      // o2
      getLocal(1);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void O_toList() {
  int locals[8] = {peek (1), 0, 0, 0, 0, 0, 0, 0};drop;
  // fn toList(o: Option): List = {
  //   o match {
  //     case Some(i) =>
  //       Cons(i, Nil())
  //     case None() =>
  //       Nil()
  //   }
  // }
  // o match {
  //   case Some(i) =>
  //     Cons(i, Nil())
  //   case None() =>
  //     Nil()
  // }
  // cg for scrut
  // o
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Some(i) =>
  //   Cons(i, Nil())
  getLocal(1);
  // Some(i)
  // load the scruts class id
  setLocal(4);
  getLocal(4);
  load;
  // class id
  cnst 1;
  push (pop == pop);
  // put arg on stack instead of scrut
  getLocal(4);
  // index is: 0 for scrut o
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  load;
  // i
  // set idLocal
  setLocal(5);
  cnst 1;
  push (pop && pop);
  if (pop){
    // Cons(i, Nil())
    // save memory boundary as this is the pointer to the class
    getGlobal(0);
    setLocal(6);
    // update memboundary (constr)
    getGlobal(0);
    cnst 12;
    push (pop + pop);
    setGlobal(0);
    // put constructor id at the address
    getLocal(6);
    cnst 1;
    store;
    // put arguments after the id
    // i
    // get field for argument
    getLocal(6);
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    // eval argument: i
    // i
    getLocal(5);
    store;
    // Nil()
    // get field for argument
    getLocal(6);
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    // eval argument: Nil()
    // Nil()
    // save memory boundary as this is the pointer to the class
    getGlobal(0);
    setLocal(7);
    // update memboundary (constr)
    getGlobal(0);
    cnst 4;
    push (pop + pop);
    setGlobal(0);
    // put constructor id at the address
    getLocal(7);
    cnst 0;
    store;
    // put arguments after the id
    // put the pointer of the class to the stack (addr)
    getLocal(7);
    store;
    // put the pointer of the class to the stack (addr)
    getLocal(6);
  } else {
    // case None() =>
    //   Nil()
    getLocal(1);
    // None()
    // load the scruts class id
    setLocal(2);
    getLocal(2);
    load;
    // class id
    cnst 0;
    push (pop == pop);
    if (pop){
      // Nil()
      // save memory boundary as this is the pointer to the class
      getGlobal(0);
      setLocal(3);
      // update memboundary (constr)
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      setGlobal(0);
      // put constructor id at the address
      getLocal(3);
      cnst 0;
      store;
      // put arguments after the id
      // put the pointer of the class to the stack (addr)
      getLocal(3);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_isEmpty() {
  int locals[3] = {peek (1), 0, 0};drop;
  // fn isEmpty(l: List): Boolean = {
  //   l match {
  //     case Nil() =>
  //       true
  //     case _ =>
  //       false
  //   }
  // }
  // l match {
  //   case Nil() =>
  //     true
  //   case _ =>
  //     false
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Nil() =>
  //   true
  getLocal(1);
  // Nil()
  // load the scruts class id
  setLocal(2);
  getLocal(2);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // true
    cnst 1;
  } else {
    // case _ =>
    //   false
    getLocal(1);
    // _
    drop;
    cnst 1;
    if (pop){
      // false
      cnst 0;
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_length() {
  int locals[5] = {peek (1), 0, 0, 0, 0};drop;
  // fn length(l: List): Int(32) = {
  //   l match {
  //     case Nil() =>
  //       0
  //     case Cons(_, t) =>
  //       (1 + length(t))
  //   }
  // }
  // l match {
  //   case Nil() =>
  //     0
  //   case Cons(_, t) =>
  //     (1 + length(t))
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Nil() =>
  //   0
  getLocal(1);
  // Nil()
  // load the scruts class id
  setLocal(4);
  getLocal(4);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // 0
    cnst 0;
  } else {
    // case Cons(_, t) =>
    //   (1 + length(t))
    getLocal(1);
    // Cons(_, t)
    // load the scruts class id
    setLocal(2);
    getLocal(2);
    load;
    // class id
    cnst 1;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(2);
    // index is: 0 for scrut l
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // _
    drop;
    cnst 1;
    push (pop && pop);
    // put arg on stack instead of scrut
    getLocal(2);
    // index is: 1 for scrut l
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    load;
    // t
    // set idLocal
    setLocal(3);
    cnst 1;
    push (pop && pop);
    if (pop){
      // (1 + length(t))
      // 1
      cnst 1;
      // length(t)
      // t
      getLocal(3);
      L_length();
      push (pop + pop);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_head() {
  int locals[5] = {peek (1), 0, 0, 0, 0};drop;
  // fn head(l: List): Int(32) = {
  //   l match {
  //     case Cons(h, _) =>
  //       h
  //     case Nil() =>
  //       error("head(Nil)")
  //   }
  // }
  // l match {
  //   case Cons(h, _) =>
  //     h
  //   case Nil() =>
  //     error("head(Nil)")
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Cons(h, _) =>
  //   h
  getLocal(1);
  // Cons(h, _)
  // load the scruts class id
  setLocal(3);
  getLocal(3);
  load;
  // class id
  cnst 1;
  push (pop == pop);
  // put arg on stack instead of scrut
  getLocal(3);
  // index is: 0 for scrut l
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  load;
  // h
  // set idLocal
  setLocal(4);
  cnst 1;
  push (pop && pop);
  // put arg on stack instead of scrut
  getLocal(3);
  // index is: 1 for scrut l
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  load;
  // _
  drop;
  cnst 1;
  push (pop && pop);
  if (pop){
    // h
    getLocal(4);
  } else {
    // case Nil() =>
    //   error("head(Nil)")
    getLocal(1);
    // Nil()
    // load the scruts class id
    setLocal(2);
    getLocal(2);
    load;
    // class id
    cnst 0;
    push (pop == pop);
    if (pop){
      // error("head(Nil)")
      // mkString: head(Nil)
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 40;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 78;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 108;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 41;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_headOption() {
  int locals[7] = {peek (1), 0, 0, 0, 0, 0, 0};drop;
  // fn headOption(l: List): Option = {
  //   l match {
  //     case Cons(h, _) =>
  //       Some(h)
  //     case Nil() =>
  //       None()
  //   }
  // }
  // l match {
  //   case Cons(h, _) =>
  //     Some(h)
  //   case Nil() =>
  //     None()
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Cons(h, _) =>
  //   Some(h)
  getLocal(1);
  // Cons(h, _)
  // load the scruts class id
  setLocal(4);
  getLocal(4);
  load;
  // class id
  cnst 1;
  push (pop == pop);
  // put arg on stack instead of scrut
  getLocal(4);
  // index is: 0 for scrut l
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  load;
  // h
  // set idLocal
  setLocal(5);
  cnst 1;
  push (pop && pop);
  // put arg on stack instead of scrut
  getLocal(4);
  // index is: 1 for scrut l
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  load;
  // _
  drop;
  cnst 1;
  push (pop && pop);
  if (pop){
    // Some(h)
    // save memory boundary as this is the pointer to the class
    getGlobal(0);
    setLocal(6);
    // update memboundary (constr)
    getGlobal(0);
    cnst 8;
    push (pop + pop);
    setGlobal(0);
    // put constructor id at the address
    getLocal(6);
    cnst 1;
    store;
    // put arguments after the id
    // h
    // get field for argument
    getLocal(6);
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    // eval argument: h
    // h
    getLocal(5);
    store;
    // put the pointer of the class to the stack (addr)
    getLocal(6);
  } else {
    // case Nil() =>
    //   None()
    getLocal(1);
    // Nil()
    // load the scruts class id
    setLocal(2);
    getLocal(2);
    load;
    // class id
    cnst 0;
    push (pop == pop);
    if (pop){
      // None()
      // save memory boundary as this is the pointer to the class
      getGlobal(0);
      setLocal(3);
      // update memboundary (constr)
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      setGlobal(0);
      // put constructor id at the address
      getLocal(3);
      cnst 0;
      store;
      // put arguments after the id
      // put the pointer of the class to the stack (addr)
      getLocal(3);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_reverse() {
  int locals[2] = {peek (1), 0};drop;
  // fn reverse(l: List): List = {
  //   reverseAcc(l, Nil())
  // }
  // reverseAcc(l, Nil())
  // l
  getLocal(0);
  // Nil()
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(1);
  // update memboundary (constr)
  getGlobal(0);
  cnst 4;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(1);
  cnst 0;
  store;
  // put arguments after the id
  // put the pointer of the class to the stack (addr)
  getLocal(1);
  L_reverseAcc();
}
void L_reverseAcc() {
  int locals[8] = {peek (2), peek (1), 0, 0, 0, 0, 0, 0};drop;drop;
  // fn reverseAcc(l: List, acc: List): List = {
  //   l match {
  //     case Nil() =>
  //       acc
  //     case Cons(h, t) =>
  //       reverseAcc(t, Cons(h, acc))
  //   }
  // }
  // l match {
  //   case Nil() =>
  //     acc
  //   case Cons(h, t) =>
  //     reverseAcc(t, Cons(h, acc))
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(2);
  // finished code for scrut
  // case Nil() =>
  //   acc
  getLocal(2);
  // Nil()
  // load the scruts class id
  setLocal(7);
  getLocal(7);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // acc
    getLocal(1);
  } else {
    // case Cons(h, t) =>
    //   reverseAcc(t, Cons(h, acc))
    getLocal(2);
    // Cons(h, t)
    // load the scruts class id
    setLocal(3);
    getLocal(3);
    load;
    // class id
    cnst 1;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 0 for scrut l
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // h
    // set idLocal
    setLocal(4);
    cnst 1;
    push (pop && pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 1 for scrut l
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    load;
    // t
    // set idLocal
    setLocal(5);
    cnst 1;
    push (pop && pop);
    if (pop){
      // reverseAcc(t, Cons(h, acc))
      // t
      getLocal(5);
      // Cons(h, acc)
      // save memory boundary as this is the pointer to the class
      getGlobal(0);
      setLocal(6);
      // update memboundary (constr)
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      setGlobal(0);
      // put constructor id at the address
      getLocal(6);
      cnst 1;
      store;
      // put arguments after the id
      // h
      // get field for argument
      getLocal(6);
      // adtField index: 0
      cnst 4;
      push (pop + pop);
      // eval argument: h
      // h
      getLocal(4);
      store;
      // acc
      // get field for argument
      getLocal(6);
      // adtField index: 1
      cnst 8;
      push (pop + pop);
      // eval argument: acc
      // acc
      getLocal(1);
      store;
      // put the pointer of the class to the stack (addr)
      getLocal(6);
      L_reverseAcc();
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_indexOf() {
  int locals[8] = {peek (2), peek (1), 0, 0, 0, 0, 0, 0};drop;drop;
  // fn indexOf(l: List, i: Int(32)): Int(32) = {
  //   l match {
  //     case Nil() =>
  //       -(1)
  //     case Cons(h, t) =>
  //       (if((h == i)) {
  //         0
  //       } else {
  //         (
  //           val rec: Int(32) =
  //             indexOf(t, i);
  //           (if((0 <= rec)) {
  //             (rec + 1)
  //           } else {
  //             -(1)
  //           })
  //         )
  //       })
  //   }
  // }
  // l match {
  //   case Nil() =>
  //     -(1)
  //   case Cons(h, t) =>
  //     (if((h == i)) {
  //       0
  //     } else {
  //       (
  //         val rec: Int(32) =
  //           indexOf(t, i);
  //         (if((0 <= rec)) {
  //           (rec + 1)
  //         } else {
  //           -(1)
  //         })
  //       )
  //     })
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(2);
  // finished code for scrut
  // case Nil() =>
  //   -(1)
  getLocal(2);
  // Nil()
  // load the scruts class id
  setLocal(7);
  getLocal(7);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // -(1)
    // 1
    cnst 1;
    cnst -1;
    push (pop * pop);
  } else {
    // case Cons(h, t) =>
    //   (if((h == i)) {
    //     0
    //   } else {
    //     (
    //       val rec: Int(32) =
    //         indexOf(t, i);
    //       (if((0 <= rec)) {
    //         (rec + 1)
    //       } else {
    //         -(1)
    //       })
    //     )
    //   })
    getLocal(2);
    // Cons(h, t)
    // load the scruts class id
    setLocal(3);
    getLocal(3);
    load;
    // class id
    cnst 1;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 0 for scrut l
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // h
    // set idLocal
    setLocal(4);
    cnst 1;
    push (pop && pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 1 for scrut l
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    load;
    // t
    // set idLocal
    setLocal(5);
    cnst 1;
    push (pop && pop);
    if (pop){
      // (if((h == i)) {
      //   0
      // } else {
      //   (
      //     val rec: Int(32) =
      //       indexOf(t, i);
      //     (if((0 <= rec)) {
      //       (rec + 1)
      //     } else {
      //       -(1)
      //     })
      //   )
      // })
      // (h == i)
      // h
      getLocal(4);
      // i
      getLocal(1);
      push (pop == pop);
      if (pop){
        // 0
        cnst 0;
      } else {
        // (
        //   val rec: Int(32) =
        //     indexOf(t, i);
        //   (if((0 <= rec)) {
        //     (rec + 1)
        //   } else {
        //     -(1)
        //   })
        // )
        // indexOf(t, i)
        // t
        getLocal(5);
        // i
        getLocal(1);
        L_indexOf();
        setLocal(6);
        // (if((0 <= rec)) {
        //   (rec + 1)
        // } else {
        //   -(1)
        // })
        // (0 <= rec)
        // 0
        cnst 0;
        // rec
        getLocal(6);
        a = pop; push (pop <= a);
        if (pop){
          // (rec + 1)
          // rec
          getLocal(6);
          // 1
          cnst 1;
          push (pop + pop);
        } else {
          // -(1)
          // 1
          cnst 1;
          cnst -1;
          push (pop * pop);
        }
      }
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_range() {
  int locals[4] = {peek (2), peek (1), 0, 0};drop;drop;
  // fn range(from: Int(32), to: Int(32)): List = {
  //   (if((to < from)) {
  //     Nil()
  //   } else {
  //     Cons(from, range((from + 1), to))
  //   })
  // }
  // (if((to < from)) {
  //   Nil()
  // } else {
  //   Cons(from, range((from + 1), to))
  // })
  // (to < from)
  // to
  getLocal(1);
  // from
  getLocal(0);
  a = pop; push (pop < a);
  if (pop){
    // Nil()
    // save memory boundary as this is the pointer to the class
    getGlobal(0);
    setLocal(2);
    // update memboundary (constr)
    getGlobal(0);
    cnst 4;
    push (pop + pop);
    setGlobal(0);
    // put constructor id at the address
    getLocal(2);
    cnst 0;
    store;
    // put arguments after the id
    // put the pointer of the class to the stack (addr)
    getLocal(2);
  } else {
    // Cons(from, range((from + 1), to))
    // save memory boundary as this is the pointer to the class
    getGlobal(0);
    setLocal(3);
    // update memboundary (constr)
    getGlobal(0);
    cnst 12;
    push (pop + pop);
    setGlobal(0);
    // put constructor id at the address
    getLocal(3);
    cnst 1;
    store;
    // put arguments after the id
    // from
    // get field for argument
    getLocal(3);
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    // eval argument: from
    // from
    getLocal(0);
    store;
    // range((from + 1), to)
    // get field for argument
    getLocal(3);
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    // eval argument: range((from + 1), to)
    // range((from + 1), to)
    // (from + 1)
    // from
    getLocal(0);
    // 1
    cnst 1;
    push (pop + pop);
    // to
    getLocal(1);
    L_range();
    store;
    // put the pointer of the class to the stack (addr)
    getLocal(3);
  }
}
void L_sum() {
  int locals[6] = {peek (1), 0, 0, 0, 0, 0};drop;
  // fn sum(l: List): Int(32) = {
  //   l match {
  //     case Nil() =>
  //       0
  //     case Cons(h, t) =>
  //       (h + sum(t))
  //   }
  // }
  // l match {
  //   case Nil() =>
  //     0
  //   case Cons(h, t) =>
  //     (h + sum(t))
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Nil() =>
  //   0
  getLocal(1);
  // Nil()
  // load the scruts class id
  setLocal(5);
  getLocal(5);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // 0
    cnst 0;
  } else {
    // case Cons(h, t) =>
    //   (h + sum(t))
    getLocal(1);
    // Cons(h, t)
    // load the scruts class id
    setLocal(2);
    getLocal(2);
    load;
    // class id
    cnst 1;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(2);
    // index is: 0 for scrut l
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // h
    // set idLocal
    setLocal(3);
    cnst 1;
    push (pop && pop);
    // put arg on stack instead of scrut
    getLocal(2);
    // index is: 1 for scrut l
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    load;
    // t
    // set idLocal
    setLocal(4);
    cnst 1;
    push (pop && pop);
    if (pop){
      // (h + sum(t))
      // h
      getLocal(3);
      // sum(t)
      // t
      getLocal(4);
      L_sum();
      push (pop + pop);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_concat() {
  int locals[8] = {peek (2), peek (1), 0, 0, 0, 0, 0, 0};drop;drop;
  // fn concat(l1: List, l2: List): List = {
  //   l1 match {
  //     case Nil() =>
  //       l2
  //     case Cons(h, t) =>
  //       Cons(h, concat(t, l2))
  //   }
  // }
  // l1 match {
  //   case Nil() =>
  //     l2
  //   case Cons(h, t) =>
  //     Cons(h, concat(t, l2))
  // }
  // cg for scrut
  // l1
  getLocal(0);
  setLocal(2);
  // finished code for scrut
  // case Nil() =>
  //   l2
  getLocal(2);
  // Nil()
  // load the scruts class id
  setLocal(7);
  getLocal(7);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // l2
    getLocal(1);
  } else {
    // case Cons(h, t) =>
    //   Cons(h, concat(t, l2))
    getLocal(2);
    // Cons(h, t)
    // load the scruts class id
    setLocal(3);
    getLocal(3);
    load;
    // class id
    cnst 1;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 0 for scrut l1
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // h
    // set idLocal
    setLocal(4);
    cnst 1;
    push (pop && pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 1 for scrut l1
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    load;
    // t
    // set idLocal
    setLocal(5);
    cnst 1;
    push (pop && pop);
    if (pop){
      // Cons(h, concat(t, l2))
      // save memory boundary as this is the pointer to the class
      getGlobal(0);
      setLocal(6);
      // update memboundary (constr)
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      setGlobal(0);
      // put constructor id at the address
      getLocal(6);
      cnst 1;
      store;
      // put arguments after the id
      // h
      // get field for argument
      getLocal(6);
      // adtField index: 0
      cnst 4;
      push (pop + pop);
      // eval argument: h
      // h
      getLocal(4);
      store;
      // concat(t, l2)
      // get field for argument
      getLocal(6);
      // adtField index: 1
      cnst 8;
      push (pop + pop);
      // eval argument: concat(t, l2)
      // concat(t, l2)
      // t
      getLocal(5);
      // l2
      getLocal(1);
      L_concat();
      store;
      // put the pointer of the class to the stack (addr)
      getLocal(6);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_contains() {
  int locals[7] = {peek (2), peek (1), 0, 0, 0, 0, 0};drop;drop;
  // fn contains(l: List, elem: Int(32)): Boolean = {
  //   l match {
  //     case Nil() =>
  //       false
  //     case Cons(h, t) =>
  //       ((h == elem) || contains(t, elem))
  //   }
  // }
  // l match {
  //   case Nil() =>
  //     false
  //   case Cons(h, t) =>
  //     ((h == elem) || contains(t, elem))
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(2);
  // finished code for scrut
  // case Nil() =>
  //   false
  getLocal(2);
  // Nil()
  // load the scruts class id
  setLocal(6);
  getLocal(6);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // false
    cnst 0;
  } else {
    // case Cons(h, t) =>
    //   ((h == elem) || contains(t, elem))
    getLocal(2);
    // Cons(h, t)
    // load the scruts class id
    setLocal(3);
    getLocal(3);
    load;
    // class id
    cnst 1;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 0 for scrut l
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // h
    // set idLocal
    setLocal(4);
    cnst 1;
    push (pop && pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 1 for scrut l
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    load;
    // t
    // set idLocal
    setLocal(5);
    cnst 1;
    push (pop && pop);
    if (pop){
      // ((h == elem) || contains(t, elem))
      // (h == elem)
      // h
      getLocal(4);
      // elem
      getLocal(1);
      push (pop == pop);
      if (pop){
        cnst 1;
      } else {
        // contains(t, elem)
        // t
        getLocal(5);
        // elem
        getLocal(1);
        L_contains();
      }
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_merge() {
  int locals[14] = {peek (2), peek (1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};drop;drop;
  // fn merge(l1: List, l2: List): List = {
  //   l1 match {
  //     case Nil() =>
  //       l2
  //     case Cons(h1, t1) =>
  //       l2 match {
  //         case Nil() =>
  //           l1
  //         case Cons(h2, t2) =>
  //           (if((h1 <= h2)) {
  //             Cons(h1, merge(t1, l2))
  //           } else {
  //             Cons(h2, merge(l1, t2))
  //           })
  //       }
  //   }
  // }
  // l1 match {
  //   case Nil() =>
  //     l2
  //   case Cons(h1, t1) =>
  //     l2 match {
  //       case Nil() =>
  //         l1
  //       case Cons(h2, t2) =>
  //         (if((h1 <= h2)) {
  //           Cons(h1, merge(t1, l2))
  //         } else {
  //           Cons(h2, merge(l1, t2))
  //         })
  //     }
  // }
  // cg for scrut
  // l1
  getLocal(0);
  setLocal(2);
  // finished code for scrut
  // case Nil() =>
  //   l2
  getLocal(2);
  // Nil()
  // load the scruts class id
  setLocal(13);
  getLocal(13);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // l2
    getLocal(1);
  } else {
    // case Cons(h1, t1) =>
    //   l2 match {
    //     case Nil() =>
    //       l1
    //     case Cons(h2, t2) =>
    //       (if((h1 <= h2)) {
    //         Cons(h1, merge(t1, l2))
    //       } else {
    //         Cons(h2, merge(l1, t2))
    //       })
    //   }
    getLocal(2);
    // Cons(h1, t1)
    // load the scruts class id
    setLocal(3);
    getLocal(3);
    load;
    // class id
    cnst 1;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 0 for scrut l1
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // h1
    // set idLocal
    setLocal(4);
    cnst 1;
    push (pop && pop);
    // put arg on stack instead of scrut
    getLocal(3);
    // index is: 1 for scrut l1
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    load;
    // t1
    // set idLocal
    setLocal(5);
    cnst 1;
    push (pop && pop);
    if (pop){
      // l2 match {
      //   case Nil() =>
      //     l1
      //   case Cons(h2, t2) =>
      //     (if((h1 <= h2)) {
      //       Cons(h1, merge(t1, l2))
      //     } else {
      //       Cons(h2, merge(l1, t2))
      //     })
      // }
      // cg for scrut
      // l2
      getLocal(1);
      setLocal(6);
      // finished code for scrut
      // case Nil() =>
      //   l1
      getLocal(6);
      // Nil()
      // load the scruts class id
      setLocal(12);
      getLocal(12);
      load;
      // class id
      cnst 0;
      push (pop == pop);
      if (pop){
        // l1
        getLocal(0);
      } else {
        // case Cons(h2, t2) =>
        //   (if((h1 <= h2)) {
        //     Cons(h1, merge(t1, l2))
        //   } else {
        //     Cons(h2, merge(l1, t2))
        //   })
        getLocal(6);
        // Cons(h2, t2)
        // load the scruts class id
        setLocal(7);
        getLocal(7);
        load;
        // class id
        cnst 1;
        push (pop == pop);
        // put arg on stack instead of scrut
        getLocal(7);
        // index is: 0 for scrut l2
        // adtField index: 0
        cnst 4;
        push (pop + pop);
        load;
        // h2
        // set idLocal
        setLocal(8);
        cnst 1;
        push (pop && pop);
        // put arg on stack instead of scrut
        getLocal(7);
        // index is: 1 for scrut l2
        // adtField index: 1
        cnst 8;
        push (pop + pop);
        load;
        // t2
        // set idLocal
        setLocal(9);
        cnst 1;
        push (pop && pop);
        if (pop){
          // (if((h1 <= h2)) {
          //   Cons(h1, merge(t1, l2))
          // } else {
          //   Cons(h2, merge(l1, t2))
          // })
          // (h1 <= h2)
          // h1
          getLocal(4);
          // h2
          getLocal(8);
          a = pop; push (pop <= a);
          if (pop){
            // Cons(h1, merge(t1, l2))
            // save memory boundary as this is the pointer to the class
            getGlobal(0);
            setLocal(10);
            // update memboundary (constr)
            getGlobal(0);
            cnst 12;
            push (pop + pop);
            setGlobal(0);
            // put constructor id at the address
            getLocal(10);
            cnst 1;
            store;
            // put arguments after the id
            // h1
            // get field for argument
            getLocal(10);
            // adtField index: 0
            cnst 4;
            push (pop + pop);
            // eval argument: h1
            // h1
            getLocal(4);
            store;
            // merge(t1, l2)
            // get field for argument
            getLocal(10);
            // adtField index: 1
            cnst 8;
            push (pop + pop);
            // eval argument: merge(t1, l2)
            // merge(t1, l2)
            // t1
            getLocal(5);
            // l2
            getLocal(1);
            L_merge();
            store;
            // put the pointer of the class to the stack (addr)
            getLocal(10);
          } else {
            // Cons(h2, merge(l1, t2))
            // save memory boundary as this is the pointer to the class
            getGlobal(0);
            setLocal(11);
            // update memboundary (constr)
            getGlobal(0);
            cnst 12;
            push (pop + pop);
            setGlobal(0);
            // put constructor id at the address
            getLocal(11);
            cnst 1;
            store;
            // put arguments after the id
            // h2
            // get field for argument
            getLocal(11);
            // adtField index: 0
            cnst 4;
            push (pop + pop);
            // eval argument: h2
            // h2
            getLocal(8);
            store;
            // merge(l1, t2)
            // get field for argument
            getLocal(11);
            // adtField index: 1
            cnst 8;
            push (pop + pop);
            // eval argument: merge(l1, t2)
            // merge(l1, t2)
            // l1
            getLocal(0);
            // t2
            getLocal(9);
            L_merge();
            store;
            // put the pointer of the class to the stack (addr)
            getLocal(11);
          }
        } else {
          // error("didn't match any cases")
          // mkString: didn't match any cases
          getGlobal(0);
          cnst 0;
          push (pop + pop);
          cnst 100;
          store; // store8
          getGlobal(0);
          cnst 1;
          push (pop + pop);
          cnst 105;
          store; // store8
          getGlobal(0);
          cnst 2;
          push (pop + pop);
          cnst 100;
          store; // store8
          getGlobal(0);
          cnst 3;
          push (pop + pop);
          cnst 110;
          store; // store8
          getGlobal(0);
          cnst 4;
          push (pop + pop);
          cnst 39;
          store; // store8
          getGlobal(0);
          cnst 5;
          push (pop + pop);
          cnst 116;
          store; // store8
          getGlobal(0);
          cnst 6;
          push (pop + pop);
          cnst 32;
          store; // store8
          getGlobal(0);
          cnst 7;
          push (pop + pop);
          cnst 109;
          store; // store8
          getGlobal(0);
          cnst 8;
          push (pop + pop);
          cnst 97;
          store; // store8
          getGlobal(0);
          cnst 9;
          push (pop + pop);
          cnst 116;
          store; // store8
          getGlobal(0);
          cnst 10;
          push (pop + pop);
          cnst 99;
          store; // store8
          getGlobal(0);
          cnst 11;
          push (pop + pop);
          cnst 104;
          store; // store8
          getGlobal(0);
          cnst 12;
          push (pop + pop);
          cnst 32;
          store; // store8
          getGlobal(0);
          cnst 13;
          push (pop + pop);
          cnst 97;
          store; // store8
          getGlobal(0);
          cnst 14;
          push (pop + pop);
          cnst 110;
          store; // store8
          getGlobal(0);
          cnst 15;
          push (pop + pop);
          cnst 121;
          store; // store8
          getGlobal(0);
          cnst 16;
          push (pop + pop);
          cnst 32;
          store; // store8
          getGlobal(0);
          cnst 17;
          push (pop + pop);
          cnst 99;
          store; // store8
          getGlobal(0);
          cnst 18;
          push (pop + pop);
          cnst 97;
          store; // store8
          getGlobal(0);
          cnst 19;
          push (pop + pop);
          cnst 115;
          store; // store8
          getGlobal(0);
          cnst 20;
          push (pop + pop);
          cnst 101;
          store; // store8
          getGlobal(0);
          cnst 21;
          push (pop + pop);
          cnst 115;
          store; // store8
          getGlobal(0);
          cnst 22;
          push (pop + pop);
          cnst 0;
          store; // store8
          getGlobal(0);
          cnst 23;
          push (pop + pop);
          cnst 0;
          store; // store8
          getGlobal(0);
          getGlobal(0);
          cnst 24;
          push (pop + pop);
          setGlobal(0);
          Std_printString();
          exit(1);
          exit(1);
        }
      }
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_split() {
  int locals[17] = {peek (1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};drop;
  // fn split(l: List): LPair = {
  //   l match {
  //     case Cons(h1, Cons(h2, t)) =>
  //       (
  //         val rec: LPair =
  //           split(t);
  //         rec match {
  //           case LP(rec1, rec2) =>
  //             LP(Cons(h1, rec1), Cons(h2, rec2))
  //         }
  //       )
  //     case _ =>
  //       LP(l, Nil())
  //   }
  // }
  // l match {
  //   case Cons(h1, Cons(h2, t)) =>
  //     (
  //       val rec: LPair =
  //         split(t);
  //       rec match {
  //         case LP(rec1, rec2) =>
  //           LP(Cons(h1, rec1), Cons(h2, rec2))
  //       }
  //     )
  //   case _ =>
  //     LP(l, Nil())
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Cons(h1, Cons(h2, t)) =>
  //   (
  //     val rec: LPair =
  //       split(t);
  //     rec match {
  //       case LP(rec1, rec2) =>
  //         LP(Cons(h1, rec1), Cons(h2, rec2))
  //     }
  //   )
  getLocal(1);
  // Cons(h1, Cons(h2, t))
  // load the scruts class id
  setLocal(4);
  getLocal(4);
  load;
  // class id
  cnst 1;
  push (pop == pop);
  // put arg on stack instead of scrut
  getLocal(4);
  // index is: 0 for scrut l
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  load;
  // h1
  // set idLocal
  setLocal(5);
  cnst 1;
  push (pop && pop);
  // put arg on stack instead of scrut
  getLocal(4);
  // index is: 1 for scrut l
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  load;
  // Cons(h2, t)
  // load the scruts class id
  setLocal(6);
  getLocal(6);
  load;
  // class id
  cnst 1;
  push (pop == pop);
  // put arg on stack instead of scrut
  getLocal(6);
  // index is: 0 for scrut l
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  load;
  // h2
  // set idLocal
  setLocal(7);
  cnst 1;
  push (pop && pop);
  // put arg on stack instead of scrut
  getLocal(6);
  // index is: 1 for scrut l
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  load;
  // t
  // set idLocal
  setLocal(8);
  cnst 1;
  push (pop && pop);
  push (pop && pop);
  if (pop){
    // (
    //   val rec: LPair =
    //     split(t);
    //   rec match {
    //     case LP(rec1, rec2) =>
    //       LP(Cons(h1, rec1), Cons(h2, rec2))
    //   }
    // )
    // split(t)
    // t
    getLocal(8);
    L_split();
    setLocal(9);
    // rec match {
    //   case LP(rec1, rec2) =>
    //     LP(Cons(h1, rec1), Cons(h2, rec2))
    // }
    // cg for scrut
    // rec
    getLocal(9);
    setLocal(10);
    // finished code for scrut
    // case LP(rec1, rec2) =>
    //   LP(Cons(h1, rec1), Cons(h2, rec2))
    getLocal(10);
    // LP(rec1, rec2)
    // load the scruts class id
    setLocal(11);
    getLocal(11);
    load;
    // class id
    cnst 0;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(11);
    // index is: 0 for scrut rec
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // rec1
    // set idLocal
    setLocal(12);
    cnst 1;
    push (pop && pop);
    // put arg on stack instead of scrut
    getLocal(11);
    // index is: 1 for scrut rec
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    load;
    // rec2
    // set idLocal
    setLocal(13);
    cnst 1;
    push (pop && pop);
    if (pop){
      // LP(Cons(h1, rec1), Cons(h2, rec2))
      // save memory boundary as this is the pointer to the class
      getGlobal(0);
      setLocal(14);
      // update memboundary (constr)
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      setGlobal(0);
      // put constructor id at the address
      getLocal(14);
      cnst 0;
      store;
      // put arguments after the id
      // Cons(h1, rec1)
      // get field for argument
      getLocal(14);
      // adtField index: 0
      cnst 4;
      push (pop + pop);
      // eval argument: Cons(h1, rec1)
      // Cons(h1, rec1)
      // save memory boundary as this is the pointer to the class
      getGlobal(0);
      setLocal(16);
      // update memboundary (constr)
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      setGlobal(0);
      // put constructor id at the address
      getLocal(16);
      cnst 1;
      store;
      // put arguments after the id
      // h1
      // get field for argument
      getLocal(16);
      // adtField index: 0
      cnst 4;
      push (pop + pop);
      // eval argument: h1
      // h1
      getLocal(5);
      store;
      // rec1
      // get field for argument
      getLocal(16);
      // adtField index: 1
      cnst 8;
      push (pop + pop);
      // eval argument: rec1
      // rec1
      getLocal(12);
      store;
      // put the pointer of the class to the stack (addr)
      getLocal(16);
      store;
      // Cons(h2, rec2)
      // get field for argument
      getLocal(14);
      // adtField index: 1
      cnst 8;
      push (pop + pop);
      // eval argument: Cons(h2, rec2)
      // Cons(h2, rec2)
      // save memory boundary as this is the pointer to the class
      getGlobal(0);
      setLocal(15);
      // update memboundary (constr)
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      setGlobal(0);
      // put constructor id at the address
      getLocal(15);
      cnst 1;
      store;
      // put arguments after the id
      // h2
      // get field for argument
      getLocal(15);
      // adtField index: 0
      cnst 4;
      push (pop + pop);
      // eval argument: h2
      // h2
      getLocal(7);
      store;
      // rec2
      // get field for argument
      getLocal(15);
      // adtField index: 1
      cnst 8;
      push (pop + pop);
      // eval argument: rec2
      // rec2
      getLocal(13);
      store;
      // put the pointer of the class to the stack (addr)
      getLocal(15);
      store;
      // put the pointer of the class to the stack (addr)
      getLocal(14);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  } else {
    // case _ =>
    //   LP(l, Nil())
    getLocal(1);
    // _
    drop;
    cnst 1;
    if (pop){
      // LP(l, Nil())
      // save memory boundary as this is the pointer to the class
      getGlobal(0);
      setLocal(2);
      // update memboundary (constr)
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      setGlobal(0);
      // put constructor id at the address
      getLocal(2);
      cnst 0;
      store;
      // put arguments after the id
      // l
      // get field for argument
      getLocal(2);
      // adtField index: 0
      cnst 4;
      push (pop + pop);
      // eval argument: l
      // l
      getLocal(0);
      store;
      // Nil()
      // get field for argument
      getLocal(2);
      // adtField index: 1
      cnst 8;
      push (pop + pop);
      // eval argument: Nil()
      // Nil()
      // save memory boundary as this is the pointer to the class
      getGlobal(0);
      setLocal(3);
      // update memboundary (constr)
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      setGlobal(0);
      // put constructor id at the address
      getLocal(3);
      cnst 0;
      store;
      // put arguments after the id
      // put the pointer of the class to the stack (addr)
      getLocal(3);
      store;
      // put the pointer of the class to the stack (addr)
      getLocal(2);
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_mergeSort() {
  int locals[11] = {peek (1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};drop;
  // fn mergeSort(l: List): List = {
  //   l match {
  //     case Nil() =>
  //       l
  //     case Cons(h, Nil()) =>
  //       l
  //     case xs =>
  //       split(xs) match {
  //         case LP(l1, l2) =>
  //           merge(mergeSort(l1), mergeSort(l2))
  //       }
  //   }
  // }
  // l match {
  //   case Nil() =>
  //     l
  //   case Cons(h, Nil()) =>
  //     l
  //   case xs =>
  //     split(xs) match {
  //       case LP(l1, l2) =>
  //         merge(mergeSort(l1), mergeSort(l2))
  //     }
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Nil() =>
  //   l
  getLocal(1);
  // Nil()
  // load the scruts class id
  setLocal(10);
  getLocal(10);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // l
    getLocal(0);
  } else {
    // case Cons(h, Nil()) =>
    //   l
    getLocal(1);
    // Cons(h, Nil())
    // load the scruts class id
    setLocal(7);
    getLocal(7);
    load;
    // class id
    cnst 1;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(7);
    // index is: 0 for scrut l
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // h
    // set idLocal
    setLocal(8);
    cnst 1;
    push (pop && pop);
    // put arg on stack instead of scrut
    getLocal(7);
    // index is: 1 for scrut l
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    load;
    // Nil()
    // load the scruts class id
    setLocal(9);
    getLocal(9);
    load;
    // class id
    cnst 0;
    push (pop == pop);
    push (pop && pop);
    if (pop){
      // l
      getLocal(0);
    } else {
      // case xs =>
      //   split(xs) match {
      //     case LP(l1, l2) =>
      //       merge(mergeSort(l1), mergeSort(l2))
      //   }
      getLocal(1);
      // xs
      // set idLocal
      setLocal(2);
      cnst 1;
      if (pop){
        // split(xs) match {
        //   case LP(l1, l2) =>
        //     merge(mergeSort(l1), mergeSort(l2))
        // }
        // cg for scrut
        // split(xs)
        // xs
        getLocal(2);
        L_split();
        setLocal(3);
        // finished code for scrut
        // case LP(l1, l2) =>
        //   merge(mergeSort(l1), mergeSort(l2))
        getLocal(3);
        // LP(l1, l2)
        // load the scruts class id
        setLocal(4);
        getLocal(4);
        load;
        // class id
        cnst 0;
        push (pop == pop);
        // put arg on stack instead of scrut
        getLocal(4);
        // index is: 0 for scrut split(xs)
        // adtField index: 0
        cnst 4;
        push (pop + pop);
        load;
        // l1
        // set idLocal
        setLocal(5);
        cnst 1;
        push (pop && pop);
        // put arg on stack instead of scrut
        getLocal(4);
        // index is: 1 for scrut split(xs)
        // adtField index: 1
        cnst 8;
        push (pop + pop);
        load;
        // l2
        // set idLocal
        setLocal(6);
        cnst 1;
        push (pop && pop);
        if (pop){
          // merge(mergeSort(l1), mergeSort(l2))
          // mergeSort(l1)
          // l1
          getLocal(5);
          L_mergeSort();
          // mergeSort(l2)
          // l2
          getLocal(6);
          L_mergeSort();
          L_merge();
        } else {
          // error("didn't match any cases")
          // mkString: didn't match any cases
          getGlobal(0);
          cnst 0;
          push (pop + pop);
          cnst 100;
          store; // store8
          getGlobal(0);
          cnst 1;
          push (pop + pop);
          cnst 105;
          store; // store8
          getGlobal(0);
          cnst 2;
          push (pop + pop);
          cnst 100;
          store; // store8
          getGlobal(0);
          cnst 3;
          push (pop + pop);
          cnst 110;
          store; // store8
          getGlobal(0);
          cnst 4;
          push (pop + pop);
          cnst 39;
          store; // store8
          getGlobal(0);
          cnst 5;
          push (pop + pop);
          cnst 116;
          store; // store8
          getGlobal(0);
          cnst 6;
          push (pop + pop);
          cnst 32;
          store; // store8
          getGlobal(0);
          cnst 7;
          push (pop + pop);
          cnst 109;
          store; // store8
          getGlobal(0);
          cnst 8;
          push (pop + pop);
          cnst 97;
          store; // store8
          getGlobal(0);
          cnst 9;
          push (pop + pop);
          cnst 116;
          store; // store8
          getGlobal(0);
          cnst 10;
          push (pop + pop);
          cnst 99;
          store; // store8
          getGlobal(0);
          cnst 11;
          push (pop + pop);
          cnst 104;
          store; // store8
          getGlobal(0);
          cnst 12;
          push (pop + pop);
          cnst 32;
          store; // store8
          getGlobal(0);
          cnst 13;
          push (pop + pop);
          cnst 97;
          store; // store8
          getGlobal(0);
          cnst 14;
          push (pop + pop);
          cnst 110;
          store; // store8
          getGlobal(0);
          cnst 15;
          push (pop + pop);
          cnst 121;
          store; // store8
          getGlobal(0);
          cnst 16;
          push (pop + pop);
          cnst 32;
          store; // store8
          getGlobal(0);
          cnst 17;
          push (pop + pop);
          cnst 99;
          store; // store8
          getGlobal(0);
          cnst 18;
          push (pop + pop);
          cnst 97;
          store; // store8
          getGlobal(0);
          cnst 19;
          push (pop + pop);
          cnst 115;
          store; // store8
          getGlobal(0);
          cnst 20;
          push (pop + pop);
          cnst 101;
          store; // store8
          getGlobal(0);
          cnst 21;
          push (pop + pop);
          cnst 115;
          store; // store8
          getGlobal(0);
          cnst 22;
          push (pop + pop);
          cnst 0;
          store; // store8
          getGlobal(0);
          cnst 23;
          push (pop + pop);
          cnst 0;
          store; // store8
          getGlobal(0);
          getGlobal(0);
          cnst 24;
          push (pop + pop);
          setGlobal(0);
          Std_printString();
          exit(1);
          exit(1);
        }
      } else {
        // error("didn't match any cases")
        // mkString: didn't match any cases
        getGlobal(0);
        cnst 0;
        push (pop + pop);
        cnst 100;
        store; // store8
        getGlobal(0);
        cnst 1;
        push (pop + pop);
        cnst 105;
        store; // store8
        getGlobal(0);
        cnst 2;
        push (pop + pop);
        cnst 100;
        store; // store8
        getGlobal(0);
        cnst 3;
        push (pop + pop);
        cnst 110;
        store; // store8
        getGlobal(0);
        cnst 4;
        push (pop + pop);
        cnst 39;
        store; // store8
        getGlobal(0);
        cnst 5;
        push (pop + pop);
        cnst 116;
        store; // store8
        getGlobal(0);
        cnst 6;
        push (pop + pop);
        cnst 32;
        store; // store8
        getGlobal(0);
        cnst 7;
        push (pop + pop);
        cnst 109;
        store; // store8
        getGlobal(0);
        cnst 8;
        push (pop + pop);
        cnst 97;
        store; // store8
        getGlobal(0);
        cnst 9;
        push (pop + pop);
        cnst 116;
        store; // store8
        getGlobal(0);
        cnst 10;
        push (pop + pop);
        cnst 99;
        store; // store8
        getGlobal(0);
        cnst 11;
        push (pop + pop);
        cnst 104;
        store; // store8
        getGlobal(0);
        cnst 12;
        push (pop + pop);
        cnst 32;
        store; // store8
        getGlobal(0);
        cnst 13;
        push (pop + pop);
        cnst 97;
        store; // store8
        getGlobal(0);
        cnst 14;
        push (pop + pop);
        cnst 110;
        store; // store8
        getGlobal(0);
        cnst 15;
        push (pop + pop);
        cnst 121;
        store; // store8
        getGlobal(0);
        cnst 16;
        push (pop + pop);
        cnst 32;
        store; // store8
        getGlobal(0);
        cnst 17;
        push (pop + pop);
        cnst 99;
        store; // store8
        getGlobal(0);
        cnst 18;
        push (pop + pop);
        cnst 97;
        store; // store8
        getGlobal(0);
        cnst 19;
        push (pop + pop);
        cnst 115;
        store; // store8
        getGlobal(0);
        cnst 20;
        push (pop + pop);
        cnst 101;
        store; // store8
        getGlobal(0);
        cnst 21;
        push (pop + pop);
        cnst 115;
        store; // store8
        getGlobal(0);
        cnst 22;
        push (pop + pop);
        cnst 0;
        store; // store8
        getGlobal(0);
        cnst 23;
        push (pop + pop);
        cnst 0;
        store; // store8
        getGlobal(0);
        getGlobal(0);
        cnst 24;
        push (pop + pop);
        setGlobal(0);
        Std_printString();
        exit(1);
        exit(1);
      }
    }
  }
}
void L_toString() {
  int locals[4] = {peek (1), 0, 0, 0};drop;
  // fn toString(l: List): String = {
  //   l match {
  //     case Nil() =>
  //       "List()"
  //     case more =>
  //       (("List(" ++ toString1(more)) ++ ")")
  //   }
  // }
  // l match {
  //   case Nil() =>
  //     "List()"
  //   case more =>
  //     (("List(" ++ toString1(more)) ++ ")")
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Nil() =>
  //   "List()"
  getLocal(1);
  // Nil()
  // load the scruts class id
  setLocal(3);
  getLocal(3);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  if (pop){
    // mkString: List()
    getGlobal(0);
    cnst 0;
    push (pop + pop);
    cnst 76;
    store; // store8
    getGlobal(0);
    cnst 1;
    push (pop + pop);
    cnst 105;
    store; // store8
    getGlobal(0);
    cnst 2;
    push (pop + pop);
    cnst 115;
    store; // store8
    getGlobal(0);
    cnst 3;
    push (pop + pop);
    cnst 116;
    store; // store8
    getGlobal(0);
    cnst 4;
    push (pop + pop);
    cnst 40;
    store; // store8
    getGlobal(0);
    cnst 5;
    push (pop + pop);
    cnst 41;
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
    // case more =>
    //   (("List(" ++ toString1(more)) ++ ")")
    getLocal(1);
    // more
    // set idLocal
    setLocal(2);
    cnst 1;
    if (pop){
      // (("List(" ++ toString1(more)) ++ ")")
      // ("List(" ++ toString1(more))
      // mkString: List(
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 76;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 40;
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
      // toString1(more)
      // more
      getLocal(2);
      L_toString1();
      String_concat();
      // mkString: )
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 41;
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
      String_concat();
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_toString1() {
  int locals[8] = {peek (1), 0, 0, 0, 0, 0, 0, 0};drop;
  // fn toString1(l: List): String = {
  //   l match {
  //     case Cons(h, Nil()) =>
  //       intToString(h)
  //     case Cons(h, t) =>
  //       ((intToString(h) ++ ", ") ++ toString1(t))
  //   }
  // }
  // l match {
  //   case Cons(h, Nil()) =>
  //     intToString(h)
  //   case Cons(h, t) =>
  //     ((intToString(h) ++ ", ") ++ toString1(t))
  // }
  // cg for scrut
  // l
  getLocal(0);
  setLocal(1);
  // finished code for scrut
  // case Cons(h, Nil()) =>
  //   intToString(h)
  getLocal(1);
  // Cons(h, Nil())
  // load the scruts class id
  setLocal(5);
  getLocal(5);
  load;
  // class id
  cnst 1;
  push (pop == pop);
  // put arg on stack instead of scrut
  getLocal(5);
  // index is: 0 for scrut l
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  load;
  // h
  // set idLocal
  setLocal(6);
  cnst 1;
  push (pop && pop);
  // put arg on stack instead of scrut
  getLocal(5);
  // index is: 1 for scrut l
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  load;
  // Nil()
  // load the scruts class id
  setLocal(7);
  getLocal(7);
  load;
  // class id
  cnst 0;
  push (pop == pop);
  push (pop && pop);
  if (pop){
    // intToString(h)
    // h
    getLocal(6);
    Std_intToString();
  } else {
    // case Cons(h, t) =>
    //   ((intToString(h) ++ ", ") ++ toString1(t))
    getLocal(1);
    // Cons(h, t)
    // load the scruts class id
    setLocal(2);
    getLocal(2);
    load;
    // class id
    cnst 1;
    push (pop == pop);
    // put arg on stack instead of scrut
    getLocal(2);
    // index is: 0 for scrut l
    // adtField index: 0
    cnst 4;
    push (pop + pop);
    load;
    // h
    // set idLocal
    setLocal(3);
    cnst 1;
    push (pop && pop);
    // put arg on stack instead of scrut
    getLocal(2);
    // index is: 1 for scrut l
    // adtField index: 1
    cnst 8;
    push (pop + pop);
    load;
    // t
    // set idLocal
    setLocal(4);
    cnst 1;
    push (pop && pop);
    if (pop){
      // ((intToString(h) ++ ", ") ++ toString1(t))
      // (intToString(h) ++ ", ")
      // intToString(h)
      // h
      getLocal(3);
      Std_intToString();
      // mkString: , 
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 44;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 32;
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
      String_concat();
      // toString1(t)
      // t
      getLocal(4);
      L_toString1();
      String_concat();
    } else {
      // error("didn't match any cases")
      // mkString: didn't match any cases
      getGlobal(0);
      cnst 0;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 1;
      push (pop + pop);
      cnst 105;
      store; // store8
      getGlobal(0);
      cnst 2;
      push (pop + pop);
      cnst 100;
      store; // store8
      getGlobal(0);
      cnst 3;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      cnst 39;
      store; // store8
      getGlobal(0);
      cnst 5;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 6;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 7;
      push (pop + pop);
      cnst 109;
      store; // store8
      getGlobal(0);
      cnst 8;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 9;
      push (pop + pop);
      cnst 116;
      store; // store8
      getGlobal(0);
      cnst 10;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 11;
      push (pop + pop);
      cnst 104;
      store; // store8
      getGlobal(0);
      cnst 12;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 13;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 14;
      push (pop + pop);
      cnst 110;
      store; // store8
      getGlobal(0);
      cnst 15;
      push (pop + pop);
      cnst 121;
      store; // store8
      getGlobal(0);
      cnst 16;
      push (pop + pop);
      cnst 32;
      store; // store8
      getGlobal(0);
      cnst 17;
      push (pop + pop);
      cnst 99;
      store; // store8
      getGlobal(0);
      cnst 18;
      push (pop + pop);
      cnst 97;
      store; // store8
      getGlobal(0);
      cnst 19;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 20;
      push (pop + pop);
      cnst 101;
      store; // store8
      getGlobal(0);
      cnst 21;
      push (pop + pop);
      cnst 115;
      store; // store8
      getGlobal(0);
      cnst 22;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      cnst 23;
      push (pop + pop);
      cnst 0;
      store; // store8
      getGlobal(0);
      getGlobal(0);
      cnst 24;
      push (pop + pop);
      setGlobal(0);
      Std_printString();
      exit(1);
      exit(1);
    }
  }
}
void L_take() {
  int locals[10] = {peek (2), peek (1), 0, 0, 0, 0, 0, 0, 0, 0};drop;drop;
  // fn take(l: List, n: Int(32)): List = {
  //   (if((n <= 0)) {
  //     Nil()
  //   } else {
  //     l match {
  //       case Nil() =>
  //         Nil()
  //       case Cons(h, t) =>
  //         Cons(h, take(t, (n - 1)))
  //     }
  //   })
  // }
  // (if((n <= 0)) {
  //   Nil()
  // } else {
  //   l match {
  //     case Nil() =>
  //       Nil()
  //     case Cons(h, t) =>
  //       Cons(h, take(t, (n - 1)))
  //   }
  // })
  // (n <= 0)
  // n
  getLocal(1);
  // 0
  cnst 0;
  a = pop; push (pop <= a);
  if (pop){
    // Nil()
    // save memory boundary as this is the pointer to the class
    getGlobal(0);
    setLocal(2);
    // update memboundary (constr)
    getGlobal(0);
    cnst 4;
    push (pop + pop);
    setGlobal(0);
    // put constructor id at the address
    getLocal(2);
    cnst 0;
    store;
    // put arguments after the id
    // put the pointer of the class to the stack (addr)
    getLocal(2);
  } else {
    // l match {
    //   case Nil() =>
    //     Nil()
    //   case Cons(h, t) =>
    //     Cons(h, take(t, (n - 1)))
    // }
    // cg for scrut
    // l
    getLocal(0);
    setLocal(3);
    // finished code for scrut
    // case Nil() =>
    //   Nil()
    getLocal(3);
    // Nil()
    // load the scruts class id
    setLocal(8);
    getLocal(8);
    load;
    // class id
    cnst 0;
    push (pop == pop);
    if (pop){
      // Nil()
      // save memory boundary as this is the pointer to the class
      getGlobal(0);
      setLocal(9);
      // update memboundary (constr)
      getGlobal(0);
      cnst 4;
      push (pop + pop);
      setGlobal(0);
      // put constructor id at the address
      getLocal(9);
      cnst 0;
      store;
      // put arguments after the id
      // put the pointer of the class to the stack (addr)
      getLocal(9);
    } else {
      // case Cons(h, t) =>
      //   Cons(h, take(t, (n - 1)))
      getLocal(3);
      // Cons(h, t)
      // load the scruts class id
      setLocal(4);
      getLocal(4);
      load;
      // class id
      cnst 1;
      push (pop == pop);
      // put arg on stack instead of scrut
      getLocal(4);
      // index is: 0 for scrut l
      // adtField index: 0
      cnst 4;
      push (pop + pop);
      load;
      // h
      // set idLocal
      setLocal(5);
      cnst 1;
      push (pop && pop);
      // put arg on stack instead of scrut
      getLocal(4);
      // index is: 1 for scrut l
      // adtField index: 1
      cnst 8;
      push (pop + pop);
      load;
      // t
      // set idLocal
      setLocal(6);
      cnst 1;
      push (pop && pop);
      if (pop){
        // Cons(h, take(t, (n - 1)))
        // save memory boundary as this is the pointer to the class
        getGlobal(0);
        setLocal(7);
        // update memboundary (constr)
        getGlobal(0);
        cnst 12;
        push (pop + pop);
        setGlobal(0);
        // put constructor id at the address
        getLocal(7);
        cnst 1;
        store;
        // put arguments after the id
        // h
        // get field for argument
        getLocal(7);
        // adtField index: 0
        cnst 4;
        push (pop + pop);
        // eval argument: h
        // h
        getLocal(5);
        store;
        // take(t, (n - 1))
        // get field for argument
        getLocal(7);
        // adtField index: 1
        cnst 8;
        push (pop + pop);
        // eval argument: take(t, (n - 1))
        // take(t, (n - 1))
        // t
        getLocal(6);
        // (n - 1)
        // n
        getLocal(1);
        // 1
        cnst 1;
        a = pop; push (pop - a);
        L_take();
        store;
        // put the pointer of the class to the stack (addr)
        getLocal(7);
      } else {
        // error("didn't match any cases")
        // mkString: didn't match any cases
        getGlobal(0);
        cnst 0;
        push (pop + pop);
        cnst 100;
        store; // store8
        getGlobal(0);
        cnst 1;
        push (pop + pop);
        cnst 105;
        store; // store8
        getGlobal(0);
        cnst 2;
        push (pop + pop);
        cnst 100;
        store; // store8
        getGlobal(0);
        cnst 3;
        push (pop + pop);
        cnst 110;
        store; // store8
        getGlobal(0);
        cnst 4;
        push (pop + pop);
        cnst 39;
        store; // store8
        getGlobal(0);
        cnst 5;
        push (pop + pop);
        cnst 116;
        store; // store8
        getGlobal(0);
        cnst 6;
        push (pop + pop);
        cnst 32;
        store; // store8
        getGlobal(0);
        cnst 7;
        push (pop + pop);
        cnst 109;
        store; // store8
        getGlobal(0);
        cnst 8;
        push (pop + pop);
        cnst 97;
        store; // store8
        getGlobal(0);
        cnst 9;
        push (pop + pop);
        cnst 116;
        store; // store8
        getGlobal(0);
        cnst 10;
        push (pop + pop);
        cnst 99;
        store; // store8
        getGlobal(0);
        cnst 11;
        push (pop + pop);
        cnst 104;
        store; // store8
        getGlobal(0);
        cnst 12;
        push (pop + pop);
        cnst 32;
        store; // store8
        getGlobal(0);
        cnst 13;
        push (pop + pop);
        cnst 97;
        store; // store8
        getGlobal(0);
        cnst 14;
        push (pop + pop);
        cnst 110;
        store; // store8
        getGlobal(0);
        cnst 15;
        push (pop + pop);
        cnst 121;
        store; // store8
        getGlobal(0);
        cnst 16;
        push (pop + pop);
        cnst 32;
        store; // store8
        getGlobal(0);
        cnst 17;
        push (pop + pop);
        cnst 99;
        store; // store8
        getGlobal(0);
        cnst 18;
        push (pop + pop);
        cnst 97;
        store; // store8
        getGlobal(0);
        cnst 19;
        push (pop + pop);
        cnst 115;
        store; // store8
        getGlobal(0);
        cnst 20;
        push (pop + pop);
        cnst 101;
        store; // store8
        getGlobal(0);
        cnst 21;
        push (pop + pop);
        cnst 115;
        store; // store8
        getGlobal(0);
        cnst 22;
        push (pop + pop);
        cnst 0;
        store; // store8
        getGlobal(0);
        cnst 23;
        push (pop + pop);
        cnst 0;
        store; // store8
        getGlobal(0);
        getGlobal(0);
        cnst 24;
        push (pop + pop);
        setGlobal(0);
        Std_printString();
        exit(1);
        exit(1);
      }
    }
  }
}
void main() {
  int locals[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};;
  // (
  //   val l: List =
  //     Cons(5, Cons(-(5), Cons(-(1), Cons(0, Cons(10, Nil())))));
  //   printString(toString(concat(Cons(1, Cons(2, Nil())), Cons(3, Nil()))));
  //   printInt(sum(l));
  //   printString(toString(mergeSort(l)))
  // )
  // Cons(5, Cons(-(5), Cons(-(1), Cons(0, Cons(10, Nil())))))
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(1);
  // update memboundary (constr)
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(1);
  cnst 1;
  store;
  // put arguments after the id
  // 5
  // get field for argument
  getLocal(1);
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  // eval argument: 5
  // 5
  cnst 5;
  store;
  // Cons(-(5), Cons(-(1), Cons(0, Cons(10, Nil()))))
  // get field for argument
  getLocal(1);
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  // eval argument: Cons(-(5), Cons(-(1), Cons(0, Cons(10, Nil()))))
  // Cons(-(5), Cons(-(1), Cons(0, Cons(10, Nil()))))
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(2);
  // update memboundary (constr)
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(2);
  cnst 1;
  store;
  // put arguments after the id
  // -(5)
  // get field for argument
  getLocal(2);
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  // eval argument: -(5)
  // -(5)
  // 5
  cnst 5;
  cnst -1;
  push (pop * pop);
  store;
  // Cons(-(1), Cons(0, Cons(10, Nil())))
  // get field for argument
  getLocal(2);
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  // eval argument: Cons(-(1), Cons(0, Cons(10, Nil())))
  // Cons(-(1), Cons(0, Cons(10, Nil())))
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(3);
  // update memboundary (constr)
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(3);
  cnst 1;
  store;
  // put arguments after the id
  // -(1)
  // get field for argument
  getLocal(3);
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  // eval argument: -(1)
  // -(1)
  // 1
  cnst 1;
  cnst -1;
  push (pop * pop);
  store;
  // Cons(0, Cons(10, Nil()))
  // get field for argument
  getLocal(3);
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  // eval argument: Cons(0, Cons(10, Nil()))
  // Cons(0, Cons(10, Nil()))
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(4);
  // update memboundary (constr)
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(4);
  cnst 1;
  store;
  // put arguments after the id
  // 0
  // get field for argument
  getLocal(4);
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  // eval argument: 0
  // 0
  cnst 0;
  store;
  // Cons(10, Nil())
  // get field for argument
  getLocal(4);
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  // eval argument: Cons(10, Nil())
  // Cons(10, Nil())
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(5);
  // update memboundary (constr)
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(5);
  cnst 1;
  store;
  // put arguments after the id
  // 10
  // get field for argument
  getLocal(5);
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  // eval argument: 10
  // 10
  cnst 10;
  store;
  // Nil()
  // get field for argument
  getLocal(5);
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  // eval argument: Nil()
  // Nil()
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(6);
  // update memboundary (constr)
  getGlobal(0);
  cnst 4;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(6);
  cnst 0;
  store;
  // put arguments after the id
  // put the pointer of the class to the stack (addr)
  getLocal(6);
  store;
  // put the pointer of the class to the stack (addr)
  getLocal(5);
  store;
  // put the pointer of the class to the stack (addr)
  getLocal(4);
  store;
  // put the pointer of the class to the stack (addr)
  getLocal(3);
  store;
  // put the pointer of the class to the stack (addr)
  getLocal(2);
  store;
  // put the pointer of the class to the stack (addr)
  getLocal(1);
  setLocal(0);
  // printString(toString(concat(Cons(1, Cons(2, Nil())), Cons(3, Nil()))))
  // printString(toString(concat(Cons(1, Cons(2, Nil())), Cons(3, Nil()))))
  // toString(concat(Cons(1, Cons(2, Nil())), Cons(3, Nil())))
  // concat(Cons(1, Cons(2, Nil())), Cons(3, Nil()))
  // Cons(1, Cons(2, Nil()))
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(7);
  // update memboundary (constr)
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(7);
  cnst 1;
  store;
  // put arguments after the id
  // 1
  // get field for argument
  getLocal(7);
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  // eval argument: 1
  // 1
  cnst 1;
  store;
  // Cons(2, Nil())
  // get field for argument
  getLocal(7);
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  // eval argument: Cons(2, Nil())
  // Cons(2, Nil())
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(8);
  // update memboundary (constr)
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(8);
  cnst 1;
  store;
  // put arguments after the id
  // 2
  // get field for argument
  getLocal(8);
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  // eval argument: 2
  // 2
  cnst 2;
  store;
  // Nil()
  // get field for argument
  getLocal(8);
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  // eval argument: Nil()
  // Nil()
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(9);
  // update memboundary (constr)
  getGlobal(0);
  cnst 4;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(9);
  cnst 0;
  store;
  // put arguments after the id
  // put the pointer of the class to the stack (addr)
  getLocal(9);
  store;
  // put the pointer of the class to the stack (addr)
  getLocal(8);
  store;
  // put the pointer of the class to the stack (addr)
  getLocal(7);
  // Cons(3, Nil())
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(10);
  // update memboundary (constr)
  getGlobal(0);
  cnst 12;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(10);
  cnst 1;
  store;
  // put arguments after the id
  // 3
  // get field for argument
  getLocal(10);
  // adtField index: 0
  cnst 4;
  push (pop + pop);
  // eval argument: 3
  // 3
  cnst 3;
  store;
  // Nil()
  // get field for argument
  getLocal(10);
  // adtField index: 1
  cnst 8;
  push (pop + pop);
  // eval argument: Nil()
  // Nil()
  // save memory boundary as this is the pointer to the class
  getGlobal(0);
  setLocal(11);
  // update memboundary (constr)
  getGlobal(0);
  cnst 4;
  push (pop + pop);
  setGlobal(0);
  // put constructor id at the address
  getLocal(11);
  cnst 0;
  store;
  // put arguments after the id
  // put the pointer of the class to the stack (addr)
  getLocal(11);
  store;
  // put the pointer of the class to the stack (addr)
  getLocal(10);
  L_concat();
  L_toString();
  Std_printString();
  drop;
  // (
  //   printInt(sum(l));
  //   printString(toString(mergeSort(l)))
  // )
  // printInt(sum(l))
  // printInt(sum(l))
  // sum(l)
  // l
  getLocal(0);
  L_sum();
  Std_printInt();
  drop;
  // printString(toString(mergeSort(l)))
  // printString(toString(mergeSort(l)))
  // toString(mergeSort(l))
  // mergeSort(l)
  // l
  getLocal(0);
  L_mergeSort();
  L_toString();
  Std_printString();
  drop;
}