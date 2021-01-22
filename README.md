![Image](https://github.com/RobinKim-SWEngineer/Images-for-document/blob/master/ITWorld%20(1).jpg)

# Customer Order Detail Viewer2.0

## What is this application about ?

This console application is upgrade version of the previous Customer Order Detail Viewer.

It can make interactions with Database such as *deleting*, *updating* and *inserting* customer's orders.

> DB Setup file is included together though it`s recommended to make backend operation on your own for practical purpose.

## How this program is made ?

1. MS SQL : Making the `backend operation` through Stored procedures using `UDTT` and `Merge` statement.
   - UDTT is user defined table type, which can be passed as parameter to stored procedure. Once defined, it is reusable with prefix **@**.
   - Merge statement can include up to 3 operations, that are `Update, Insert and Delete`.
     > In real industry, so called **soft deletion** is suggested since erasing data from DB could cause unintended loss. Soft deletion simply uses Bit info, whether or not the data is currently valid.


2. C# : Making use of `Dapper` and passing `DataTable object` as parameter of Stored procedures ( that takes UDTT )
   - Dapper does relational mapping between DB and C# objects, which reduces the amount of code dramatically. In the previous application we used *SqlCommand* and *SqlDataReader* classes instead of Dapper.
   - When calling Stored procedure through Dapper methods, we need to pass *command type* as *Stored procedure*.
   - Making **DataTable object** is neccesary when Stored procedure takes parameter as UDTT.
     > Key library and classes : Dapper, System.Data => DataTable, DataColumn etc.
