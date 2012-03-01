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
