hssqlppp =
    [sqlStmt|
      create table $(tablename) (
        $(varname) $(typename)
      );
    |]
 where
   tablename = "my_table"
   varname   = "my_field"
   typename  = "text"

login user password =
    [sql| SELECT *
            FROM users
           WHERE name = $s(user)
             AND password = $s(password) |]
