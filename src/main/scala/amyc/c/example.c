#include <stdio.h>

#define push stack[stack_pointer++] = 
#define pop stack[--stack_pointer]
#define cnst push 

// maybe later do dynamic allocation
#define MAX_STACK_SIZE 10000

// in scala
// #define binop(op) (push (pop op pop)) 
// #define add_i32 binop(+) 


// functions should be above because functions need to be declare before use

int sys_println1(int x){
    printf("%d\n", x);
    return 0;
}

int main(){
    int stack[MAX_STACK_SIZE];
    int stack_pointer = 0;
    int locals[MAX_STACK_SIZE];
    int globals[MAX_STACK_SIZE];

    /*code*/
    cnst 5; // const 5
    cnst 10; // const 10
    push (pop + pop); // add_i32 5, 10
    sys_println1(pop); // should print 15
}

