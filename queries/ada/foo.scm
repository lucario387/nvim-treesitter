; block
; call
(call) @call.outer

(arguments) @call.inner

; class
; comment
(comment) @comment.outer

; conditional
(if_statement
  condition: (_)? @conditional.inner) @conditional.outer

; function
(function_definition
  [
    (call)
    (binary_operator)
    (braced_expression)
  ] @function.inner) @function.outer

; loop
[
  (while_statement)
  (repeat_statement)
  (for_statement)
] @loop.outer

(while_statement
  body: (_) @loop.inner)

(repeat_statement
  body: (_) @loop.inner)

(for_statement
  body: (_) @loop.inner)

; statement
(braced_expression
  (_) @statement.outer)

(program
  (_) @statement.outer)

; parameter
((parameters
  (comma) @_start
  .
  (_) @parameter.inner)
  (#make-range! "parameter.outer" @_start @parameter.inner))

((parameters
  .
  (_) @parameter.inner
  .
  (comma)? @_end)
  (#make-range! "parameter.outer" @parameter.inner @_end))

((arguments
  (comma)? @_start
  .
  (_) @parameter.inner)
  (#make-range! "parameter.outer" @_start @parameter.inner))

((arguments
  .
  (_) @parameter.inner
  .
  (comma)? @_end)
  (#make-range! "parameter.outer" @parameter.inner @_end))

; number
(float) @number.inner

; assignment
("<-"
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

("<-"
  name: (_) @assignment.inner)

("->"
  value: (_) @assignment.inner @assignment.lhs
  name: (_) @assignment.rhs) @assignment.outer

("->"
  name: (_) @assignment.inner)

((comma)
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

((comma)
  name: (_) @assignment.inner)

("<<-"
  name: (_) @assignment.lhs
  value: (_) @assignment.inner @assignment.rhs) @assignment.outer

("<<-"
  name: (_) @assignment.inner)

("->>"
  value: (_) @assignment.inner @assignment.lhs
  name: (_) @assignment.rhs) @assignment.outer

(binary_operator)
  name: (_) @assignment.inner