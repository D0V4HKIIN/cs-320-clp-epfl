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
  (export "MatchError_main" (func $MatchError_main))
  (func $MatchError_main (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    ;;> Baz(Baz(Bar(1), Bar(2)), Baz(Bar(3), Bar(4))) match {
    ;;|   case Baz(Baz(_, Bar(_)), _) =>
    ;;|     ()
    ;;| }
    ;;> cg for scrut
    ;;> Baz(Baz(Bar(1), Bar(2)), Baz(Bar(3), Bar(4)))
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
    ;;> Baz(Bar(3), Bar(4))
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
    ;;> Bar(4)
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 5
    local.get 5
    i32.const 0
    i32.store
    ;;> put arguments after the id
    global.get 0
    ;;> adtField index: 0
    i32.const 4
    i32.add
    ;;> 4
    i32.const 4
    i32.store
    ;;> put the pointer of the class to the stack (memboundary)
    global.get 0
    ;;> update memboundary
    global.get 0
    i32.const 8
    i32.add
    global.set 0
    i32.store
    global.get 0
    ;;> adtField index: 0
    i32.const 4
    i32.add
    ;;> Bar(3)
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 4
    local.get 4
    i32.const 0
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
    ;;> Baz(Bar(1), Bar(2))
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
    ;;> Bar(2)
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 2
    local.get 2
    i32.const 0
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
    i32.store
    global.get 0
    ;;> adtField index: 0
    i32.const 4
    i32.add
    ;;> Bar(1)
    ;;> store constructor id to the memory boundary
    global.get 0
    local.set 1
    local.get 1
    i32.const 0
    i32.store
    ;;> put arguments after the id
    global.get 0
    ;;> adtField index: 0
    i32.const 4
    i32.add
    ;;> 1
    i32.const 1
    i32.store
    ;;> put the pointer of the class to the stack (memboundary)
    global.get 0
    ;;> update memboundary
    global.get 0
    i32.const 8
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
    i32.store
    ;;> put the pointer of the class to the stack (memboundary)
    global.get 0
    ;;> update memboundary
    global.get 0
    i32.const 12
    i32.add
    global.set 0
    local.set 0
    ;;> finished code for scrut
    ;;> Baz(Baz(_, Bar(_)), _)
    ;;> get scrut pointer and load it's class id
    local.get 0
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
    ;;> Baz(_, Bar(_))
    ;;> get scrut pointer and load it's class id
    local.get 0
    ;;> adtField index: 0
    i32.const 4
    i32.add
    i32.load
    ;;> class id
    i32.const 1
    i32.eq
    ;;> Bar(_)
    ;;> get scrut pointer and load it's class id
    local.get 0
    ;;> adtField index: 1
    i32.const 8
    i32.add
    i32.load
    ;;> class id
    i32.const 0
    i32.eq
    ;;> _
    i32.const 1
    i32.and
    i32.and
    ;;> _
    i32.const 1
    i32.and
    i32.and
    if (result i32)
      ;;> ()
      i32.const 0
    else
      unreachable
    end
    drop
  )
)