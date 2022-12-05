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

  (func $BasicBranching_less (param i32 i32) (result i32) 
    ;;> fn less(a: Int(32), b: Int(32)): Boolean = {
    ;;|   (a < b)
    ;;| }
    ;;> (a < b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    i32.lt_s
  )

  (func $BasicBranching_lessOrEqual (param i32 i32) (result i32) 
    ;;> fn lessOrEqual(a: Int(32), b: Int(32)): Boolean = {
    ;;|   (a <= b)
    ;;| }
    ;;> (a <= b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    i32.le_s
  )

  (func $BasicBranching_test1 (result i32) (local i32 i32)
    ;;> fn test1(): Unit = {
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(a, b)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| }
    ;;> (
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(a, b)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> 1
    i32.const 1
    local.set 0
    ;;> (
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(a, b)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> (a + 1)
    ;;> a
    local.get 0
    ;;> 1
    i32.const 1
    i32.add
    local.set 1
    ;;> (if(less(a, b)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> less(a, b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    call $BasicBranching_less
    if (result i32)
      ;;> printString("correct")
      ;;> mkString: correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 116
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
      call $Std_printString
    else
      ;;> printString("not correct")
      ;;> mkString: not correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 110
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 32
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 8
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 9
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 10
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 11
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 12
      i32.add
      global.set 0
      call $Std_printString
    end
  )

  (func $BasicBranching_test2 (result i32) (local i32 i32)
    ;;> fn test2(): Unit = {
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(a, 1)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| }
    ;;> (
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(a, 1)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> 1
    i32.const 1
    local.set 0
    ;;> (
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(a, 1)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> (a + 1)
    ;;> a
    local.get 0
    ;;> 1
    i32.const 1
    i32.add
    local.set 1
    ;;> (if(less(a, 1)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> less(a, 1)
    ;;> a
    local.get 0
    ;;> 1
    i32.const 1
    call $BasicBranching_less
    if (result i32)
      ;;> printString("correct")
      ;;> mkString: correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 116
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
      call $Std_printString
    else
      ;;> printString("not correct")
      ;;> mkString: not correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 110
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 32
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 8
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 9
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 10
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 11
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 12
      i32.add
      global.set 0
      call $Std_printString
    end
  )

  (func $BasicBranching_test3 (result i32) (local i32 i32)
    ;;> fn test3(): Unit = {
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(b, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| }
    ;;> (
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(b, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> 1
    i32.const 1
    local.set 0
    ;;> (
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(b, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> (a + 1)
    ;;> a
    local.get 0
    ;;> 1
    i32.const 1
    i32.add
    local.set 1
    ;;> (if(less(b, a)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> less(b, a)
    ;;> b
    local.get 1
    ;;> a
    local.get 0
    call $BasicBranching_less
    if (result i32)
      ;;> printString("correct")
      ;;> mkString: correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 116
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
      call $Std_printString
    else
      ;;> printString("not correct")
      ;;> mkString: not correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 110
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 32
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 8
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 9
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 10
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 11
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 12
      i32.add
      global.set 0
      call $Std_printString
    end
  )

  (func $BasicBranching_test4 (result i32) (local i32 i32)
    ;;> fn test4(): Unit = {
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(lessOrEqual(a, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| }
    ;;> (
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(lessOrEqual(a, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> 1
    i32.const 1
    local.set 0
    ;;> (
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(lessOrEqual(a, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> (a + 1)
    ;;> a
    local.get 0
    ;;> 1
    i32.const 1
    i32.add
    local.set 1
    ;;> (if(lessOrEqual(a, a)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> lessOrEqual(a, a)
    ;;> a
    local.get 0
    ;;> a
    local.get 0
    call $BasicBranching_lessOrEqual
    if (result i32)
      ;;> printString("correct")
      ;;> mkString: correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 116
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
      call $Std_printString
    else
      ;;> printString("not correct")
      ;;> mkString: not correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 110
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 32
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 8
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 9
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 10
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 11
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 12
      i32.add
      global.set 0
      call $Std_printString
    end
  )

  (func $BasicBranching_test (result i32) (local i32 i32)
    ;;> fn test(): Unit = {
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(a, b)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(less(a, 1)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(less(b, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(lessOrEqual(a, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| }
    ;;> (
    ;;|   val a: Int(32) =
    ;;|     1;
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(a, b)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(less(a, 1)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(less(b, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(lessOrEqual(a, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> 1
    i32.const 1
    local.set 0
    ;;> (
    ;;|   val b: Int(32) =
    ;;|     (a + 1);
    ;;|   (if(less(a, b)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(less(a, 1)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(less(b, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(lessOrEqual(a, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> (a + 1)
    ;;> a
    local.get 0
    ;;> 1
    i32.const 1
    i32.add
    local.set 1
    ;;> (if(less(a, b)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> (if(less(a, b)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> less(a, b)
    ;;> a
    local.get 0
    ;;> b
    local.get 1
    call $BasicBranching_less
    if (result i32)
      ;;> printString("correct")
      ;;> mkString: correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 116
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
      call $Std_printString
    else
      ;;> printString("not correct")
      ;;> mkString: not correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 110
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 32
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 8
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 9
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 10
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 11
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 12
      i32.add
      global.set 0
      call $Std_printString
    end
    drop
    ;;> (
    ;;|   (if(less(a, 1)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(less(b, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(lessOrEqual(a, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> (if(less(a, 1)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> (if(less(a, 1)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> less(a, 1)
    ;;> a
    local.get 0
    ;;> 1
    i32.const 1
    call $BasicBranching_less
    if (result i32)
      ;;> printString("correct")
      ;;> mkString: correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 116
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
      call $Std_printString
    else
      ;;> printString("not correct")
      ;;> mkString: not correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 110
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 32
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 8
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 9
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 10
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 11
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 12
      i32.add
      global.set 0
      call $Std_printString
    end
    drop
    ;;> (
    ;;|   (if(less(b, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   });
    ;;|   (if(lessOrEqual(a, a)) {
    ;;|     printString("correct")
    ;;|   } else {
    ;;|     printString("not correct")
    ;;|   })
    ;;| )
    ;;> (if(less(b, a)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> (if(less(b, a)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> less(b, a)
    ;;> b
    local.get 1
    ;;> a
    local.get 0
    call $BasicBranching_less
    if (result i32)
      ;;> printString("correct")
      ;;> mkString: correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 116
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
      call $Std_printString
    else
      ;;> printString("not correct")
      ;;> mkString: not correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 110
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 32
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 8
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 9
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 10
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 11
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 12
      i32.add
      global.set 0
      call $Std_printString
    end
    drop
    ;;> (if(lessOrEqual(a, a)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> (if(lessOrEqual(a, a)) {
    ;;|   printString("correct")
    ;;| } else {
    ;;|   printString("not correct")
    ;;| })
    ;;> lessOrEqual(a, a)
    ;;> a
    local.get 0
    ;;> a
    local.get 0
    call $BasicBranching_lessOrEqual
    if (result i32)
      ;;> printString("correct")
      ;;> mkString: correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 116
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
      call $Std_printString
    else
      ;;> printString("not correct")
      ;;> mkString: not correct
      global.get 0
      i32.const 0
      i32.add
      i32.const 110
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 2
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 3
      i32.add
      i32.const 32
      i32.store8
      global.get 0
      i32.const 4
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 111
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 8
      i32.add
      i32.const 101
      i32.store8
      global.get 0
      i32.const 9
      i32.add
      i32.const 99
      i32.store8
      global.get 0
      i32.const 10
      i32.add
      i32.const 116
      i32.store8
      global.get 0
      i32.const 11
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      global.get 0
      i32.const 12
      i32.add
      global.set 0
      call $Std_printString
    end
  )
  (export "BasicBranching_main" (func $BasicBranching_main))
  (func $BasicBranching_main 
    ;;> test()
    ;;> test()
    call $BasicBranching_test
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