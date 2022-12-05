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

  (func $O_isDefined (param i32) (result i32) (local i32 i32)
    ;;> fn isDefined(o: Option): Boolean = {
    ;;|   o match {
    ;;|     case None() =>
    ;;|       false
    ;;|     case _ =>
    ;;|       true
    ;;|   }
    ;;| }
    ;;> o match {
    ;;|   case None() =>
    ;;|     false
    ;;|   case _ =>
    ;;|     true
    ;;| }
    ;;> cg for scrut
    ;;> o
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> None()
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
      ;;> false
      i32.const 0
    else
      ;;> _
      i32.const 1
      if (result i32)
        ;;> true
        i32.const 1
      else
        unreachable
      end
    end
  )

  (func $O_get (param i32) (result i32) (local i32 i32 i32 i32)
    ;;> fn get(o: Option): Int(32) = {
    ;;|   o match {
    ;;|     case Some(i) =>
    ;;|       i
    ;;|     case None() =>
    ;;|       error("get(None)")
    ;;|   }
    ;;| }
    ;;> o match {
    ;;|   case Some(i) =>
    ;;|     i
    ;;|   case None() =>
    ;;|     error("get(None)")
    ;;| }
    ;;> cg for scrut
    ;;> o
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Some(i)
    ;;> get scrut pointer and load it's class id
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 1
    i32.eq
    ;;> i
    ;;> get scrut
    local.get 1
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
      ;;> None()
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
        ;;> error("get(None)")
        ;;> mkString: get(None)
        global.get 0
        i32.const 0
        i32.add
        i32.const 103
        i32.store8
        global.get 0
        i32.const 1
        i32.add
        i32.const 101
        i32.store8
        global.get 0
        i32.const 2
        i32.add
        i32.const 116
        i32.store8
        global.get 0
        i32.const 3
        i32.add
        i32.const 40
        i32.store8
        global.get 0
        i32.const 4
        i32.add
        i32.const 78
        i32.store8
        global.get 0
        i32.const 5
        i32.add
        i32.const 111
        i32.store8
        global.get 0
        i32.const 6
        i32.add
        i32.const 110
        i32.store8
        global.get 0
        i32.const 7
        i32.add
        i32.const 101
        i32.store8
        global.get 0
        i32.const 8
        i32.add
        i32.const 41
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
        call $Std_printString
        unreachable
      else
        unreachable
      end
    end
  )

  (func $O_getOrElse (param i32 i32) (result i32) (local i32 i32 i32 i32)
    ;;> fn getOrElse(o: Option, i: Int(32)): Int(32) = {
    ;;|   o match {
    ;;|     case None() =>
    ;;|       i
    ;;|     case Some(oo) =>
    ;;|       oo
    ;;|   }
    ;;| }
    ;;> o match {
    ;;|   case None() =>
    ;;|     i
    ;;|   case Some(oo) =>
    ;;|     oo
    ;;| }
    ;;> cg for scrut
    ;;> o
    local.get 0
    local.set 2
    ;;> finished code for scrut
    ;;> None()
    ;;> get scrut pointer and load it's class id
    local.get 2
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 0
    i32.eq
    if (result i32)
      ;;> i
      local.get 1
    else
      ;;> Some(oo)
      ;;> get scrut pointer and load it's class id
      local.get 2
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 1
      i32.eq
      ;;> oo
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
        ;;> oo
        local.get 4
      else
        unreachable
      end
    end
  )

  (func $O_orElse (param i32 i32) (result i32) (local i32 i32 i32)
    ;;> fn orElse(o1: Option, o2: Option): Option = {
    ;;|   o1 match {
    ;;|     case Some(_) =>
    ;;|       o1
    ;;|     case None() =>
    ;;|       o2
    ;;|   }
    ;;| }
    ;;> o1 match {
    ;;|   case Some(_) =>
    ;;|     o1
    ;;|   case None() =>
    ;;|     o2
    ;;| }
    ;;> cg for scrut
    ;;> o1
    local.get 0
    local.set 2
    ;;> finished code for scrut
    ;;> Some(_)
    ;;> get scrut pointer and load it's class id
    local.get 2
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
      ;;> o1
      local.get 0
    else
      ;;> None()
      ;;> get scrut pointer and load it's class id
      local.get 2
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 0
      i32.eq
      if (result i32)
        ;;> o2
        local.get 1
      else
        unreachable
      end
    end
  )

  (func $O_toList (param i32) (result i32) (local i32 i32 i32 i32 i32 i32 i32)
    ;;> fn toList(o: Option): List = {
    ;;|   o match {
    ;;|     case Some(i) =>
    ;;|       Cons(i, Nil())
    ;;|     case None() =>
    ;;|       Nil()
    ;;|   }
    ;;| }
    ;;> o match {
    ;;|   case Some(i) =>
    ;;|     Cons(i, Nil())
    ;;|   case None() =>
    ;;|     Nil()
    ;;| }
    ;;> cg for scrut
    ;;> o
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Some(i)
    ;;> get scrut pointer and load it's class id
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 1
    i32.eq
    ;;> i
    ;;> get scrut
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> set idLocal
    local.set 5
    i32.const 1
    i32.and
    if (result i32)
      ;;> Cons(i, Nil())
      ;;> store constructor id to the memory boundary
      global.get 0
      local.set 7
      local.get 7
      i32.const 1
      i32.store
      ;;> put arguments after the id
      global.get 0
      ;;> adtField index: 1
      i32.const 8
      i32.add
      ;;> Nil()
      ;;> store constructor id to the memory boundary
      global.get 0
      local.set 6
      local.get 6
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
      i32.store
      global.get 0
      ;;> adtField index: 0
      i32.const 4
      i32.add
      ;;> i
      local.get 5
      i32.store
      ;;> put the pointer of the class to the stack (memboundary)
      global.get 0
      ;;> update memboundary
      global.get 0
      i32.const 12
      i32.add
      global.set 0
    else
      ;;> None()
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
        ;;> Nil()
        ;;> store constructor id to the memory boundary
        global.get 0
        local.set 3
        local.get 3
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
      else
        unreachable
      end
    end
  )

  (func $L_isEmpty (param i32) (result i32) (local i32 i32)
    ;;> fn isEmpty(l: List): Boolean = {
    ;;|   l match {
    ;;|     case Nil() =>
    ;;|       true
    ;;|     case _ =>
    ;;|       false
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Nil() =>
    ;;|     true
    ;;|   case _ =>
    ;;|     false
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Nil()
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
      ;;> _
      i32.const 1
      if (result i32)
        ;;> false
        i32.const 0
      else
        unreachable
      end
    end
  )

  (func $L_length (param i32) (result i32) (local i32 i32 i32 i32)
    ;;> fn length(l: List): Int(32) = {
    ;;|   l match {
    ;;|     case Nil() =>
    ;;|       0
    ;;|     case Cons(_, t) =>
    ;;|       (1 + length(t))
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Nil() =>
    ;;|     0
    ;;|   case Cons(_, t) =>
    ;;|     (1 + length(t))
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Nil()
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
      ;;> 0
      i32.const 0
    else
      ;;> Cons(_, t)
      ;;> get scrut pointer and load it's class id
      local.get 1
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 1
      i32.eq
      ;;> t
      ;;> get scrut
      local.get 1
      ;;> adtField index: 1
      i32.const 8
      i32.add
      i32.load
      ;;> set idLocal
      local.set 3
      i32.const 1
      i32.and
      ;;> _
      i32.const 1
      i32.and
      if (result i32)
        ;;> (1 + length(t))
        ;;> 1
        i32.const 1
        ;;> length(t)
        ;;> t
        local.get 3
        call $L_length
        i32.add
      else
        unreachable
      end
    end
  )

  (func $L_head (param i32) (result i32) (local i32 i32 i32 i32)
    ;;> fn head(l: List): Int(32) = {
    ;;|   l match {
    ;;|     case Cons(h, _) =>
    ;;|       h
    ;;|     case Nil() =>
    ;;|       error("head(Nil)")
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Cons(h, _) =>
    ;;|     h
    ;;|   case Nil() =>
    ;;|     error("head(Nil)")
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Cons(h, _)
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
    ;;> h
    ;;> get scrut
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> set idLocal
    local.set 4
    i32.const 1
    i32.and
    if (result i32)
      ;;> h
      local.get 4
    else
      ;;> Nil()
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
        ;;> error("head(Nil)")
        ;;> mkString: head(Nil)
        global.get 0
        i32.const 0
        i32.add
        i32.const 104
        i32.store8
        global.get 0
        i32.const 1
        i32.add
        i32.const 101
        i32.store8
        global.get 0
        i32.const 2
        i32.add
        i32.const 97
        i32.store8
        global.get 0
        i32.const 3
        i32.add
        i32.const 100
        i32.store8
        global.get 0
        i32.const 4
        i32.add
        i32.const 40
        i32.store8
        global.get 0
        i32.const 5
        i32.add
        i32.const 78
        i32.store8
        global.get 0
        i32.const 6
        i32.add
        i32.const 105
        i32.store8
        global.get 0
        i32.const 7
        i32.add
        i32.const 108
        i32.store8
        global.get 0
        i32.const 8
        i32.add
        i32.const 41
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
        call $Std_printString
        unreachable
      else
        unreachable
      end
    end
  )

  (func $L_headOption (param i32) (result i32) (local i32 i32 i32 i32 i32 i32)
    ;;> fn headOption(l: List): Option = {
    ;;|   l match {
    ;;|     case Cons(h, _) =>
    ;;|       Some(h)
    ;;|     case Nil() =>
    ;;|       None()
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Cons(h, _) =>
    ;;|     Some(h)
    ;;|   case Nil() =>
    ;;|     None()
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Cons(h, _)
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
    ;;> h
    ;;> get scrut
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> set idLocal
    local.set 5
    i32.const 1
    i32.and
    if (result i32)
      ;;> Some(h)
      ;;> store constructor id to the memory boundary
      global.get 0
      local.set 6
      local.get 6
      i32.const 1
      i32.store
      ;;> put arguments after the id
      global.get 0
      ;;> adtField index: 0
      i32.const 4
      i32.add
      ;;> h
      local.get 5
      i32.store
      ;;> put the pointer of the class to the stack (memboundary)
      global.get 0
      ;;> update memboundary
      global.get 0
      i32.const 8
      i32.add
      global.set 0
    else
      ;;> Nil()
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
        ;;> None()
        ;;> store constructor id to the memory boundary
        global.get 0
        local.set 3
        local.get 3
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
      else
        unreachable
      end
    end
  )

  (func $L_reverse (param i32) (result i32) (local i32)
    ;;> fn reverse(l: List): List = {
    ;;|   reverseAcc(l, Nil())
    ;;| }
    ;;> reverseAcc(l, Nil())
    ;;> l
    local.get 0
    ;;> Nil()
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
    call $L_reverseAcc
  )

  (func $L_reverseAcc (param i32 i32) (result i32) (local i32 i32 i32 i32 i32 i32)
    ;;> fn reverseAcc(l: List, acc: List): List = {
    ;;|   l match {
    ;;|     case Nil() =>
    ;;|       acc
    ;;|     case Cons(h, t) =>
    ;;|       reverseAcc(t, Cons(h, acc))
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Nil() =>
    ;;|     acc
    ;;|   case Cons(h, t) =>
    ;;|     reverseAcc(t, Cons(h, acc))
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 2
    ;;> finished code for scrut
    ;;> Nil()
    ;;> get scrut pointer and load it's class id
    local.get 2
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 0
    i32.eq
    if (result i32)
      ;;> acc
      local.get 1
    else
      ;;> Cons(h, t)
      ;;> get scrut pointer and load it's class id
      local.get 2
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 1
      i32.eq
      ;;> t
      ;;> get scrut
      local.get 2
      ;;> adtField index: 1
      i32.const 8
      i32.add
      i32.load
      ;;> set idLocal
      local.set 5
      i32.const 1
      i32.and
      ;;> h
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
        ;;> reverseAcc(t, Cons(h, acc))
        ;;> t
        local.get 5
        ;;> Cons(h, acc)
        ;;> store constructor id to the memory boundary
        global.get 0
        local.set 6
        local.get 6
        i32.const 1
        i32.store
        ;;> put arguments after the id
        global.get 0
        ;;> adtField index: 1
        i32.const 8
        i32.add
        ;;> acc
        local.get 1
        i32.store
        global.get 0
        ;;> adtField index: 0
        i32.const 4
        i32.add
        ;;> h
        local.get 4
        i32.store
        ;;> put the pointer of the class to the stack (memboundary)
        global.get 0
        ;;> update memboundary
        global.get 0
        i32.const 12
        i32.add
        global.set 0
        call $L_reverseAcc
      else
        unreachable
      end
    end
  )

  (func $L_indexOf (param i32 i32) (result i32) (local i32 i32 i32 i32 i32 i32)
    ;;> fn indexOf(l: List, i: Int(32)): Int(32) = {
    ;;|   l match {
    ;;|     case Nil() =>
    ;;|       -(1)
    ;;|     case Cons(h, t) =>
    ;;|       (if((h == i)) {
    ;;|         0
    ;;|       } else {
    ;;|         (
    ;;|           val rec: Int(32) =
    ;;|             indexOf(t, i);
    ;;|           (if((0 <= rec)) {
    ;;|             (rec + 1)
    ;;|           } else {
    ;;|             -(1)
    ;;|           })
    ;;|         )
    ;;|       })
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Nil() =>
    ;;|     -(1)
    ;;|   case Cons(h, t) =>
    ;;|     (if((h == i)) {
    ;;|       0
    ;;|     } else {
    ;;|       (
    ;;|         val rec: Int(32) =
    ;;|           indexOf(t, i);
    ;;|         (if((0 <= rec)) {
    ;;|           (rec + 1)
    ;;|         } else {
    ;;|           -(1)
    ;;|         })
    ;;|       )
    ;;|     })
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 2
    ;;> finished code for scrut
    ;;> Nil()
    ;;> get scrut pointer and load it's class id
    local.get 2
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 0
    i32.eq
    if (result i32)
      ;;> -(1)
      ;;> 1
      i32.const 1
      i32.const -1
      i32.mul
    else
      ;;> Cons(h, t)
      ;;> get scrut pointer and load it's class id
      local.get 2
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 1
      i32.eq
      ;;> t
      ;;> get scrut
      local.get 2
      ;;> adtField index: 1
      i32.const 8
      i32.add
      i32.load
      ;;> set idLocal
      local.set 5
      i32.const 1
      i32.and
      ;;> h
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
        ;;> (if((h == i)) {
        ;;|   0
        ;;| } else {
        ;;|   (
        ;;|     val rec: Int(32) =
        ;;|       indexOf(t, i);
        ;;|     (if((0 <= rec)) {
        ;;|       (rec + 1)
        ;;|     } else {
        ;;|       -(1)
        ;;|     })
        ;;|   )
        ;;| })
        ;;> (h == i)
        ;;> h
        local.get 4
        ;;> i
        local.get 1
        i32.eq
        if (result i32)
          ;;> 0
          i32.const 0
        else
          ;;> (
          ;;|   val rec: Int(32) =
          ;;|     indexOf(t, i);
          ;;|   (if((0 <= rec)) {
          ;;|     (rec + 1)
          ;;|   } else {
          ;;|     -(1)
          ;;|   })
          ;;| )
          ;;> indexOf(t, i)
          ;;> t
          local.get 5
          ;;> i
          local.get 1
          call $L_indexOf
          local.set 6
          ;;> (if((0 <= rec)) {
          ;;|   (rec + 1)
          ;;| } else {
          ;;|   -(1)
          ;;| })
          ;;> (0 <= rec)
          ;;> 0
          i32.const 0
          ;;> rec
          local.get 6
          i32.le_s
          if (result i32)
            ;;> (rec + 1)
            ;;> rec
            local.get 6
            ;;> 1
            i32.const 1
            i32.add
          else
            ;;> -(1)
            ;;> 1
            i32.const 1
            i32.const -1
            i32.mul
          end
        end
      else
        unreachable
      end
    end
  )

  (func $L_range (param i32 i32) (result i32) (local i32 i32)
    ;;> fn range(from: Int(32), to: Int(32)): List = {
    ;;|   (if((to < from)) {
    ;;|     Nil()
    ;;|   } else {
    ;;|     Cons(from, range((from + 1), to))
    ;;|   })
    ;;| }
    ;;> (if((to < from)) {
    ;;|   Nil()
    ;;| } else {
    ;;|   Cons(from, range((from + 1), to))
    ;;| })
    ;;> (to < from)
    ;;> to
    local.get 1
    ;;> from
    local.get 0
    i32.lt_s
    if (result i32)
      ;;> Nil()
      ;;> store constructor id to the memory boundary
      global.get 0
      local.set 2
      local.get 2
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
    else
      ;;> Cons(from, range((from + 1), to))
      ;;> store constructor id to the memory boundary
      global.get 0
      local.set 3
      local.get 3
      i32.const 1
      i32.store
      ;;> put arguments after the id
      global.get 0
      ;;> adtField index: 1
      i32.const 8
      i32.add
      ;;> range((from + 1), to)
      ;;> (from + 1)
      ;;> from
      local.get 0
      ;;> 1
      i32.const 1
      i32.add
      ;;> to
      local.get 1
      call $L_range
      i32.store
      global.get 0
      ;;> adtField index: 0
      i32.const 4
      i32.add
      ;;> from
      local.get 0
      i32.store
      ;;> put the pointer of the class to the stack (memboundary)
      global.get 0
      ;;> update memboundary
      global.get 0
      i32.const 12
      i32.add
      global.set 0
    end
  )

  (func $L_sum (param i32) (result i32) (local i32 i32 i32 i32 i32)
    ;;> fn sum(l: List): Int(32) = {
    ;;|   l match {
    ;;|     case Nil() =>
    ;;|       0
    ;;|     case Cons(h, t) =>
    ;;|       (h + sum(t))
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Nil() =>
    ;;|     0
    ;;|   case Cons(h, t) =>
    ;;|     (h + sum(t))
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Nil()
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
      ;;> 0
      i32.const 0
    else
      ;;> Cons(h, t)
      ;;> get scrut pointer and load it's class id
      local.get 1
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 1
      i32.eq
      ;;> t
      ;;> get scrut
      local.get 1
      ;;> adtField index: 1
      i32.const 8
      i32.add
      i32.load
      ;;> set idLocal
      local.set 4
      i32.const 1
      i32.and
      ;;> h
      ;;> get scrut
      local.get 1
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> set idLocal
      local.set 3
      i32.const 1
      i32.and
      if (result i32)
        ;;> (h + sum(t))
        ;;> h
        local.get 3
        ;;> sum(t)
        ;;> t
        local.get 4
        call $L_sum
        i32.add
      else
        unreachable
      end
    end
  )

  (func $L_concat (param i32 i32) (result i32) (local i32 i32 i32 i32 i32 i32)
    ;;> fn concat(l1: List, l2: List): List = {
    ;;|   l1 match {
    ;;|     case Nil() =>
    ;;|       l2
    ;;|     case Cons(h, t) =>
    ;;|       Cons(h, concat(l1, l2))
    ;;|   }
    ;;| }
    ;;> l1 match {
    ;;|   case Nil() =>
    ;;|     l2
    ;;|   case Cons(h, t) =>
    ;;|     Cons(h, concat(l1, l2))
    ;;| }
    ;;> cg for scrut
    ;;> l1
    local.get 0
    local.set 2
    ;;> finished code for scrut
    ;;> Nil()
    ;;> get scrut pointer and load it's class id
    local.get 2
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 0
    i32.eq
    if (result i32)
      ;;> l2
      local.get 1
    else
      ;;> Cons(h, t)
      ;;> get scrut pointer and load it's class id
      local.get 2
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 1
      i32.eq
      ;;> t
      ;;> get scrut
      local.get 2
      ;;> adtField index: 1
      i32.const 8
      i32.add
      i32.load
      ;;> set idLocal
      local.set 5
      i32.const 1
      i32.and
      ;;> h
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
        ;;> Cons(h, concat(l1, l2))
        ;;> store constructor id to the memory boundary
        global.get 0
        local.set 6
        local.get 6
        i32.const 1
        i32.store
        ;;> put arguments after the id
        global.get 0
        ;;> adtField index: 1
        i32.const 8
        i32.add
        ;;> concat(l1, l2)
        ;;> l1
        local.get 0
        ;;> l2
        local.get 1
        call $L_concat
        i32.store
        global.get 0
        ;;> adtField index: 0
        i32.const 4
        i32.add
        ;;> h
        local.get 4
        i32.store
        ;;> put the pointer of the class to the stack (memboundary)
        global.get 0
        ;;> update memboundary
        global.get 0
        i32.const 12
        i32.add
        global.set 0
      else
        unreachable
      end
    end
  )

  (func $L_contains (param i32 i32) (result i32) (local i32 i32 i32 i32 i32)
    ;;> fn contains(l: List, elem: Int(32)): Boolean = {
    ;;|   l match {
    ;;|     case Nil() =>
    ;;|       false
    ;;|     case Cons(h, t) =>
    ;;|       ((h == elem) || contains(t, elem))
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Nil() =>
    ;;|     false
    ;;|   case Cons(h, t) =>
    ;;|     ((h == elem) || contains(t, elem))
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 2
    ;;> finished code for scrut
    ;;> Nil()
    ;;> get scrut pointer and load it's class id
    local.get 2
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 0
    i32.eq
    if (result i32)
      ;;> false
      i32.const 0
    else
      ;;> Cons(h, t)
      ;;> get scrut pointer and load it's class id
      local.get 2
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 1
      i32.eq
      ;;> t
      ;;> get scrut
      local.get 2
      ;;> adtField index: 1
      i32.const 8
      i32.add
      i32.load
      ;;> set idLocal
      local.set 5
      i32.const 1
      i32.and
      ;;> h
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
        ;;> ((h == elem) || contains(t, elem))
        ;;> (h == elem)
        ;;> h
        local.get 4
        ;;> elem
        local.get 1
        i32.eq
        if (result i32)
          i32.const 1
        else
          ;;> contains(t, elem)
          ;;> t
          local.get 5
          ;;> elem
          local.get 1
          call $L_contains
        end
      else
        unreachable
      end
    end
  )

  (func $L_merge (param i32 i32) (result i32) (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    ;;> fn merge(l1: List, l2: List): List = {
    ;;|   l1 match {
    ;;|     case Nil() =>
    ;;|       l2
    ;;|     case Cons(h1, t1) =>
    ;;|       l2 match {
    ;;|         case Nil() =>
    ;;|           l1
    ;;|         case Cons(h2, t2) =>
    ;;|           (if((h1 <= h2)) {
    ;;|             Cons(h1, merge(t1, l2))
    ;;|           } else {
    ;;|             Cons(h2, merge(l1, t2))
    ;;|           })
    ;;|       }
    ;;|   }
    ;;| }
    ;;> l1 match {
    ;;|   case Nil() =>
    ;;|     l2
    ;;|   case Cons(h1, t1) =>
    ;;|     l2 match {
    ;;|       case Nil() =>
    ;;|         l1
    ;;|       case Cons(h2, t2) =>
    ;;|         (if((h1 <= h2)) {
    ;;|           Cons(h1, merge(t1, l2))
    ;;|         } else {
    ;;|           Cons(h2, merge(l1, t2))
    ;;|         })
    ;;|     }
    ;;| }
    ;;> cg for scrut
    ;;> l1
    local.get 0
    local.set 2
    ;;> finished code for scrut
    ;;> Nil()
    ;;> get scrut pointer and load it's class id
    local.get 2
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 0
    i32.eq
    if (result i32)
      ;;> l2
      local.get 1
    else
      ;;> Cons(h1, t1)
      ;;> get scrut pointer and load it's class id
      local.get 2
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 1
      i32.eq
      ;;> t1
      ;;> get scrut
      local.get 2
      ;;> adtField index: 1
      i32.const 8
      i32.add
      i32.load
      ;;> set idLocal
      local.set 5
      i32.const 1
      i32.and
      ;;> h1
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
        ;;> l2 match {
        ;;|   case Nil() =>
        ;;|     l1
        ;;|   case Cons(h2, t2) =>
        ;;|     (if((h1 <= h2)) {
        ;;|       Cons(h1, merge(t1, l2))
        ;;|     } else {
        ;;|       Cons(h2, merge(l1, t2))
        ;;|     })
        ;;| }
        ;;> cg for scrut
        ;;> l2
        local.get 1
        local.set 6
        ;;> finished code for scrut
        ;;> Nil()
        ;;> get scrut pointer and load it's class id
        local.get 6
        ;;> adtField index: 0
        i32.const 4
        i32.add
        i32.load
        ;;> class id
        i32.const 0
        i32.eq
        if (result i32)
          ;;> l1
          local.get 0
        else
          ;;> Cons(h2, t2)
          ;;> get scrut pointer and load it's class id
          local.get 6
          ;;> adtField index: 0
          i32.const 4
          i32.add
          i32.load
          ;;> class id
          i32.const 1
          i32.eq
          ;;> t2
          ;;> get scrut
          local.get 6
          ;;> adtField index: 1
          i32.const 8
          i32.add
          i32.load
          ;;> set idLocal
          local.set 9
          i32.const 1
          i32.and
          ;;> h2
          ;;> get scrut
          local.get 6
          ;;> adtField index: 0
          i32.const 4
          i32.add
          i32.load
          ;;> set idLocal
          local.set 8
          i32.const 1
          i32.and
          if (result i32)
            ;;> (if((h1 <= h2)) {
            ;;|   Cons(h1, merge(t1, l2))
            ;;| } else {
            ;;|   Cons(h2, merge(l1, t2))
            ;;| })
            ;;> (h1 <= h2)
            ;;> h1
            local.get 4
            ;;> h2
            local.get 8
            i32.le_s
            if (result i32)
              ;;> Cons(h1, merge(t1, l2))
              ;;> store constructor id to the memory boundary
              global.get 0
              local.set 10
              local.get 10
              i32.const 1
              i32.store
              ;;> put arguments after the id
              global.get 0
              ;;> adtField index: 1
              i32.const 8
              i32.add
              ;;> merge(t1, l2)
              ;;> t1
              local.get 5
              ;;> l2
              local.get 1
              call $L_merge
              i32.store
              global.get 0
              ;;> adtField index: 0
              i32.const 4
              i32.add
              ;;> h1
              local.get 4
              i32.store
              ;;> put the pointer of the class to the stack (memboundary)
              global.get 0
              ;;> update memboundary
              global.get 0
              i32.const 12
              i32.add
              global.set 0
            else
              ;;> Cons(h2, merge(l1, t2))
              ;;> store constructor id to the memory boundary
              global.get 0
              local.set 11
              local.get 11
              i32.const 1
              i32.store
              ;;> put arguments after the id
              global.get 0
              ;;> adtField index: 1
              i32.const 8
              i32.add
              ;;> merge(l1, t2)
              ;;> l1
              local.get 0
              ;;> t2
              local.get 9
              call $L_merge
              i32.store
              global.get 0
              ;;> adtField index: 0
              i32.const 4
              i32.add
              ;;> h2
              local.get 8
              i32.store
              ;;> put the pointer of the class to the stack (memboundary)
              global.get 0
              ;;> update memboundary
              global.get 0
              i32.const 12
              i32.add
              global.set 0
            end
          else
            unreachable
          end
        end
      else
        unreachable
      end
    end
  )

  (func $L_split (param i32) (result i32) (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    ;;> fn split(l: List): LPair = {
    ;;|   l match {
    ;;|     case Cons(h1, Cons(h2, t)) =>
    ;;|       (
    ;;|         val rec: LPair =
    ;;|           split(t);
    ;;|         rec match {
    ;;|           case LP(rec1, rec2) =>
    ;;|             LP(Cons(h1, rec1), Cons(h2, rec2))
    ;;|         }
    ;;|       )
    ;;|     case _ =>
    ;;|       LP(l, Nil())
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Cons(h1, Cons(h2, t)) =>
    ;;|     (
    ;;|       val rec: LPair =
    ;;|         split(t);
    ;;|       rec match {
    ;;|         case LP(rec1, rec2) =>
    ;;|           LP(Cons(h1, rec1), Cons(h2, rec2))
    ;;|       }
    ;;|     )
    ;;|   case _ =>
    ;;|     LP(l, Nil())
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Cons(h1, Cons(h2, t))
    ;;> get scrut pointer and load it's class id
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 1
    i32.eq
    ;;> Cons(h2, t)
    ;;> get scrut pointer and load it's class id
    local.get 1
    ;;> adtField index: 1
    i32.const 8
    i32.add
    i32.load
    ;;> class id
    i32.const 1
    i32.eq
    ;;> t
    ;;> get scrut
    local.get 1
    ;;> adtField index: 1
    i32.const 8
    i32.add
    i32.load
    ;;> set idLocal
    local.set 8
    i32.const 1
    i32.and
    ;;> h2
    ;;> get scrut
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> set idLocal
    local.set 7
    i32.const 1
    i32.and
    i32.and
    ;;> h1
    ;;> get scrut
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> set idLocal
    local.set 5
    i32.const 1
    i32.and
    if (result i32)
      ;;> (
      ;;|   val rec: LPair =
      ;;|     split(t);
      ;;|   rec match {
      ;;|     case LP(rec1, rec2) =>
      ;;|       LP(Cons(h1, rec1), Cons(h2, rec2))
      ;;|   }
      ;;| )
      ;;> split(t)
      ;;> t
      local.get 8
      call $L_split
      local.set 9
      ;;> rec match {
      ;;|   case LP(rec1, rec2) =>
      ;;|     LP(Cons(h1, rec1), Cons(h2, rec2))
      ;;| }
      ;;> cg for scrut
      ;;> rec
      local.get 9
      local.set 10
      ;;> finished code for scrut
      ;;> LP(rec1, rec2)
      ;;> get scrut pointer and load it's class id
      local.get 10
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 0
      i32.eq
      ;;> rec2
      ;;> get scrut
      local.get 10
      ;;> adtField index: 1
      i32.const 8
      i32.add
      i32.load
      ;;> set idLocal
      local.set 13
      i32.const 1
      i32.and
      ;;> rec1
      ;;> get scrut
      local.get 10
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> set idLocal
      local.set 12
      i32.const 1
      i32.and
      if (result i32)
        ;;> LP(Cons(h1, rec1), Cons(h2, rec2))
        ;;> store constructor id to the memory boundary
        global.get 0
        local.set 16
        local.get 16
        i32.const 0
        i32.store
        ;;> put arguments after the id
        global.get 0
        ;;> adtField index: 1
        i32.const 8
        i32.add
        ;;> Cons(h2, rec2)
        ;;> store constructor id to the memory boundary
        global.get 0
        local.set 15
        local.get 15
        i32.const 1
        i32.store
        ;;> put arguments after the id
        global.get 0
        ;;> adtField index: 1
        i32.const 8
        i32.add
        ;;> rec2
        local.get 13
        i32.store
        global.get 0
        ;;> adtField index: 0
        i32.const 4
        i32.add
        ;;> h2
        local.get 7
        i32.store
        ;;> put the pointer of the class to the stack (memboundary)
        global.get 0
        ;;> update memboundary
        global.get 0
        i32.const 12
        i32.add
        global.set 0
        i32.store
        global.get 0
        ;;> adtField index: 0
        i32.const 4
        i32.add
        ;;> Cons(h1, rec1)
        ;;> store constructor id to the memory boundary
        global.get 0
        local.set 14
        local.get 14
        i32.const 1
        i32.store
        ;;> put arguments after the id
        global.get 0
        ;;> adtField index: 1
        i32.const 8
        i32.add
        ;;> rec1
        local.get 12
        i32.store
        global.get 0
        ;;> adtField index: 0
        i32.const 4
        i32.add
        ;;> h1
        local.get 5
        i32.store
        ;;> put the pointer of the class to the stack (memboundary)
        global.get 0
        ;;> update memboundary
        global.get 0
        i32.const 12
        i32.add
        global.set 0
        i32.store
        ;;> put the pointer of the class to the stack (memboundary)
        global.get 0
        ;;> update memboundary
        global.get 0
        i32.const 12
        i32.add
        global.set 0
      else
        unreachable
      end
    else
      ;;> _
      i32.const 1
      if (result i32)
        ;;> LP(l, Nil())
        ;;> store constructor id to the memory boundary
        global.get 0
        local.set 3
        local.get 3
        i32.const 0
        i32.store
        ;;> put arguments after the id
        global.get 0
        ;;> adtField index: 1
        i32.const 8
        i32.add
        ;;> Nil()
        ;;> store constructor id to the memory boundary
        global.get 0
        local.set 2
        local.get 2
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
        i32.store
        global.get 0
        ;;> adtField index: 0
        i32.const 4
        i32.add
        ;;> l
        local.get 0
        i32.store
        ;;> put the pointer of the class to the stack (memboundary)
        global.get 0
        ;;> update memboundary
        global.get 0
        i32.const 12
        i32.add
        global.set 0
      else
        unreachable
      end
    end
  )

  (func $L_mergeSort (param i32) (result i32) (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    ;;> fn mergeSort(l: List): List = {
    ;;|   l match {
    ;;|     case Nil() =>
    ;;|       l
    ;;|     case Cons(h, Nil()) =>
    ;;|       l
    ;;|     case l =>
    ;;|       split(l) match {
    ;;|         case LP(l1, l2) =>
    ;;|           merge(mergeSort(l1), mergeSort(l2))
    ;;|       }
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Nil() =>
    ;;|     l
    ;;|   case Cons(h, Nil()) =>
    ;;|     l
    ;;|   case l =>
    ;;|     split(l) match {
    ;;|       case LP(l1, l2) =>
    ;;|         merge(mergeSort(l1), mergeSort(l2))
    ;;|     }
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Nil()
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
      ;;> l
      local.get 0
    else
      ;;> Cons(h, Nil())
      ;;> get scrut pointer and load it's class id
      local.get 1
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 1
      i32.eq
      ;;> Nil()
      ;;> get scrut pointer and load it's class id
      local.get 1
      ;;> adtField index: 1
      i32.const 8
      i32.add
      i32.load
      ;;> class id
      i32.const 0
      i32.eq
      i32.and
      ;;> h
      ;;> get scrut
      local.get 1
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> set idLocal
      local.set 8
      i32.const 1
      i32.and
      if (result i32)
        ;;> l
        local.get 0
      else
        ;;> l
        ;;> get scrut
        local.get 1
        ;;> adtField index: 0
        i32.const 4
        i32.add
        i32.load
        ;;> set idLocal
        local.set 2
        i32.const 1
        if (result i32)
          ;;> split(l) match {
          ;;|   case LP(l1, l2) =>
          ;;|     merge(mergeSort(l1), mergeSort(l2))
          ;;| }
          ;;> cg for scrut
          ;;> split(l)
          ;;> l
          local.get 2
          call $L_split
          local.set 3
          ;;> finished code for scrut
          ;;> LP(l1, l2)
          ;;> get scrut pointer and load it's class id
          local.get 3
          ;;> adtField index: 0
          i32.const 4
          i32.add
          i32.load
          ;;> class id
          i32.const 0
          i32.eq
          ;;> l2
          ;;> get scrut
          local.get 3
          ;;> adtField index: 1
          i32.const 8
          i32.add
          i32.load
          ;;> set idLocal
          local.set 6
          i32.const 1
          i32.and
          ;;> l1
          ;;> get scrut
          local.get 3
          ;;> adtField index: 0
          i32.const 4
          i32.add
          i32.load
          ;;> set idLocal
          local.set 5
          i32.const 1
          i32.and
          if (result i32)
            ;;> merge(mergeSort(l1), mergeSort(l2))
            ;;> mergeSort(l1)
            ;;> l1
            local.get 5
            call $L_mergeSort
            ;;> mergeSort(l2)
            ;;> l2
            local.get 6
            call $L_mergeSort
            call $L_merge
          else
            unreachable
          end
        else
          unreachable
        end
      end
    end
  )

  (func $L_toString (param i32) (result i32) (local i32 i32 i32)
    ;;> fn toString(l: List): String = {
    ;;|   l match {
    ;;|     case Nil() =>
    ;;|       "List()"
    ;;|     case more =>
    ;;|       (("List(" ++ toString1(more)) ++ ")")
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Nil() =>
    ;;|     "List()"
    ;;|   case more =>
    ;;|     (("List(" ++ toString1(more)) ++ ")")
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Nil()
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
      ;;> mkString: List()
      global.get 0
      i32.const 0
      i32.add
      i32.const 76
      i32.store8
      global.get 0
      i32.const 1
      i32.add
      i32.const 105
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
      i32.const 40
      i32.store8
      global.get 0
      i32.const 5
      i32.add
      i32.const 41
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
      ;;> more
      ;;> get scrut
      local.get 1
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> set idLocal
      local.set 2
      i32.const 1
      if (result i32)
        ;;> (("List(" ++ toString1(more)) ++ ")")
        ;;> ("List(" ++ toString1(more))
        ;;> mkString: List(
        global.get 0
        i32.const 0
        i32.add
        i32.const 76
        i32.store8
        global.get 0
        i32.const 1
        i32.add
        i32.const 105
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
        i32.const 40
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
        ;;> toString1(more)
        ;;> more
        local.get 2
        call $L_toString1
        call $String_concat
        ;;> mkString: )
        global.get 0
        i32.const 0
        i32.add
        i32.const 41
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
        call $String_concat
      else
        unreachable
      end
    end
  )

  (func $L_toString1 (param i32) (result i32) (local i32 i32 i32 i32 i32 i32 i32)
    ;;> fn toString1(l: List): String = {
    ;;|   l match {
    ;;|     case Cons(h, Nil()) =>
    ;;|       intToString(h)
    ;;|     case Cons(h, t) =>
    ;;|       ((intToString(h) ++ ", ") ++ toString1(t))
    ;;|   }
    ;;| }
    ;;> l match {
    ;;|   case Cons(h, Nil()) =>
    ;;|     intToString(h)
    ;;|   case Cons(h, t) =>
    ;;|     ((intToString(h) ++ ", ") ++ toString1(t))
    ;;| }
    ;;> cg for scrut
    ;;> l
    local.get 0
    local.set 1
    ;;> finished code for scrut
    ;;> Cons(h, Nil())
    ;;> get scrut pointer and load it's class id
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 1
    i32.eq
    ;;> Nil()
    ;;> get scrut pointer and load it's class id
    local.get 1
    ;;> adtField index: 1
    i32.const 8
    i32.add
    i32.load
    ;;> class id
    i32.const 0
    i32.eq
    i32.and
    ;;> h
    ;;> get scrut
    local.get 1
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> set idLocal
    local.set 6
    i32.const 1
    i32.and
    if (result i32)
      ;;> intToString(h)
      ;;> h
      local.get 6
      call $Std_intToString
    else
      ;;> Cons(h, t)
      ;;> get scrut pointer and load it's class id
      local.get 1
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 1
      i32.eq
      ;;> t
      ;;> get scrut
      local.get 1
      ;;> adtField index: 1
      i32.const 8
      i32.add
      i32.load
      ;;> set idLocal
      local.set 4
      i32.const 1
      i32.and
      ;;> h
      ;;> get scrut
      local.get 1
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> set idLocal
      local.set 3
      i32.const 1
      i32.and
      if (result i32)
        ;;> ((intToString(h) ++ ", ") ++ toString1(t))
        ;;> (intToString(h) ++ ", ")
        ;;> intToString(h)
        ;;> h
        local.get 3
        call $Std_intToString
        ;;> mkString: , 
        global.get 0
        i32.const 0
        i32.add
        i32.const 44
        i32.store8
        global.get 0
        i32.const 1
        i32.add
        i32.const 32
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
        call $String_concat
        ;;> toString1(t)
        ;;> t
        local.get 4
        call $L_toString1
        call $String_concat
      else
        unreachable
      end
    end
  )

  (func $L_take (param i32 i32) (result i32) (local i32 i32 i32 i32 i32 i32 i32 i32)
    ;;> fn take(l: List, n: Int(32)): List = {
    ;;|   (if((n <= 0)) {
    ;;|     Nil()
    ;;|   } else {
    ;;|     l match {
    ;;|       case Nil() =>
    ;;|         Nil()
    ;;|       case Cons(h, t) =>
    ;;|         Cons(h, take(t, (n - 1)))
    ;;|     }
    ;;|   })
    ;;| }
    ;;> (if((n <= 0)) {
    ;;|   Nil()
    ;;| } else {
    ;;|   l match {
    ;;|     case Nil() =>
    ;;|       Nil()
    ;;|     case Cons(h, t) =>
    ;;|       Cons(h, take(t, (n - 1)))
    ;;|   }
    ;;| })
    ;;> (n <= 0)
    ;;> n
    local.get 1
    ;;> 0
    i32.const 0
    i32.le_s
    if (result i32)
      ;;> Nil()
      ;;> store constructor id to the memory boundary
      global.get 0
      local.set 2
      local.get 2
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
    else
      ;;> l match {
      ;;|   case Nil() =>
      ;;|     Nil()
      ;;|   case Cons(h, t) =>
      ;;|     Cons(h, take(t, (n - 1)))
      ;;| }
      ;;> cg for scrut
      ;;> l
      local.get 0
      local.set 3
      ;;> finished code for scrut
      ;;> Nil()
      ;;> get scrut pointer and load it's class id
      local.get 3
      ;;> adtField index: 0
      i32.const 4
      i32.add
      i32.load
      ;;> class id
      i32.const 0
      i32.eq
      if (result i32)
        ;;> Nil()
        ;;> store constructor id to the memory boundary
        global.get 0
        local.set 9
        local.get 9
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
      else
        ;;> Cons(h, t)
        ;;> get scrut pointer and load it's class id
        local.get 3
        ;;> adtField index: 0
        i32.const 4
        i32.add
        i32.load
        ;;> class id
        i32.const 1
        i32.eq
        ;;> t
        ;;> get scrut
        local.get 3
        ;;> adtField index: 1
        i32.const 8
        i32.add
        i32.load
        ;;> set idLocal
        local.set 6
        i32.const 1
        i32.and
        ;;> h
        ;;> get scrut
        local.get 3
        ;;> adtField index: 0
        i32.const 4
        i32.add
        i32.load
        ;;> set idLocal
        local.set 5
        i32.const 1
        i32.and
        if (result i32)
          ;;> Cons(h, take(t, (n - 1)))
          ;;> store constructor id to the memory boundary
          global.get 0
          local.set 7
          local.get 7
          i32.const 1
          i32.store
          ;;> put arguments after the id
          global.get 0
          ;;> adtField index: 1
          i32.const 8
          i32.add
          ;;> take(t, (n - 1))
          ;;> t
          local.get 6
          ;;> (n - 1)
          ;;> n
          local.get 1
          ;;> 1
          i32.const 1
          i32.sub
          call $L_take
          i32.store
          global.get 0
          ;;> adtField index: 0
          i32.const 4
          i32.add
          ;;> h
          local.get 5
          i32.store
          ;;> put the pointer of the class to the stack (memboundary)
          global.get 0
          ;;> update memboundary
          global.get 0
          i32.const 12
          i32.add
          global.set 0
        else
          unreachable
        end
      end
    end
  )

  (func $SideEffect_firstI (result i32) 
    ;;> fn firstI(): Int(32) = {
    ;;|   printInt(1);
    ;;|   1
    ;;| }
    ;;> printInt(1)
    ;;> printInt(1)
    ;;> 1
    i32.const 1
    call $Std_printInt
    drop
    ;;> 1
    ;;> 1
    i32.const 1
  )

  (func $SideEffect_secondI (result i32) 
    ;;> fn secondI(): Int(32) = {
    ;;|   printInt(2);
    ;;|   2
    ;;| }
    ;;> printInt(2)
    ;;> printInt(2)
    ;;> 2
    i32.const 2
    call $Std_printInt
    drop
    ;;> 2
    ;;> 2
    i32.const 2
  )

  (func $SideEffect_stringLeft (result i32) 
    ;;> fn stringLeft(): String = {
    ;;|   printString("SLeft");
    ;;|   "a"
    ;;| }
    ;;> printString("SLeft")
    ;;> printString("SLeft")
    ;;> mkString: SLeft
    global.get 0
    i32.const 0
    i32.add
    i32.const 83
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 76
    i32.store8
    global.get 0
    i32.const 2
    i32.add
    i32.const 101
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 102
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 116
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
    call $Std_printString
    drop
    ;;> "a"
    ;;> mkString: a
    global.get 0
    i32.const 0
    i32.add
    i32.const 97
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
  )

  (func $SideEffect_stringRight (result i32) 
    ;;> fn stringRight(): String = {
    ;;|   printString("SRight");
    ;;|   "a"
    ;;| }
    ;;> printString("SRight")
    ;;> printString("SRight")
    ;;> mkString: SRight
    global.get 0
    i32.const 0
    i32.add
    i32.const 83
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 82
    i32.store8
    global.get 0
    i32.const 2
    i32.add
    i32.const 105
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 103
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 104
    i32.store8
    global.get 0
    i32.const 5
    i32.add
    i32.const 116
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
    call $Std_printString
    drop
    ;;> "a"
    ;;> mkString: a
    global.get 0
    i32.const 0
    i32.add
    i32.const 97
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
  )

  (func $SideEffect_caseLeft (result i32) (local i32)
    ;;> fn caseLeft(): List = {
    ;;|   printString("CLeft");
    ;;|   Nil()
    ;;| }
    ;;> printString("CLeft")
    ;;> printString("CLeft")
    ;;> mkString: CLeft
    global.get 0
    i32.const 0
    i32.add
    i32.const 67
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 76
    i32.store8
    global.get 0
    i32.const 2
    i32.add
    i32.const 101
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 102
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 116
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
    call $Std_printString
    drop
    ;;> Nil()
    ;;> Nil()
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 0
    local.get 0
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
  )

  (func $SideEffect_caseRight (result i32) (local i32)
    ;;> fn caseRight(): List = {
    ;;|   printString("CRight");
    ;;|   Nil()
    ;;| }
    ;;> printString("CRight")
    ;;> printString("CRight")
    ;;> mkString: CRight
    global.get 0
    i32.const 0
    i32.add
    i32.const 67
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 82
    i32.store8
    global.get 0
    i32.const 2
    i32.add
    i32.const 105
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 103
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 104
    i32.store8
    global.get 0
    i32.const 5
    i32.add
    i32.const 116
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
    call $Std_printString
    drop
    ;;> Nil()
    ;;> Nil()
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 0
    local.get 0
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
  )
  (export "SideEffect_main" (func $SideEffect_main))
  (func $SideEffect_main 
    ;;> (firstI() + secondI())
    ;;> (firstI() + secondI())
    ;;> firstI()
    call $SideEffect_firstI
    ;;> secondI()
    call $SideEffect_secondI
    i32.add
    drop
    ;;> (
    ;;|   (firstI() - secondI());
    ;;|   (firstI() * secondI());
    ;;|   (firstI() / secondI());
    ;;|   (firstI() % secondI());
    ;;|   (firstI() < secondI());
    ;;|   (firstI() <= secondI());
    ;;|   (printString("Left") == printString("Right"));
    ;;|   (stringLeft() == stringRight());
    ;;|   (caseLeft() == caseRight());
    ;;|   ()
    ;;| )
    ;;> (firstI() - secondI())
    ;;> (firstI() - secondI())
    ;;> firstI()
    call $SideEffect_firstI
    ;;> secondI()
    call $SideEffect_secondI
    i32.sub
    drop
    ;;> (
    ;;|   (firstI() * secondI());
    ;;|   (firstI() / secondI());
    ;;|   (firstI() % secondI());
    ;;|   (firstI() < secondI());
    ;;|   (firstI() <= secondI());
    ;;|   (printString("Left") == printString("Right"));
    ;;|   (stringLeft() == stringRight());
    ;;|   (caseLeft() == caseRight());
    ;;|   ()
    ;;| )
    ;;> (firstI() * secondI())
    ;;> (firstI() * secondI())
    ;;> firstI()
    call $SideEffect_firstI
    ;;> secondI()
    call $SideEffect_secondI
    i32.mul
    drop
    ;;> (
    ;;|   (firstI() / secondI());
    ;;|   (firstI() % secondI());
    ;;|   (firstI() < secondI());
    ;;|   (firstI() <= secondI());
    ;;|   (printString("Left") == printString("Right"));
    ;;|   (stringLeft() == stringRight());
    ;;|   (caseLeft() == caseRight());
    ;;|   ()
    ;;| )
    ;;> (firstI() / secondI())
    ;;> (firstI() / secondI())
    ;;> firstI()
    call $SideEffect_firstI
    ;;> secondI()
    call $SideEffect_secondI
    i32.div_s
    drop
    ;;> (
    ;;|   (firstI() % secondI());
    ;;|   (firstI() < secondI());
    ;;|   (firstI() <= secondI());
    ;;|   (printString("Left") == printString("Right"));
    ;;|   (stringLeft() == stringRight());
    ;;|   (caseLeft() == caseRight());
    ;;|   ()
    ;;| )
    ;;> (firstI() % secondI())
    ;;> (firstI() % secondI())
    ;;> firstI()
    call $SideEffect_firstI
    ;;> secondI()
    call $SideEffect_secondI
    i32.rem_s
    drop
    ;;> (
    ;;|   (firstI() < secondI());
    ;;|   (firstI() <= secondI());
    ;;|   (printString("Left") == printString("Right"));
    ;;|   (stringLeft() == stringRight());
    ;;|   (caseLeft() == caseRight());
    ;;|   ()
    ;;| )
    ;;> (firstI() < secondI())
    ;;> (firstI() < secondI())
    ;;> firstI()
    call $SideEffect_firstI
    ;;> secondI()
    call $SideEffect_secondI
    i32.lt_s
    drop
    ;;> (
    ;;|   (firstI() <= secondI());
    ;;|   (printString("Left") == printString("Right"));
    ;;|   (stringLeft() == stringRight());
    ;;|   (caseLeft() == caseRight());
    ;;|   ()
    ;;| )
    ;;> (firstI() <= secondI())
    ;;> (firstI() <= secondI())
    ;;> firstI()
    call $SideEffect_firstI
    ;;> secondI()
    call $SideEffect_secondI
    i32.le_s
    drop
    ;;> (
    ;;|   (printString("Left") == printString("Right"));
    ;;|   (stringLeft() == stringRight());
    ;;|   (caseLeft() == caseRight());
    ;;|   ()
    ;;| )
    ;;> (printString("Left") == printString("Right"))
    ;;> (printString("Left") == printString("Right"))
    ;;> printString("Left")
    ;;> mkString: Left
    global.get 0
    i32.const 0
    i32.add
    i32.const 76
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 101
    i32.store8
    global.get 0
    i32.const 2
    i32.add
    i32.const 102
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 116
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
    call $Std_printString
    ;;> printString("Right")
    ;;> mkString: Right
    global.get 0
    i32.const 0
    i32.add
    i32.const 82
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 105
    i32.store8
    global.get 0
    i32.const 2
    i32.add
    i32.const 103
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 104
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 116
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
    call $Std_printString
    i32.eq
    drop
    ;;> (
    ;;|   (stringLeft() == stringRight());
    ;;|   (caseLeft() == caseRight());
    ;;|   ()
    ;;| )
    ;;> (stringLeft() == stringRight())
    ;;> (stringLeft() == stringRight())
    ;;> stringLeft()
    call $SideEffect_stringLeft
    ;;> stringRight()
    call $SideEffect_stringRight
    i32.eq
    drop
    ;;> (
    ;;|   (caseLeft() == caseRight());
    ;;|   ()
    ;;| )
    ;;> (caseLeft() == caseRight())
    ;;> (caseLeft() == caseRight())
    ;;> caseLeft()
    call $SideEffect_caseLeft
    ;;> caseRight()
    call $SideEffect_caseRight
    i32.eq
    drop
    ;;> ()
    ;;> ()
    i32.const 0
    drop
  )
)