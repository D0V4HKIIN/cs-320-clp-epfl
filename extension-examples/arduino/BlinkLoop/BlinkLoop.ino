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
#define MAX_STACK_SIZE 100
int stack[MAX_STACK_SIZE];
int stack_pointer = 0;
int globals[MAX_STACK_SIZE];
char memory[MAX_STACK_SIZE];

void BlinkLoop_count();
void BlinkLoop_main();
void Std_pinMode(){
  pinMode(peek(2), peek(1));drop;drop;
  cnst 0;
}
void Std_digitalRead(){
  push digitalRead(pop);
}
void Std_digitalWrite(){
  digitalWrite(peek(2), peek(1));drop;drop;
  cnst 0;
}
void Std_delay(){
  delay(pop);
  cnst 0;
}
void BlinkLoop_count() {
  int locals[4] = {peek (2), peek (1), 0, 0};drop;drop;
  // fn count(ledPin: Int(32), buttonPin: Int(32)): Unit = {
  //   digitalWrite(ledPin, 1);
  //   delay(200);
  //   digitalWrite(ledPin, 0);
  //   (if((digitalRead(buttonPin) == 0)) {
  //     (
  //       val nextPin: Int(32) =
  //         (((ledPin - 9) % 4) + 10);
  //       count(nextPin, buttonPin)
  //     )
  //   } else {
  //     (
  //       val nextPin: Int(32) =
  //         ((((ledPin - 11) + 4) % 4) + 10);
  //       count(nextPin, buttonPin)
  //     )
  //   })
  // }
  // digitalWrite(ledPin, 1)
  // digitalWrite(ledPin, 1)
  // ledPin
  getLocal(0);
  // 1
  cnst 1;
  Std_digitalWrite();
  drop;
  // (
  //   delay(200);
  //   digitalWrite(ledPin, 0);
  //   (if((digitalRead(buttonPin) == 0)) {
  //     (
  //       val nextPin: Int(32) =
  //         (((ledPin - 9) % 4) + 10);
  //       count(nextPin, buttonPin)
  //     )
  //   } else {
  //     (
  //       val nextPin: Int(32) =
  //         ((((ledPin - 11) + 4) % 4) + 10);
  //       count(nextPin, buttonPin)
  //     )
  //   })
  // )
  // delay(200)
  // delay(200)
  // 200
  cnst 200;
  Std_delay();
  drop;
  // (
  //   digitalWrite(ledPin, 0);
  //   (if((digitalRead(buttonPin) == 0)) {
  //     (
  //       val nextPin: Int(32) =
  //         (((ledPin - 9) % 4) + 10);
  //       count(nextPin, buttonPin)
  //     )
  //   } else {
  //     (
  //       val nextPin: Int(32) =
  //         ((((ledPin - 11) + 4) % 4) + 10);
  //       count(nextPin, buttonPin)
  //     )
  //   })
  // )
  // digitalWrite(ledPin, 0)
  // digitalWrite(ledPin, 0)
  // ledPin
  getLocal(0);
  // 0
  cnst 0;
  Std_digitalWrite();
  drop;
  // (if((digitalRead(buttonPin) == 0)) {
  //   (
  //     val nextPin: Int(32) =
  //       (((ledPin - 9) % 4) + 10);
  //     count(nextPin, buttonPin)
  //   )
  // } else {
  //   (
  //     val nextPin: Int(32) =
  //       ((((ledPin - 11) + 4) % 4) + 10);
  //     count(nextPin, buttonPin)
  //   )
  // })
  // (if((digitalRead(buttonPin) == 0)) {
  //   (
  //     val nextPin: Int(32) =
  //       (((ledPin - 9) % 4) + 10);
  //     count(nextPin, buttonPin)
  //   )
  // } else {
  //   (
  //     val nextPin: Int(32) =
  //       ((((ledPin - 11) + 4) % 4) + 10);
  //     count(nextPin, buttonPin)
  //   )
  // })
  // (digitalRead(buttonPin) == 0)
  // digitalRead(buttonPin)
  // buttonPin
  getLocal(1);
  Std_digitalRead();
  // 0
  cnst 0;
  push (pop == pop);
  if (pop){
    // (
    //   val nextPin: Int(32) =
    //     (((ledPin - 9) % 4) + 10);
    //   count(nextPin, buttonPin)
    // )
    // (((ledPin - 9) % 4) + 10)
    // ((ledPin - 9) % 4)
    // (ledPin - 9)
    // ledPin
    getLocal(0);
    // 9
    cnst 9;
    a = pop; push (pop - a);
    // 4
    cnst 4;
    a = pop; push (pop % a);
    // 10
    cnst 10;
    push (pop + pop);
    setLocal(2);
    // count(nextPin, buttonPin)
    // nextPin
    getLocal(2);
    // buttonPin
    getLocal(1);
    BlinkLoop_count();
  } else {
    // (
    //   val nextPin: Int(32) =
    //     ((((ledPin - 11) + 4) % 4) + 10);
    //   count(nextPin, buttonPin)
    // )
    // ((((ledPin - 11) + 4) % 4) + 10)
    // (((ledPin - 11) + 4) % 4)
    // ((ledPin - 11) + 4)
    // (ledPin - 11)
    // ledPin
    getLocal(0);
    // 11
    cnst 11;
    a = pop; push (pop - a);
    // 4
    cnst 4;
    push (pop + pop);
    // 4
    cnst 4;
    a = pop; push (pop % a);
    // 10
    cnst 10;
    push (pop + pop);
    setLocal(3);
    // count(nextPin, buttonPin)
    // nextPin
    getLocal(3);
    // buttonPin
    getLocal(1);
    BlinkLoop_count();
  }
}

