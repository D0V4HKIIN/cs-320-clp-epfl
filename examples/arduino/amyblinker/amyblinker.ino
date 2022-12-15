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
#define MAX_STACK_SIZE 200
int stack[MAX_STACK_SIZE];
int stack_pointer = 0;
int globals[MAX_STACK_SIZE];
char memory[MAX_STACK_SIZE];

void Blinker_count();
void Blinker_main();

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
void Blinker_count() {
  int locals[3] = {peek (3), peek (2), peek (1), };drop;drop;drop;
  // fn count(i: Int(32), ledPin: Int(32), buttonPin: Int(32)): Unit = {
  //   digitalWrite(ledPin, 0);
  //   delay((i * 1000));
  //   (if((digitalRead(buttonPin) == 1)) {
  //     (
  //       digitalWrite(ledPin, 1);
  //       count((i + 1), ledPin, buttonPin)
  //     )
  //   } else {
  //     (
  //       digitalWrite(ledPin, 1);
  //       count(0, ledPin, buttonPin)
  //     )
  //   })
  // }
  // digitalWrite(ledPin, 0)
  // digitalWrite(ledPin, 0)
  // ledPin
  getLocal(1);
  // 0
  cnst 0;
  Std_digitalWrite();
  drop;
  // (
  //   delay((i * 1000));
  //   (if((digitalRead(buttonPin) == 1)) {
  //     (
  //       digitalWrite(ledPin, 1);
  //       count((i + 1), ledPin, buttonPin)
  //     )
  //   } else {
  //     (
  //       digitalWrite(ledPin, 1);
  //       count(0, ledPin, buttonPin)
  //     )
  //   })
  // )
  // delay((i * 1000))
  // delay((i * 1000))
  // (i * 1000)
  // i
  getLocal(0);
  // 1000
  cnst 1000;
  push (pop * pop);
  Std_delay();
  drop;
  // (if((digitalRead(buttonPin) == 1)) {
  //   (
  //     digitalWrite(ledPin, 1);
  //     count((i + 1), ledPin, buttonPin)
  //   )
  // } else {
  //   (
  //     digitalWrite(ledPin, 1);
  //     count(0, ledPin, buttonPin)
  //   )
  // })
  // (if((digitalRead(buttonPin) == 1)) {
  //   (
  //     digitalWrite(ledPin, 1);
  //     count((i + 1), ledPin, buttonPin)
  //   )
  // } else {
  //   (
  //     digitalWrite(ledPin, 1);
  //     count(0, ledPin, buttonPin)
  //   )
  // })
  // (digitalRead(buttonPin) == 1)
  // digitalRead(buttonPin)
  // buttonPin
  getLocal(2);
  Std_digitalRead();
  // 1
  cnst 1;
  push (pop == pop);
  if (pop){
    // digitalWrite(ledPin, 1)
    // digitalWrite(ledPin, 1)
    // ledPin
    getLocal(1);
    // 1
    cnst 1;
    Std_digitalWrite();
    drop;
    // count((i + 1), ledPin, buttonPin)
    // count((i + 1), ledPin, buttonPin)
    // (i + 1)
    // i
    getLocal(0);
    // 1
    cnst 1;
    push (pop + pop);
    // ledPin
    getLocal(1);
    // buttonPin
    getLocal(2);
    Blinker_count();
  } else {
    // digitalWrite(ledPin, 1)
    // digitalWrite(ledPin, 1)
    // ledPin
    getLocal(1);
    // 1
    cnst 1;
    Std_digitalWrite();
    drop;
    // count(0, ledPin, buttonPin)
    // count(0, ledPin, buttonPin)
    // 0
    cnst 0;
    // ledPin
    getLocal(1);
    // buttonPin
    getLocal(2);
    Blinker_count();
  }
}
void setup() {
  int locals[0] = {};;
  // pinMode(13, 1)
  // pinMode(13, 1)
  // 13
  cnst 13;
  // 1
  cnst 1;
  Std_pinMode();
  drop;
  // (
  //   pinMode(2, 0);
  //   count(0, 13, 2)
  // )
  // pinMode(2, 0)
  // pinMode(2, 0)
  // 2
  cnst 2;
  // 0
  cnst 0;
  Std_pinMode();
  drop;
  // count(0, 13, 2)
  // count(0, 13, 2)
  // 0
  cnst 0;
  // 13
  cnst 13;
  // 2
  cnst 2;
  Blinker_count();
  drop;
}
