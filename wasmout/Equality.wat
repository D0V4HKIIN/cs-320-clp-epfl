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
  (export "Equality_main" (func $Equality_main))
  (func $Equality_main (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    ;;> printString(booleanToString((0 == 0)))
    ;;> printString(booleanToString((0 == 0)))
    ;;> booleanToString((0 == 0))
    ;;> (0 == 0)
    ;;> 0
    i32.const 0
    ;;> 0
    i32.const 0
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(booleanToString((0 == 1)));
    ;;|   printString(booleanToString((true == true)));
    ;;|   printString(booleanToString((true == false)));
    ;;|   printString(booleanToString((() == ())));
    ;;|   printString(booleanToString(("hello" == "hello")));
    ;;|   printString(booleanToString(("hello" == ("hel" ++ "lo"))));
    ;;|   printString(booleanToString((
    ;;|     val h: String =
    ;;|       "hello";
    ;;|     (h == h)
    ;;|   )));
    ;;|   printString(booleanToString((Foo1() == Foo1())));
    ;;|   printString(booleanToString((Foo1() == Foo2())));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     (f == f)
    ;;|   )));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     val g: Foo =
    ;;|       f;
    ;;|     (f == g)
    ;;|   )))
    ;;| )
    ;;> printString(booleanToString((0 == 1)))
    ;;> printString(booleanToString((0 == 1)))
    ;;> booleanToString((0 == 1))
    ;;> (0 == 1)
    ;;> 0
    i32.const 0
    ;;> 1
    i32.const 1
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(booleanToString((true == true)));
    ;;|   printString(booleanToString((true == false)));
    ;;|   printString(booleanToString((() == ())));
    ;;|   printString(booleanToString(("hello" == "hello")));
    ;;|   printString(booleanToString(("hello" == ("hel" ++ "lo"))));
    ;;|   printString(booleanToString((
    ;;|     val h: String =
    ;;|       "hello";
    ;;|     (h == h)
    ;;|   )));
    ;;|   printString(booleanToString((Foo1() == Foo1())));
    ;;|   printString(booleanToString((Foo1() == Foo2())));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     (f == f)
    ;;|   )));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     val g: Foo =
    ;;|       f;
    ;;|     (f == g)
    ;;|   )))
    ;;| )
    ;;> printString(booleanToString((true == true)))
    ;;> printString(booleanToString((true == true)))
    ;;> booleanToString((true == true))
    ;;> (true == true)
    ;;> true
    i32.const 1
    ;;> true
    i32.const 1
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(booleanToString((true == false)));
    ;;|   printString(booleanToString((() == ())));
    ;;|   printString(booleanToString(("hello" == "hello")));
    ;;|   printString(booleanToString(("hello" == ("hel" ++ "lo"))));
    ;;|   printString(booleanToString((
    ;;|     val h: String =
    ;;|       "hello";
    ;;|     (h == h)
    ;;|   )));
    ;;|   printString(booleanToString((Foo1() == Foo1())));
    ;;|   printString(booleanToString((Foo1() == Foo2())));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     (f == f)
    ;;|   )));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     val g: Foo =
    ;;|       f;
    ;;|     (f == g)
    ;;|   )))
    ;;| )
    ;;> printString(booleanToString((true == false)))
    ;;> printString(booleanToString((true == false)))
    ;;> booleanToString((true == false))
    ;;> (true == false)
    ;;> true
    i32.const 1
    ;;> false
    i32.const 0
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(booleanToString((() == ())));
    ;;|   printString(booleanToString(("hello" == "hello")));
    ;;|   printString(booleanToString(("hello" == ("hel" ++ "lo"))));
    ;;|   printString(booleanToString((
    ;;|     val h: String =
    ;;|       "hello";
    ;;|     (h == h)
    ;;|   )));
    ;;|   printString(booleanToString((Foo1() == Foo1())));
    ;;|   printString(booleanToString((Foo1() == Foo2())));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     (f == f)
    ;;|   )));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     val g: Foo =
    ;;|       f;
    ;;|     (f == g)
    ;;|   )))
    ;;| )
    ;;> printString(booleanToString((() == ())))
    ;;> printString(booleanToString((() == ())))
    ;;> booleanToString((() == ()))
    ;;> (() == ())
    ;;> ()
    i32.const 0
    ;;> ()
    i32.const 0
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(booleanToString(("hello" == "hello")));
    ;;|   printString(booleanToString(("hello" == ("hel" ++ "lo"))));
    ;;|   printString(booleanToString((
    ;;|     val h: String =
    ;;|       "hello";
    ;;|     (h == h)
    ;;|   )));
    ;;|   printString(booleanToString((Foo1() == Foo1())));
    ;;|   printString(booleanToString((Foo1() == Foo2())));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     (f == f)
    ;;|   )));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     val g: Foo =
    ;;|       f;
    ;;|     (f == g)
    ;;|   )))
    ;;| )
    ;;> printString(booleanToString(("hello" == "hello")))
    ;;> printString(booleanToString(("hello" == "hello")))
    ;;> booleanToString(("hello" == "hello"))
    ;;> ("hello" == "hello")
    ;;> mkString: hello
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
    i32.const 108
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 108
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 111
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
    ;;> mkString: hello
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
    i32.const 108
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 108
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 111
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
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(booleanToString(("hello" == ("hel" ++ "lo"))));
    ;;|   printString(booleanToString((
    ;;|     val h: String =
    ;;|       "hello";
    ;;|     (h == h)
    ;;|   )));
    ;;|   printString(booleanToString((Foo1() == Foo1())));
    ;;|   printString(booleanToString((Foo1() == Foo2())));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     (f == f)
    ;;|   )));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     val g: Foo =
    ;;|       f;
    ;;|     (f == g)
    ;;|   )))
    ;;| )
    ;;> printString(booleanToString(("hello" == ("hel" ++ "lo"))))
    ;;> printString(booleanToString(("hello" == ("hel" ++ "lo"))))
    ;;> booleanToString(("hello" == ("hel" ++ "lo")))
    ;;> ("hello" == ("hel" ++ "lo"))
    ;;> mkString: hello
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
    i32.const 108
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 108
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 111
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
    ;;> ("hel" ++ "lo")
    ;;> mkString: hel
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
    i32.const 108
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
    ;;> mkString: lo
    global.get 0
    i32.const 0
    i32.add
    i32.const 108
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 111
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
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(booleanToString((
    ;;|     val h: String =
    ;;|       "hello";
    ;;|     (h == h)
    ;;|   )));
    ;;|   printString(booleanToString((Foo1() == Foo1())));
    ;;|   printString(booleanToString((Foo1() == Foo2())));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     (f == f)
    ;;|   )));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     val g: Foo =
    ;;|       f;
    ;;|     (f == g)
    ;;|   )))
    ;;| )
    ;;> printString(booleanToString((
    ;;|   val h: String =
    ;;|     "hello";
    ;;|   (h == h)
    ;;| )))
    ;;> printString(booleanToString((
    ;;|   val h: String =
    ;;|     "hello";
    ;;|   (h == h)
    ;;| )))
    ;;> booleanToString((
    ;;|   val h: String =
    ;;|     "hello";
    ;;|   (h == h)
    ;;| ))
    ;;> (
    ;;|   val h: String =
    ;;|     "hello";
    ;;|   (h == h)
    ;;| )
    ;;> mkString: hello
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
    i32.const 108
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 108
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 111
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
    local.set 0
    ;;> (h == h)
    ;;> h
    local.get 0
    ;;> h
    local.get 0
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(booleanToString((Foo1() == Foo1())));
    ;;|   printString(booleanToString((Foo1() == Foo2())));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     (f == f)
    ;;|   )));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     val g: Foo =
    ;;|       f;
    ;;|     (f == g)
    ;;|   )))
    ;;| )
    ;;> printString(booleanToString((Foo1() == Foo1())))
    ;;> printString(booleanToString((Foo1() == Foo1())))
    ;;> booleanToString((Foo1() == Foo1()))
    ;;> (Foo1() == Foo1())
    ;;> Foo1()
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
    ;;> Foo1()
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
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(booleanToString((Foo1() == Foo2())));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     (f == f)
    ;;|   )));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     val g: Foo =
    ;;|       f;
    ;;|     (f == g)
    ;;|   )))
    ;;| )
    ;;> printString(booleanToString((Foo1() == Foo2())))
    ;;> printString(booleanToString((Foo1() == Foo2())))
    ;;> booleanToString((Foo1() == Foo2()))
    ;;> (Foo1() == Foo2())
    ;;> Foo1()
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
    ;;> Foo2()
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 4
    local.get 4
    i32.const 1
    i32.store
    ;;> put arguments after the id
    ;;> put the pointer of the class to the stack (memboundary)
    global.get 0
    ;;> update memboundary
    global.get 0
    i32.const 4
    i32.add
    global.set 0
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> (
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     (f == f)
    ;;|   )));
    ;;|   printString(booleanToString((
    ;;|     val f: Foo =
    ;;|       Foo1();
    ;;|     val g: Foo =
    ;;|       f;
    ;;|     (f == g)
    ;;|   )))
    ;;| )
    ;;> printString(booleanToString((
    ;;|   val f: Foo =
    ;;|     Foo1();
    ;;|   (f == f)
    ;;| )))
    ;;> printString(booleanToString((
    ;;|   val f: Foo =
    ;;|     Foo1();
    ;;|   (f == f)
    ;;| )))
    ;;> booleanToString((
    ;;|   val f: Foo =
    ;;|     Foo1();
    ;;|   (f == f)
    ;;| ))
    ;;> (
    ;;|   val f: Foo =
    ;;|     Foo1();
    ;;|   (f == f)
    ;;| )
    ;;> Foo1()
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
    local.set 5
    ;;> (f == f)
    ;;> f
    local.get 5
    ;;> f
    local.get 5
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
    ;;> printString(booleanToString((
    ;;|   val f: Foo =
    ;;|     Foo1();
    ;;|   val g: Foo =
    ;;|     f;
    ;;|   (f == g)
    ;;| )))
    ;;> printString(booleanToString((
    ;;|   val f: Foo =
    ;;|     Foo1();
    ;;|   val g: Foo =
    ;;|     f;
    ;;|   (f == g)
    ;;| )))
    ;;> booleanToString((
    ;;|   val f: Foo =
    ;;|     Foo1();
    ;;|   val g: Foo =
    ;;|     f;
    ;;|   (f == g)
    ;;| ))
    ;;> (
    ;;|   val f: Foo =
    ;;|     Foo1();
    ;;|   val g: Foo =
    ;;|     f;
    ;;|   (f == g)
    ;;| )
    ;;> Foo1()
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 8
    local.get 8
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
    local.set 7
    ;;> (
    ;;|   val g: Foo =
    ;;|     f;
    ;;|   (f == g)
    ;;| )
    ;;> f
    local.get 7
    local.set 9
    ;;> (f == g)
    ;;> f
    local.get 7
    ;;> g
    local.get 9
    i32.eq
    call $Std_booleanToString
    call $Std_printString
    drop
  )
)