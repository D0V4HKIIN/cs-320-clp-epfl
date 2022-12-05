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

  (func $Arithmetic_pow (param i32 i32) (result i32) (local i32)
    ;;> fn pow(b: Int(32), e: Int(32)): Int(32) = {
    ;;|   (if((e == 0)) {
    ;;|     1
    ;;|   } else {
    ;;|     (if(((e % 2) == 0)) {
    ;;|       (
    ;;|         val rec: Int(32) =
    ;;|           pow(b, (e / 2));
    ;;|         (rec * rec)
    ;;|       )
    ;;|     } else {
    ;;|       (b * pow(b, (e - 1)))
    ;;|     })
    ;;|   })
    ;;| }
    ;;> (if((e == 0)) {
    ;;|   1
    ;;| } else {
    ;;|   (if(((e % 2) == 0)) {
    ;;|     (
    ;;|       val rec: Int(32) =
    ;;|         pow(b, (e / 2));
    ;;|       (rec * rec)
    ;;|     )
    ;;|   } else {
    ;;|     (b * pow(b, (e - 1)))
    ;;|   })
    ;;| })
    ;;> (e == 0)
    ;;> e
    local.get 1
    ;;> 0
    i32.const 0
    i32.eq
    if (result i32)
      ;;> 1
      i32.const 1
    else
      ;;> (if(((e % 2) == 0)) {
      ;;|   (
      ;;|     val rec: Int(32) =
      ;;|       pow(b, (e / 2));
      ;;|     (rec * rec)
      ;;|   )
      ;;| } else {
      ;;|   (b * pow(b, (e - 1)))
      ;;| })
      ;;> ((e % 2) == 0)
      ;;> (e % 2)
      ;;> e
      local.get 1
      ;;> 2
      i32.const 2
      i32.rem_s
      ;;> 0
      i32.const 0
      i32.eq
      if (result i32)
        ;;> (
        ;;|   val rec: Int(32) =
        ;;|     pow(b, (e / 2));
        ;;|   (rec * rec)
        ;;| )
        ;;> pow(b, (e / 2))
        ;;> b
        local.get 0
        ;;> (e / 2)
        ;;> e
        local.get 1
        ;;> 2
        i32.const 2
        i32.div_s
        call $Arithmetic_pow
        local.set 2
        ;;> (rec * rec)
        ;;> rec
        local.get 2
        ;;> rec
        local.get 2
        i32.mul
      else
        ;;> (b * pow(b, (e - 1)))
        ;;> b
        local.get 0
        ;;> pow(b, (e - 1))
        ;;> b
        local.get 0
        ;;> (e - 1)
        ;;> e
        local.get 1
        ;;> 1
        i32.const 1
        i32.sub
        call $Arithmetic_pow
        i32.mul
      end
    end
  )

  (func $Arithmetic_gcd (param i32 i32) (result i32) 
    ;;> fn gcd(a: Int(32), b: Int(32)): Int(32) = {
    ;;|   (if(((a == 0) || (b == 0))) {
    ;;|     (a + b)
    ;;|   } else {
    ;;|     (if((a < b)) {
    ;;|       gcd(a, (b % a))
    ;;|     } else {
    ;;|       gcd((a % b), b)
    ;;|     })
    ;;|   })
    ;;| }
    ;;> (if(((a == 0) || (b == 0))) {
    ;;|   (a + b)
    ;;| } else {
    ;;|   (if((a < b)) {
    ;;|     gcd(a, (b % a))
    ;;|   } else {
    ;;|     gcd((a % b), b)
    ;;|   })
    ;;| })
    ;;> ((a == 0) || (b == 0))
    ;;> (a == 0)
    ;;> a
    local.get 0
    ;;> 0
    i32.const 0
    i32.eq
    if (result i32)
      i32.const 1
    else
      ;;> (b == 0)
      ;;> b
      local.get 1
      ;;> 0
      i32.const 0
      i32.eq
    end
    if (result i32)
      ;;> (a + b)
      ;;> a
      local.get 0
      ;;> b
      local.get 1
      i32.add
    else
      ;;> (if((a < b)) {
      ;;|   gcd(a, (b % a))
      ;;| } else {
      ;;|   gcd((a % b), b)
      ;;| })
      ;;> (a < b)
      ;;> a
      local.get 0
      ;;> b
      local.get 1
      i32.lt_s
      if (result i32)
        ;;> gcd(a, (b % a))
        ;;> a
        local.get 0
        ;;> (b % a)
        ;;> b
        local.get 1
        ;;> a
        local.get 0
        i32.rem_s
        call $Arithmetic_gcd
      else
        ;;> gcd((a % b), b)
        ;;> (a % b)
        ;;> a
        local.get 0
        ;;> b
        local.get 1
        i32.rem_s
        ;;> b
        local.get 1
        call $Arithmetic_gcd
      end
    end
  )
  (export "Arithmetic_main" (func $Arithmetic_main))
  (func $Arithmetic_main 
    ;;> printInt(pow(0, 10))
    ;;> printInt(pow(0, 10))
    ;;> pow(0, 10)
    ;;> 0
    i32.const 0
    ;;> 10
    i32.const 10
    call $Arithmetic_pow
    call $Std_printInt
    drop
    ;;> (
    ;;|   printInt(pow(1, 5));
    ;;|   printInt(pow(2, 10));
    ;;|   printInt(pow(3, 3));
    ;;|   printInt(gcd(0, 10));
    ;;|   printInt(gcd(17, 99));
    ;;|   printInt(gcd(16, 46));
    ;;|   printInt(gcd(222, 888))
    ;;| )
    ;;> printInt(pow(1, 5))
    ;;> printInt(pow(1, 5))
    ;;> pow(1, 5)
    ;;> 1
    i32.const 1
    ;;> 5
    i32.const 5
    call $Arithmetic_pow
    call $Std_printInt
    drop
    ;;> (
    ;;|   printInt(pow(2, 10));
    ;;|   printInt(pow(3, 3));
    ;;|   printInt(gcd(0, 10));
    ;;|   printInt(gcd(17, 99));
    ;;|   printInt(gcd(16, 46));
    ;;|   printInt(gcd(222, 888))
    ;;| )
    ;;> printInt(pow(2, 10))
    ;;> printInt(pow(2, 10))
    ;;> pow(2, 10)
    ;;> 2
    i32.const 2
    ;;> 10
    i32.const 10
    call $Arithmetic_pow
    call $Std_printInt
    drop
    ;;> (
    ;;|   printInt(pow(3, 3));
    ;;|   printInt(gcd(0, 10));
    ;;|   printInt(gcd(17, 99));
    ;;|   printInt(gcd(16, 46));
    ;;|   printInt(gcd(222, 888))
    ;;| )
    ;;> printInt(pow(3, 3))
    ;;> printInt(pow(3, 3))
    ;;> pow(3, 3)
    ;;> 3
    i32.const 3
    ;;> 3
    i32.const 3
    call $Arithmetic_pow
    call $Std_printInt
    drop
    ;;> (
    ;;|   printInt(gcd(0, 10));
    ;;|   printInt(gcd(17, 99));
    ;;|   printInt(gcd(16, 46));
    ;;|   printInt(gcd(222, 888))
    ;;| )
    ;;> printInt(gcd(0, 10))
    ;;> printInt(gcd(0, 10))
    ;;> gcd(0, 10)
    ;;> 0
    i32.const 0
    ;;> 10
    i32.const 10
    call $Arithmetic_gcd
    call $Std_printInt
    drop
    ;;> (
    ;;|   printInt(gcd(17, 99));
    ;;|   printInt(gcd(16, 46));
    ;;|   printInt(gcd(222, 888))
    ;;| )
    ;;> printInt(gcd(17, 99))
    ;;> printInt(gcd(17, 99))
    ;;> gcd(17, 99)
    ;;> 17
    i32.const 17
    ;;> 99
    i32.const 99
    call $Arithmetic_gcd
    call $Std_printInt
    drop
    ;;> (
    ;;|   printInt(gcd(16, 46));
    ;;|   printInt(gcd(222, 888))
    ;;| )
    ;;> printInt(gcd(16, 46))
    ;;> printInt(gcd(16, 46))
    ;;> gcd(16, 46)
    ;;> 16
    i32.const 16
    ;;> 46
    i32.const 46
    call $Arithmetic_gcd
    call $Std_printInt
    drop
    ;;> printInt(gcd(222, 888))
    ;;> printInt(gcd(222, 888))
    ;;> gcd(222, 888)
    ;;> 222
    i32.const 222
    ;;> 888
    i32.const 888
    call $Arithmetic_gcd
    call $Std_printInt
    drop
  )
)