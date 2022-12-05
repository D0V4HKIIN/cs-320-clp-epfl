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

  (func $BasicError_throwError (param i32) (result i32) 
    ;;> fn throwError(msg: String): Unit = {
    ;;|   error(msg)
    ;;| }
    ;;> error(msg)
    ;;> msg
    local.get 0
    call $Std_printString
    unreachable
  )
  (export "BasicError_main" (func $BasicError_main))
  (func $BasicError_main 
    ;;> throwError("basic error test")
    ;;> mkString: basic error test
    global.get 0
    i32.const 0
    i32.add
    i32.const 98
    i32.store8
    global.get 0
    i32.const 1
    i32.add
    i32.const 97
    i32.store8
    global.get 0
    i32.const 2
    i32.add
    i32.const 115
    i32.store8
    global.get 0
    i32.const 3
    i32.add
    i32.const 105
    i32.store8
    global.get 0
    i32.const 4
    i32.add
    i32.const 99
    i32.store8
    global.get 0
    i32.const 5
    i32.add
    i32.const 32
    i32.store8
    global.get 0
    i32.const 6
    i32.add
    i32.const 101
    i32.store8
    global.get 0
    i32.const 7
    i32.add
    i32.const 114
    i32.store8
    global.get 0
    i32.const 8
    i32.add
    i32.const 114
    i32.store8
    global.get 0
    i32.const 9
    i32.add
    i32.const 111
    i32.store8
    global.get 0
    i32.const 10
    i32.add
    i32.const 114
    i32.store8
    global.get 0
    i32.const 11
    i32.add
    i32.const 32
    i32.store8
    global.get 0
    i32.const 12
    i32.add
    i32.const 116
    i32.store8
    global.get 0
    i32.const 13
    i32.add
    i32.const 101
    i32.store8
    global.get 0
    i32.const 14
    i32.add
    i32.const 115
    i32.store8
    global.get 0
    i32.const 15
    i32.add
    i32.const 116
    i32.store8
    global.get 0
    i32.const 16
    i32.add
    i32.const 0
    i32.store8
    global.get 0
    i32.const 17
    i32.add
    i32.const 0
    i32.store8
    global.get 0
    i32.const 18
    i32.add
    i32.const 0
    i32.store8
    global.get 0
    i32.const 19
    i32.add
    i32.const 0
    i32.store8
    global.get 0
    global.get 0
    i32.const 20
    i32.add
    global.set 0
    call $BasicError_throwError
    drop
  )
)