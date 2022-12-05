(module 
  (import "system" "printInt" (func $Std_printInt (param i32) (result i32)))
  (import "system" "printString" (func $Std_printString (param i32) (result i32)))
  (import "system" "readString0" (func $js_readString0 (param i32) (result i32)))
  (import "system" "readInt" (func $Std_readInt (result i32)))
  (import "system" "mem" (memory 100))
  (global (mut i32) i32.const 0) 

  (func $String_concat (param i32 i32) (result i32) (local i32 i32)
    global.get 0
    local.set 3
    local.get 0
    local.set 2
    loop $label_1
      local.get 2
      i32.load8_u
      if
        local.get 3
        local.get 2
        i32.load8_u
        i32.store8
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        local.get 2
        i32.const 1
        i32.add
        local.set 2
        br $label_1
      else
      end
    end
    local.get 1
    local.set 2
    loop $label_2
      local.get 2
      i32.load8_u
      if
        local.get 3
        local.get 2
        i32.load8_u
        i32.store8
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        local.get 2
        i32.const 1
        i32.add
        local.set 2
        br $label_2
      else
      end
    end
    loop $label_0
      local.get 3
      i32.const 0
      i32.store8
      local.get 3
      i32.const 4
      i32.rem_s
      if
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        br $label_0
      else
      end
    end
    global.get 0
    local.get 3
    i32.const 1
    i32.add
    global.set 0
  )

  (func $Std_digitToString (param i32) (result i32) 
    global.get 0
    local.get 0
    i32.const 48
    i32.add
    i32.store
    global.get 0
    global.get 0
    i32.const 4
    i32.add
    global.set 0
  )

  (func $Std_readString (result i32) 
    global.get 0
    global.get 0
    call $js_readString0
    global.set 0
  )

  (func $Std_printBoolean (param i32) (result i32) 
    ;;> fn printBoolean(b: Boolean): Unit = {
    ;;|   printString(booleanToString(b))
    ;;| }
    ;;> printString(booleanToString(b))
    ;;> booleanToString(b)
    ;;> b
    local.get 0
    call $Std_booleanToString
    call $Std_printString
  )

  (func $Std_intToString (param i32) (result i32) (local i32 i32)
    ;;> fn intToString(i: Int(32)): String = {
    ;;|   (if((i < 0)) {
    ;;|     ("-" ++ intToString(-(i)))
    ;;|   } else {
    ;;|     (
    ;;|       val rem: Int(32) =
    ;;|         (i % 10);
    ;;|       val div: Int(32) =
    ;;|         (i / 10);
    ;;|       (if((div == 0)) {
    ;;|         digitToString(rem)
    ;;|       } else {
    ;;|         (intToString(div) ++ digitToString(rem))
    ;;|       })
    ;;|     )
    ;;|   })
    ;;| }
    ;;> (if((i < 0)) {
    ;;|   ("-" ++ intToString(-(i)))
    ;;| } else {
    ;;|   (
    ;;|     val rem: Int(32) =
    ;;|       (i % 10);
    ;;|     val div: Int(32) =
    ;;|       (i / 10);
    ;;|     (if((div == 0)) {
    ;;|       digitToString(rem)
    ;;|     } else {
    ;;|       (intToString(div) ++ digitToString(rem))
    ;;|     })
    ;;|   )
    ;;| })
    ;;> (i < 0)
    ;;> i
    local.get 0
    ;;> 0
    i32.const 0
    i32.lt_s
    if (result i32)
      ;;> ("-" ++ intToString(-(i)))
      ;;> mkString: -
      global.get 0
      i32.const 0
      i32.add
      i32.const 45
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 4
      i32.add
      global.set 0
      ;;> intToString(-(i))
      ;;> -(i)
      ;;> i
      local.get 0
      i32.const -1
      i32.mul
      call $Std_intToString
      call $String_concat
    else
      ;;> (
      ;;|   val rem: Int(32) =
      ;;|     (i % 10);
      ;;|   val div: Int(32) =
      ;;|     (i / 10);
      ;;|   (if((div == 0)) {
      ;;|     digitToString(rem)
      ;;|   } else {
      ;;|     (intToString(div) ++ digitToString(rem))
      ;;|   })
      ;;| )
      ;;> (i % 10)
      ;;> i
      local.get 0
      ;;> 10
      i32.const 10
      i32.rem_s
      local.set 1
      ;;> (
      ;;|   val div: Int(32) =
      ;;|     (i / 10);
      ;;|   (if((div == 0)) {
      ;;|     digitToString(rem)
      ;;|   } else {
      ;;|     (intToString(div) ++ digitToString(rem))
      ;;|   })
      ;;| )
      ;;> (i / 10)
      ;;> i
      local.get 0
      ;;> 10
      i32.const 10
      i32.div_s
      local.set 2
      ;;> (if((div == 0)) {
      ;;|   digitToString(rem)
      ;;| } else {
      ;;|   (intToString(div) ++ digitToString(rem))
      ;;| })
      ;;> (div == 0)
      ;;> div
      local.get 2
      ;;> 0
      i32.const 0
      i32.eq
      if (result i32)
        ;;> digitToString(rem)
        ;;> rem
        local.get 1
        call $Std_digitToString
      else
        ;;> (intToString(div) ++ digitToString(rem))
        ;;> intToString(div)
        ;;> div
        local.get 2
        call $Std_intToString
        ;;> digitToString(rem)
        ;;> rem
        local.get 1
        call $Std_digitToString
        call $String_concat
      end
    end
  )

  (func $Std_booleanToString (param i32) (result i32) 
    ;;> fn booleanToString(b: Boolean): String = {
    ;;|   (if(b) {
    ;;|     "true"
    ;;|   } else {
    ;;|     "false"
    ;;|   })
    ;;| }
    ;;> (if(b) {
    ;;|   "true"
    ;;| } else {
    ;;|   "false"
    ;;| })
    ;;> b
    local.get 0
    if (result i32)
      ;;> mkString: true
      global.get 0
      i32.const 0
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 117
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 8
      i32.add
      global.set 0
    else
      ;;> mkString: false
      global.get 0
      i32.const 0
      i32.add
      i32.const 102
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 97
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 108
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 115
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 8
      i32.add
      global.set 0
    end
  )

  (func $BasicArithmetic_plus (param i32 i32) (result i32) 
    ;;> fn plus(a: Int(32), b: Int(32)): Int(32) = {
    ;;|   (a + b)
    ;;| }
    ;;> (a + b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    i32.add
  )

  (func $BasicArithmetic_minus (param i32 i32) (result i32) 
    ;;> fn minus(a: Int(32), b: Int(32)): Int(32) = {
    ;;|   (a - b)
    ;;| }
    ;;> (a - b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    i32.sub
  )

  (func $BasicArithmetic_mul (param i32 i32) (result i32) 
    ;;> fn mul(a: Int(32), b: Int(32)): Int(32) = {
    ;;|   (a * b)
    ;;| }
    ;;> (a * b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    i32.mul
  )

  (func $BasicArithmetic_mod (param i32 i32) (result i32) 
    ;;> fn mod(a: Int(32), b: Int(32)): Int(32) = {
    ;;|   (a % b)
    ;;| }
    ;;> (a % b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    i32.rem_s
  )

  (func $BasicArithmetic_div (param i32 i32) (result i32) 
    ;;> fn div(a: Int(32), b: Int(32)): Int(32) = {
    ;;|   (a / b)
    ;;| }
    ;;> (a / b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    i32.div_s
  )
  (export "BasicArithmetic_main" (func $BasicArithmetic_main))
  (func $BasicArithmetic_main (local i32 i32)
    ;;> (
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     2;
    ;;|   printString(intToString(plus(a, b)));
    ;;|   printString(intToString(mul(plus(a, b), b)));
    ;;|   printString(intToString(minus(mul(plus(a, b), b), b)));
    ;;|   printString(intToString(mul(minus(mul(plus(a, b), b), b), b)));
    ;;|   printString(intToString(div(4, 2)));
    ;;|   printString(intToString(div(3, 2)));
    ;;|   printString(intToString(div(1, 2)));
    ;;|   printString(intToString(div(-(1), 2)));
    ;;|   printString(intToString(div(-(2), 2)));
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> 1
    i32.const 1
    local.set 0
    ;;> (
    ;;|   val b: Int(32) =
    ;;|     2;
    ;;|   printString(intToString(plus(a, b)));
    ;;|   printString(intToString(mul(plus(a, b), b)));
    ;;|   printString(intToString(minus(mul(plus(a, b), b), b)));
    ;;|   printString(intToString(mul(minus(mul(plus(a, b), b), b), b)));
    ;;|   printString(intToString(div(4, 2)));
    ;;|   printString(intToString(div(3, 2)));
    ;;|   printString(intToString(div(1, 2)));
    ;;|   printString(intToString(div(-(1), 2)));
    ;;|   printString(intToString(div(-(2), 2)));
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> 2
    i32.const 2
    local.set 1
    ;;> printString(intToString(plus(a, b)))
    ;;> printString(intToString(plus(a, b)))
    ;;> intToString(plus(a, b))
    ;;> plus(a, b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    call $BasicArithmetic_plus
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(mul(plus(a, b), b)));
    ;;|   printString(intToString(minus(mul(plus(a, b), b), b)));
    ;;|   printString(intToString(mul(minus(mul(plus(a, b), b), b), b)));
    ;;|   printString(intToString(div(4, 2)));
    ;;|   printString(intToString(div(3, 2)));
    ;;|   printString(intToString(div(1, 2)));
    ;;|   printString(intToString(div(-(1), 2)));
    ;;|   printString(intToString(div(-(2), 2)));
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(mul(plus(a, b), b)))
    ;;> printString(intToString(mul(plus(a, b), b)))
    ;;> intToString(mul(plus(a, b), b))
    ;;> mul(plus(a, b), b)
    ;;> plus(a, b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    call $BasicArithmetic_plus
    ;;> b
    local.get 1
    call $BasicArithmetic_mul
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(minus(mul(plus(a, b), b), b)));
    ;;|   printString(intToString(mul(minus(mul(plus(a, b), b), b), b)));
    ;;|   printString(intToString(div(4, 2)));
    ;;|   printString(intToString(div(3, 2)));
    ;;|   printString(intToString(div(1, 2)));
    ;;|   printString(intToString(div(-(1), 2)));
    ;;|   printString(intToString(div(-(2), 2)));
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(minus(mul(plus(a, b), b), b)))
    ;;> printString(intToString(minus(mul(plus(a, b), b), b)))
    ;;> intToString(minus(mul(plus(a, b), b), b))
    ;;> minus(mul(plus(a, b), b), b)
    ;;> mul(plus(a, b), b)
    ;;> plus(a, b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    call $BasicArithmetic_plus
    ;;> b
    local.get 1
    call $BasicArithmetic_mul
    ;;> b
    local.get 1
    call $BasicArithmetic_minus
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(mul(minus(mul(plus(a, b), b), b), b)));
    ;;|   printString(intToString(div(4, 2)));
    ;;|   printString(intToString(div(3, 2)));
    ;;|   printString(intToString(div(1, 2)));
    ;;|   printString(intToString(div(-(1), 2)));
    ;;|   printString(intToString(div(-(2), 2)));
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(mul(minus(mul(plus(a, b), b), b), b)))
    ;;> printString(intToString(mul(minus(mul(plus(a, b), b), b), b)))
    ;;> intToString(mul(minus(mul(plus(a, b), b), b), b))
    ;;> mul(minus(mul(plus(a, b), b), b), b)
    ;;> minus(mul(plus(a, b), b), b)
    ;;> mul(plus(a, b), b)
    ;;> plus(a, b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    call $BasicArithmetic_plus
    ;;> b
    local.get 1
    call $BasicArithmetic_mul
    ;;> b
    local.get 1
    call $BasicArithmetic_minus
    ;;> b
    local.get 1
    call $BasicArithmetic_mul
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(div(4, 2)));
    ;;|   printString(intToString(div(3, 2)));
    ;;|   printString(intToString(div(1, 2)));
    ;;|   printString(intToString(div(-(1), 2)));
    ;;|   printString(intToString(div(-(2), 2)));
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(div(4, 2)))
    ;;> printString(intToString(div(4, 2)))
    ;;> intToString(div(4, 2))
    ;;> div(4, 2)
    ;;> 4
    i32.const 4
    ;;> 2
    i32.const 2
    call $BasicArithmetic_div
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(div(3, 2)));
    ;;|   printString(intToString(div(1, 2)));
    ;;|   printString(intToString(div(-(1), 2)));
    ;;|   printString(intToString(div(-(2), 2)));
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(div(3, 2)))
    ;;> printString(intToString(div(3, 2)))
    ;;> intToString(div(3, 2))
    ;;> div(3, 2)
    ;;> 3
    i32.const 3
    ;;> 2
    i32.const 2
    call $BasicArithmetic_div
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(div(1, 2)));
    ;;|   printString(intToString(div(-(1), 2)));
    ;;|   printString(intToString(div(-(2), 2)));
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(div(1, 2)))
    ;;> printString(intToString(div(1, 2)))
    ;;> intToString(div(1, 2))
    ;;> div(1, 2)
    ;;> 1
    i32.const 1
    ;;> 2
    i32.const 2
    call $BasicArithmetic_div
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(div(-(1), 2)));
    ;;|   printString(intToString(div(-(2), 2)));
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(div(-(1), 2)))
    ;;> printString(intToString(div(-(1), 2)))
    ;;> intToString(div(-(1), 2))
    ;;> div(-(1), 2)
    ;;> -(1)
    ;;> 1
    i32.const 1
    i32.const -1
    i32.mul
    ;;> 2
    i32.const 2
    call $BasicArithmetic_div
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(div(-(2), 2)));
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(div(-(2), 2)))
    ;;> printString(intToString(div(-(2), 2)))
    ;;> intToString(div(-(2), 2))
    ;;> div(-(2), 2)
    ;;> -(2)
    ;;> 2
    i32.const 2
    i32.const -1
    i32.mul
    ;;> 2
    i32.const 2
    call $BasicArithmetic_div
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(div(-(3), 2)));
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(div(-(3), 2)))
    ;;> printString(intToString(div(-(3), 2)))
    ;;> intToString(div(-(3), 2))
    ;;> div(-(3), 2)
    ;;> -(3)
    ;;> 3
    i32.const 3
    i32.const -1
    i32.mul
    ;;> 2
    i32.const 2
    call $BasicArithmetic_div
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(mod(5, 2)));
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(mod(5, 2)))
    ;;> printString(intToString(mod(5, 2)))
    ;;> intToString(mod(5, 2))
    ;;> mod(5, 2)
    ;;> 5
    i32.const 5
    ;;> 2
    i32.const 2
    call $BasicArithmetic_mod
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(mod(-(5), 2)));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(mod(-(5), 2)))
    ;;> printString(intToString(mod(-(5), 2)))
    ;;> intToString(mod(-(5), 2))
    ;;> mod(-(5), 2)
    ;;> -(5)
    ;;> 5
    i32.const 5
    i32.const -1
    i32.mul
    ;;> 2
    i32.const 2
    call $BasicArithmetic_mod
    call $Std_intToString
    call $Std_printString
    drop
    ;;> printString("test finished")
    ;;> printString("test finished")
    ;;> mkString: test finished
    global.get 0
    i32.const 0
    i32.add
    i32.const 116
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 101
    i32.store8
    global.get 0
    i32.const 2
    i32.add
    i32.const 115
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 116
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 32
    i32.store8
    global.get 0
    i32.const 5
    i32.add
    i32.const 102
    i32.store8
    global.get 0
    i32.const 6
    i32.add
    i32.const 105
    i32.store8
    global.get 0
    i32.const 7
    i32.add
    i32.const 110
    i32.store8
    global.get 0
    i32.const 8
    i32.add
    i32.const 105
    i32.store8
    global.get 0
    i32.const 9
    i32.add
    i32.const 115
    i32.store8
    global.get 0
    i32.const 10
    i32.add
    i32.const 104
    i32.store8
    global.get 0
    i32.const 11
    i32.add
    i32.const 101
    i32.store8
    global.get 0
    i32.const 12
    i32.add
    i32.const 100
    i32.store8
    global.get 0
    i32.const 13
    i32.add
    i32.const 0
    i32.store8
    global.get 0
    i32.const 14
    i32.add
    i32.const 0
    i32.store8
    global.get 0
    i32.const 15
    i32.add
    i32.const 0
    i32.store8
    global.get 0
    global.get 0
    i32.const 16
    i32.add
    global.set 0
    call $Std_printString
    drop
  )
)