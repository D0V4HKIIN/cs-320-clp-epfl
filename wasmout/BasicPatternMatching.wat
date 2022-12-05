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

  (func $BasicPatternMatching_isRegularLetter (param i32) (result i32) (local i32 i32 i32 i32 i32)
    ;;> fn isRegularLetter(l: Letter): Boolean = {
    ;;|   l match {
    ;;|     case A() =>
    ;;|       true
    ;;|     case B() =>
    ;;|       true
    ;;|     case APrim(_) =>
    ;;|       false
    ;;|     case BPrim(_) =>
    ;;|       false
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case A() =>
    ;;|     true
    ;;|   case B() =>
    ;;|     true
    ;;|   case APrim(_) =>
    ;;|     false
    ;;|   case BPrim(_) =>
    ;;|     false
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> A()
    ;;> get scrut pointer and load it's class id
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 0
    i32.eq
    if (result i32)
      ;;> true
      i32.const 1
    else
      ;;> B()
      ;;> get scrut pointer and load it's class id
      local.get 1
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 2
      i32.eq
      if (result i32)
        ;;> true
        i32.const 1
      else
        ;;> APrim(_)
        ;;> get scrut pointer and load it's class id
        local.get 1
        ;;> adtField index: 0
        i32.const 4
        i32.add
        i32.load
        ;;> class id
        i32.const 1
        i32.eq
        ;;> _
        i32.const 1
        i32.and
        if (result i32)
          ;;> false
          i32.const 0
        else
          ;;> BPrim(_)
          ;;> get scrut pointer and load it's class id
          local.get 1
          ;;> adtField index: 0
          i32.const 4
          i32.add
          i32.load
          ;;> class id
          i32.const 3
          i32.eq
          ;;> _
          i32.const 1
          i32.and
          if (result i32)
            ;;> false
            i32.const 0
          else
            unreachable
          end
        end
      end
    end
  )

  (func $BasicPatternMatching_getPrimNumber (param i32) (result i32) (local i32 i32 i32 i32 i32 i32)
    ;;> fn getPrimNumber(l: Letter): Int(32) = {
    ;;|   !(isRegularLetter(l)) match {
    ;;|     case false =>
    ;;|       42
    ;;|     case true =>
    ;;|       l match {
    ;;|         case APrim(i) =>
    ;;|           i
    ;;|         case BPrim(i) =>
    ;;|           i
    ;;|       }
    ;;|   }
    ;;| }
    ;;> !(isRegularLetter(l)) match {
    ;;|   case false =>
    ;;|     42
    ;;|   case true =>
    ;;|     l match {
    ;;|       case APrim(i) =>
    ;;|         i
    ;;|       case BPrim(i) =>
    ;;|         i
    ;;|     }
    ;;| }
    ;;> cg for scrut
    ;;> !(isRegularLetter(l))
    ;;> not
    ;;> isRegularLetter(l)
    ;;> l
    local.get 0
    call $BasicPatternMatching_isRegularLetter
    i32.eqz
    ;;> end of not
    local.set 1
    ;;> finished code for scrut
    ;;> false
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    ;;> false
    i32.const 0
    i32.eq
    if (result i32)
      ;;> 42
      i32.const 42
    else
      ;;> true
      local.get 1
      ;;> adtField index: 0
      i32.const 4
      i32.add
      ;;> true
      i32.const 1
      i32.eq
      if (result i32)
        ;;> l match {
        ;;|   case APrim(i) =>
        ;;|     i
        ;;|   case BPrim(i) =>
        ;;|     i
        ;;| }
        ;;> cg for scrut
        ;;> l
        local.get 0
        local.set 2
        ;;> finished code for scrut
        ;;> APrim(i)
        ;;> get scrut pointer and load it's class id
        local.get 2
        ;;> adtField index: 0
        i32.const 4
        i32.add
        i32.load
        ;;> class id
        i32.const 1
        i32.eq
        ;;> i
        ;;> get scrut
        local.get 2
        ;;> adtField index: 0
        i32.const 4
        i32.add
        i32.load
        ;;> set idLocal
        local.set 6
        i32.const 1
        i32.and
        if (result i32)
          ;;> i
          local.get 6
        else
          ;;> BPrim(i)
          ;;> get scrut pointer and load it's class id
          local.get 2
          ;;> adtField index: 0
          i32.const 4
          i32.add
          i32.load
          ;;> class id
          i32.const 3
          i32.eq
          ;;> i
          ;;> get scrut
          local.get 2
          ;;> adtField index: 0
          i32.const 4
          i32.add
          i32.load
          ;;> set idLocal
          local.set 4
          i32.const 1
          i32.and
          if (result i32)
            ;;> i
            local.get 4
          else
            unreachable
          end
        end
      else
        unreachable
      end
    end
  )

  (func $BasicPatternMatching_isPrimLetter (param i32) (result i32) (local i32)
    ;;> fn isPrimLetter(l: Letter): String = {
    ;;|   getPrimNumber(l) match {
    ;;|     case 42 =>
    ;;|       "not prim"
    ;;|     case _ =>
    ;;|       "prim"
    ;;|   }
    ;;| }
    ;;> getPrimNumber(l) match {
    ;;|   case 42 =>
    ;;|     "not prim"
    ;;|   case _ =>
    ;;|     "prim"
    ;;| }
    ;;> cg for scrut
    ;;> getPrimNumber(l)
    ;;> l
    local.get 0
    call $BasicPatternMatching_getPrimNumber
    local.set 1
    ;;> finished code for scrut
    ;;> 42
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    ;;> 42
    i32.const 42
    i32.eq
    if (result i32)
      ;;> mkString: not prim
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
      i32.const 112
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 114
      i32.store8
      global.get 0
      i32.const 6
      i32.add
      i32.const 105
      i32.store8
      global.get 0
      i32.const 7
      i32.add
      i32.const 109
      i32.store8
      global.get 0
      i32.const 8
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      i32.const 9
      i32.add
      i32.const 0
      i32.store8
      global.get 0
      i32.const 10
      i32.add
      i32.const 0
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
    else
      ;;> _
      i32.const 1
      if (result i32)
        ;;> mkString: prim
        global.get 0
        i32.const 0
        i32.add
        i32.const 112
        i32.store8
        global.get 0
        i32.const 1
        i32.add
        i32.const 114
        i32.store8
        global.get 0
        i32.const 2
        i32.add
        i32.const 105
        i32.store8
        global.get 0
        i32.const 3
        i32.add
        i32.const 109
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
        unreachable
      end
    end
  )
  (export "BasicPatternMatching_main" (func $BasicPatternMatching_main))
  (func $BasicPatternMatching_main (local i32 i32 i32 i32 i32 i32 i32 i32)
    ;;> (
    ;;|   val a: Letter =
    ;;|     A();
    ;;|   val ap: Letter =
    ;;|     APrim(2);
    ;;|   val b: Letter =
    ;;|     B();
    ;;|   val bp: Letter =
    ;;|     BPrim(3);
    ;;|   printString(intToString(getPrimNumber(a)));
    ;;|   printString(intToString(getPrimNumber(b)));
    ;;|   printString(intToString(getPrimNumber(ap)));
    ;;|   printString(intToString(getPrimNumber(bp)));
    ;;|   printString(isPrimLetter(ap));
    ;;|   printString(isPrimLetter(bp));
    ;;|   printString(isPrimLetter(a));
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> A()
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 1
    local.get 1
    i32.const 0
    i32.store
    ;;> put arguments after the id
    ;;> put the pointer of the class to the stack (memboundary)
    global.get 0
    ;;> update memboundary
    global.get 0
    i32.const 4
    i32.add
    global.set 0
    local.set 0
    ;;> (
    ;;|   val ap: Letter =
    ;;|     APrim(2);
    ;;|   val b: Letter =
    ;;|     B();
    ;;|   val bp: Letter =
    ;;|     BPrim(3);
    ;;|   printString(intToString(getPrimNumber(a)));
    ;;|   printString(intToString(getPrimNumber(b)));
    ;;|   printString(intToString(getPrimNumber(ap)));
    ;;|   printString(intToString(getPrimNumber(bp)));
    ;;|   printString(isPrimLetter(ap));
    ;;|   printString(isPrimLetter(bp));
    ;;|   printString(isPrimLetter(a));
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> APrim(2)
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 3
    local.get 3
    i32.const 1
    i32.store
    ;;> put arguments after the id
    global.get 0
    ;;> adtField index: 0
    i32.const 4
    i32.add
    ;;> 2
    i32.const 2
    i32.store
    ;;> put the pointer of the class to the stack (memboundary)
    global.get 0
    ;;> update memboundary
    global.get 0
    i32.const 8
    i32.add
    global.set 0
    local.set 2
    ;;> (
    ;;|   val b: Letter =
    ;;|     B();
    ;;|   val bp: Letter =
    ;;|     BPrim(3);
    ;;|   printString(intToString(getPrimNumber(a)));
    ;;|   printString(intToString(getPrimNumber(b)));
    ;;|   printString(intToString(getPrimNumber(ap)));
    ;;|   printString(intToString(getPrimNumber(bp)));
    ;;|   printString(isPrimLetter(ap));
    ;;|   printString(isPrimLetter(bp));
    ;;|   printString(isPrimLetter(a));
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> B()
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 5
    local.get 5
    i32.const 2
    i32.store
    ;;> put arguments after the id
    ;;> put the pointer of the class to the stack (memboundary)
    global.get 0
    ;;> update memboundary
    global.get 0
    i32.const 4
    i32.add
    global.set 0
    local.set 4
    ;;> (
    ;;|   val bp: Letter =
    ;;|     BPrim(3);
    ;;|   printString(intToString(getPrimNumber(a)));
    ;;|   printString(intToString(getPrimNumber(b)));
    ;;|   printString(intToString(getPrimNumber(ap)));
    ;;|   printString(intToString(getPrimNumber(bp)));
    ;;|   printString(isPrimLetter(ap));
    ;;|   printString(isPrimLetter(bp));
    ;;|   printString(isPrimLetter(a));
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> BPrim(3)
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 7
    local.get 7
    i32.const 3
    i32.store
    ;;> put arguments after the id
    global.get 0
    ;;> adtField index: 0
    i32.const 4
    i32.add
    ;;> 3
    i32.const 3
    i32.store
    ;;> put the pointer of the class to the stack (memboundary)
    global.get 0
    ;;> update memboundary
    global.get 0
    i32.const 8
    i32.add
    global.set 0
    local.set 6
    ;;> printString(intToString(getPrimNumber(a)))
    ;;> printString(intToString(getPrimNumber(a)))
    ;;> intToString(getPrimNumber(a))
    ;;> getPrimNumber(a)
    ;;> a
    local.get 0
    call $BasicPatternMatching_getPrimNumber
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(getPrimNumber(b)));
    ;;|   printString(intToString(getPrimNumber(ap)));
    ;;|   printString(intToString(getPrimNumber(bp)));
    ;;|   printString(isPrimLetter(ap));
    ;;|   printString(isPrimLetter(bp));
    ;;|   printString(isPrimLetter(a));
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(getPrimNumber(b)))
    ;;> printString(intToString(getPrimNumber(b)))
    ;;> intToString(getPrimNumber(b))
    ;;> getPrimNumber(b)
    ;;> b
    local.get 4
    call $BasicPatternMatching_getPrimNumber
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(getPrimNumber(ap)));
    ;;|   printString(intToString(getPrimNumber(bp)));
    ;;|   printString(isPrimLetter(ap));
    ;;|   printString(isPrimLetter(bp));
    ;;|   printString(isPrimLetter(a));
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(getPrimNumber(ap)))
    ;;> printString(intToString(getPrimNumber(ap)))
    ;;> intToString(getPrimNumber(ap))
    ;;> getPrimNumber(ap)
    ;;> ap
    local.get 2
    call $BasicPatternMatching_getPrimNumber
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(intToString(getPrimNumber(bp)));
    ;;|   printString(isPrimLetter(ap));
    ;;|   printString(isPrimLetter(bp));
    ;;|   printString(isPrimLetter(a));
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(intToString(getPrimNumber(bp)))
    ;;> printString(intToString(getPrimNumber(bp)))
    ;;> intToString(getPrimNumber(bp))
    ;;> getPrimNumber(bp)
    ;;> bp
    local.get 6
    call $BasicPatternMatching_getPrimNumber
    call $Std_intToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(isPrimLetter(ap));
    ;;|   printString(isPrimLetter(bp));
    ;;|   printString(isPrimLetter(a));
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(isPrimLetter(ap))
    ;;> printString(isPrimLetter(ap))
    ;;> isPrimLetter(ap)
    ;;> ap
    local.get 2
    call $BasicPatternMatching_isPrimLetter
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(isPrimLetter(bp));
    ;;|   printString(isPrimLetter(a));
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(isPrimLetter(bp))
    ;;> printString(isPrimLetter(bp))
    ;;> isPrimLetter(bp)
    ;;> bp
    local.get 6
    call $BasicPatternMatching_isPrimLetter
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(isPrimLetter(a));
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(isPrimLetter(a))
    ;;> printString(isPrimLetter(a))
    ;;> isPrimLetter(a)
    ;;> a
    local.get 0
    call $BasicPatternMatching_isPrimLetter
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(isPrimLetter(b));
    ;;|   printString("test finished")
    ;;| )
    ;;> printString(isPrimLetter(b))
    ;;> printString(isPrimLetter(b))
    ;;> isPrimLetter(b)
    ;;> b
    local.get 4
    call $BasicPatternMatching_isPrimLetter
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