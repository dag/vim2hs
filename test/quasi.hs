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

pelle =
  [ [json| {age: 23, name: "Pelle", likes: ["mac","Haskell"] } |]
  , [jsonQQ| {$age: <<age>>} |]
  , [aesonQQ| {age: <|age + 34 :: Integer|>, name: <|map toUpper name|>} |]
  ]

markup =
  [xml| <div id="#main"><p>Hello</p></div> |]

xmlqq =
  [xmlQQ|
    <{url}:{elem} {attrNs}:{attrName}={attrValue} attr="cool">
      <elem ns1:elem1="1" ns2:elem2="2"><<elemCont>></elem>
      <elem/>
      <el/>
      <<cont1>>
      <<cont2>>
    </{url}:{elem}>
  |]
