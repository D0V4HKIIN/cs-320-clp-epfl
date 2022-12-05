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

  (func $Locals_foo (param i32) (result i32) (local i32)
    ;;> fn foo(i: Int(32)): Int(32) = {
    ;;|   val i: Int(32) =
    ;;|     0;
    ;;|   (if((i == 0)) {
    ;;|     error("")
    ;;|   } else {
    ;;|     0
    ;;|   })
    ;;| }
    ;;> (
    ;;|   val i: Int(32) =
    ;;|     0;
    ;;|   (if((i == 0)) {
    ;;|     error("")
    ;;|   } else {
    ;;|     0
    ;;|   })
    ;;| )
    ;;> 0
    i32.const 0
    local.set 1
    ;;> (if((i == 0)) {
    ;;|   error("")
    ;;| } else {
    ;;|   0
    ;;| })
    ;;> (i == 0)
    ;;> i
    local.get 1
    ;;> 0
    i32.const 0
    i32.eq
    if (result i32)
      ;;> error("")
      ;;> mkString: 
      global.get 0
      i32.const 0
      i32.add
      i32.const 0
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
      call $Std_printString
      unreachable
    else
      ;;> 0
      i32.const 0
    end
  )
  (export "Locals_main" (func $Locals_main))
  (func $Locals_main 
    ;;> foo(1)
    ;;> 1
    i32.const 1
    call $Locals_foo
    drop
  )
)