#define push stack[stack_pointer++] = 
#define pop stack[--stack_pointer]

// maybe later do dynamic allocation
#define MAX_STACK_SIZE 10000

// in scala
// #define binop(op) (push (pop op pop)) 
// #define add_i32 binop(+) 

#define cnst push 
int main(){
    int[MAX_STACK_SIZE] stack;
    int stack_pointer = 0;
    int[MAX_STACK_SIZE] locals;
    int[MAX_STACK_SIZE] globals;

    /*code*/
    cnst 5; // const
    push (pop + pop); // add_i32
    sys_println1(pop);
}

int sys_println1(int x){
    printf("%d", x);
    return 0;
}

