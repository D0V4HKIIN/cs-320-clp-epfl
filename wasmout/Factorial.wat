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

  (func $Factorial_fact (param i32) (result i32) 
    ;;> fn fact(i: Int(32)): Int(32) = {
    ;;|   (if((i < 2)) {
    ;;|     1
    ;;|   } else {
    ;;|     (i * fact((i - 1)))
    ;;|   })
    ;;| }
    ;;> (if((i < 2)) {
    ;;|   1
    ;;| } else {
    ;;|   (i * fact((i - 1)))
    ;;| })
    ;;> (i < 2)
    ;;> i
    local.get 0
    ;;> 2
    i32.const 2
    i32.lt_s
    if (result i32)
      ;;> 1
      i32.const 1
    else
      ;;> (i * fact((i - 1)))
      ;;> i
      local.get 0
      ;;> fact((i - 1))
      ;;> (i - 1)
      ;;> i
      local.get 0
      ;;> 1
      i32.const 1
      i32.sub
      call $Factorial_fact
      i32.mul
    end
  )
  (export "Factorial_main" (func $Factorial_main))
  (func $Factorial_main 
    ;;> printString(("5! = " ++ intToString(fact(5))))
    ;;> printString(("5! = " ++ intToString(fact(5))))
    ;;> ("5! = " ++ intToString(fact(5)))
    ;;> mkString: 5! = 
    global.get 0
    i32.const 0
    i32.add
    i32.const 53
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 33
    i32.store8
    global.get 0
    i32.const 2
    i32.add
    i32.const 32
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 61
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 32
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
    ;;> intToString(fact(5))
    ;;> fact(5)
    ;;> 5
    i32.const 5
    call $Factorial_fact
    call $Std_intToString
    call $String_concat
    call $Std_printString
    drop
    ;;> printString(("10! = " ++ intToString(fact(10))))
    ;;> printString(("10! = " ++ intToString(fact(10))))
    ;;> ("10! = " ++ intToString(fact(10)))
    ;;> mkString: 10! = 
    global.get 0
    i32.const 0
    i32.add
    i32.const 49
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 48
    i32.store8
    global.get 0
    i32.const 2
    i32.add
    i32.const 33
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 32
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 61
    i32.store8
    global.get 0
    i32.const 5
    i32.add
    i32.const 32
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
    ;;> intToString(fact(10))
    ;;> fact(10)
    ;;> 10
    i32.const 10
    call $Factorial_fact
    call $Std_intToString
    call $String_concat
    call $Std_printString
    drop
  )
)