void setup() {
  int locals[2] = {0, 0};;
  // (
  //   val INPUT: Int(32) =
  //     0;
  //   val OUTPUT: Int(32) =
  //     1;
  //   pinMode(10, OUTPUT);
  //   pinMode(11, OUTPUT);
  //   pinMode(12, OUTPUT);
  //   pinMode(13, OUTPUT);
  //   pinMode(2, INPUT);
  //   count(10, 2)
  // )
  // 0
  cnst 0;
  setLocal(0);
  // (
  //   val OUTPUT: Int(32) =
  //     1;
  //   pinMode(10, OUTPUT);
  //   pinMode(11, OUTPUT);
  //   pinMode(12, OUTPUT);
  //   pinMode(13, OUTPUT);
  //   pinMode(2, INPUT);
  //   count(10, 2)
  // )
  // 1
  cnst 1;
  setLocal(1);
  // pinMode(10, OUTPUT)
  // pinMode(10, OUTPUT)
  // 10
  cnst 10;
  // OUTPUT
  getLocal(1);
  Std_pinMode();
  drop;
  // (
  //   pinMode(11, OUTPUT);
  //   pinMode(12, OUTPUT);
  //   pinMode(13, OUTPUT);
  //   pinMode(2, INPUT);
  //   count(10, 2)
  // )
  // pinMode(11, OUTPUT)
  // pinMode(11, OUTPUT)
  // 11
  cnst 11;
  // OUTPUT
  getLocal(1);
  Std_pinMode();
  drop;
  // (
  //   pinMode(12, OUTPUT);
  //   pinMode(13, OUTPUT);
  //   pinMode(2, INPUT);
  //   count(10, 2)
  // )
  // pinMode(12, OUTPUT)
  // pinMode(12, OUTPUT)
  // 12
  cnst 12;
  // OUTPUT
  getLocal(1);
  Std_pinMode();
  drop;
  // (
  //   pinMode(13, OUTPUT);
  //   pinMode(2, INPUT);
  //   count(10, 2)
  // )
  // pinMode(13, OUTPUT)
  // pinMode(13, OUTPUT)
  // 13
  cnst 13;
  // OUTPUT
  getLocal(1);
  Std_pinMode();
  drop;
  // (
  //   pinMode(2, INPUT);
  //   count(10, 2)
  // )
  // pinMode(2, INPUT)
  // pinMode(2, INPUT)
  // 2
  cnst 2;
  // INPUT
  getLocal(0);
  Std_pinMode();
  drop;
  // count(10, 2)
  // count(10, 2)
  // 10
  cnst 10;
  // 2
  cnst 2;
  BlinkLoop_count();
  drop;
}
