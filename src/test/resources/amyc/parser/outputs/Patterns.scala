object Patterns
  x match {
    case 1 =>
      0
    case () =>
      0
    case "" =>
      0
    case "Hello" =>
      0
    case true =>
      0
    case false =>
      0
    case x =>
      0
    case Variable =>
      0
    case _ =>
      0
    case C() =>
      0
    case C(1) =>
      0
    case C(C(1)) =>
      0
    case C(C(_, "", C(1, "Hello", ()), ()), D(D(_, D(3))), ()) =>
      0
  }
end Patterns
