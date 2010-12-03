a = b = d = true
c = false

result = if a
  if b
    if c then false else
      if d
        true

ok result


first = if false then false else second = if false then false else true

ok first
ok second


result = if false
  false
else if NaN
  false
else
  true

ok result


# Testing unless.
result = unless true
  10
else
  11

ok result is 11


# Nested inline if statements.
echo = (x) -> x
result = if true then echo((if false then 'xxx' else 'y') + 'a')
ok result is 'ya'


# Returning if-else.
eq -1, do -> if 1 < 0.5 then 1 else -1


# `else`-less `if` Returns `undefined` with falsy condition.
eq void, do -> if 0 then
eq void, do -> return if 0 then


# As an implicit argument.
eq 100, (-> it) if false then 300 else 100


# If-to-ternary with instanceof requires parentheses (false comment).
if {} instanceof Object
  ok true
else
  ok false

try
  {} + {}
  ok true
catch e
  ok false


# If-to-ternary as part of a larger operation requires parens.
x = 1
result = x + if false then 10 else 1
ok result is 2


# If/else indented within an assignment.
func = ->
  a =
    if false
      3
    else
      5
  101
  a

ok func() is 5


# Unmatched 'then' should catch implicit calls.
i = 1
isTrue = (x) -> x is true

if isTrue true then i += 1

ok i is 2

# If/else with a suppressed indentation via assignment.
result =
  if      false then 10
  else if false    then 20
  else if 0     then 30
  else if NaN   then 40
  else               50 +
       if false then 10
       else          20

ok result is 70

if 'tight formatting with leading `then` is allowed'
then ok    'yay'
else throw 'boo'

# Issue #738
func = if true then -> 1
eq func(), 1


# Issue #748. Trailing reserved identifiers.
obj = delete: true

result = if obj.delete
  101

ok result is 101
