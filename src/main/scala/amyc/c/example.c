#include <stdio.h>

int a;
int b;

#define push stack[stack_pointer++] = 
#define pop stack[--stack_pointer]
#define mod 
#define cnst push 
#define getGlobal(i) globals[i]
#define setGlobal(i) globals[i] = pop
#define getLocal(i) locals[i]
#define setLocal(i) locals[i] = pop
#define store int a = pop; memory[pop] = a
#define load push memory[pop]

// maybe later do dynamic allocation
#define MAX_STACK_SIZE 10000

int stack[MAX_STACK_SIZE];
int stack_pointer = 0;
int locals[MAX_STACK_SIZE];
int globals[MAX_STACK_SIZE];
int memory[MAX_STACK_SIZE];

// in scala
// #define binop(op) (push (pop op pop)) 
// #define add_i32 binop(+) 


// functions should be above because functions need to be declare before use

int Std_printInt(){
    printf("%d\n", pop);
    cnst 0;
}

int main(){

    /*code*/
    stack[stack_pointer++] = 5; // const 5
    stack[stack_pointer++] = 10; // const 10
    push (pop + pop); // add_i32 5, 10
    sys_println1(pop); // should print 15
}

