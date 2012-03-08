th =
  [| 1 + 1 |]

quote =
  [quasi|
    Arbitrary unknown quasi-quoter.
  |]

string =
  [s| Simple string quote using string-qq package. |] ++
  [q| Similarly, using interpolatedstring-perl6. |]

interpolate name =
  [qc| Hello, {name ++ "!"} |] ++
  [qq| Hello, $name! |] ++
  [istr| Hello, #{name ++ "!"} |]

peano =
  [rex| ^ (?{ length . filter (=='S') } \s* (?:S\s+)* Z) \s* $ |]

relit =
  [re|\\(foo)\\(bar\.c)|]

regexqq =
  [rx|([aeiou]).*(er|ing|tion)([\.,\?]*)$|]

alert name =
  [jmacro|
    alert `((if name == "world" then "hello " else "bye ") ++ name)`
  |]

cat x =
  [sh| cat $x |]

abc =
  [sh| echo a${b}c |] where b = "b"

hssqlppp tablename varname typename =
  [sqlStmt|
    create table $(tablename) (
      $(varname) $(typename)
    );
  |]

login user password =
  [sql| SELECT *
          FROM users
         WHERE name = $s(user)
           AND password = $s(password) |]
