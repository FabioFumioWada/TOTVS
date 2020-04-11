SQL - Decrypt
if exists (select * from sysobjects where id = object_id('dbo.spDecryptSP') and sysstat & 0xf = 4)
    drop procedure dbo.spDecryptSP
GO

Create procedure dbo.spDecryptSP
    @spName varchar(50),
    @Replace bit = 0
As
/*
Developer:    Jonathan Spinks
Date: 24/07/03
Description: Decrypts SQL 2000 stored procedures

Inputs:
    @spName = the name of the stored procedure you wish to decrypt
    @Replace = 0 or 1. 0 if you wish to display the unencrypted sp
        1 if you wish to replace the encrypted with the unencrypted sp

If this procedure returns "<@spName> is to large to decrypt"
this stored procedure can be modified to decrypt it.
Your starting point is to check out how many rows are returned
in the syscomments table for the stored procedures object_id.

If you just wish to display the sp then ensure that your result
pane is turned to 'Results in Text'.
In Query analyser (2k) Query => 'Results in Text'.

If your returned information looks 'cut short' first check
that your i_SQL query window is returning the entire string.
In Query analyser (2k) Tools => Options, Results tab,
Maximum characters per column = 8000.

Happy decrypting

Original idea: shoeboy <shoeboy@adequacy.org>
Adapted by: Joseph Gama Copyright © 1999-2002 SecurityFocus
Adapted Source: http://www.Planet-Source-Code.com/vb/scripts/ShowCode.asp?txtCodeId=505&lngWId=5
Enhanced by: Jonathan Spinks Copyright © 2003 I.S. Software Developments. WASH
*/
DECLARE
    @a1 nvarchar(4000), @b1 nvarchar(4000), @c1 nvarchar(4000), @d1 nvarchar(4000),
    @a2 nvarchar(4000), @b2 nvarchar(4000), @c2 nvarchar(4000), @d2 nvarchar(4000),
    @a3 nvarchar(4000), @b3 nvarchar(4000), @c3 nvarchar(4000), @d3 nvarchar(4000),
    @a4 nvarchar(4000), @b4 nvarchar(4000), @c4 nvarchar(4000), @d4 nvarchar(4000),
    @a5 nvarchar(4000), @b5 nvarchar(4000), @c5 nvarchar(4000), @d5 nvarchar(4000),
    @a6 nvarchar(4000), @b6 nvarchar(4000), @c6 nvarchar(4000), @d6 nvarchar(4000),
    @a7 nvarchar(4000), @b7 nvarchar(4000), @c7 nvarchar(4000), @d7 nvarchar(4000),
    @a8 nvarchar(4000), @b8 nvarchar(4000), @c8 nvarchar(4000), @d8 nvarchar(4000),
    @a9 nvarchar(4000), @b9 nvarchar(4000), @c9 nvarchar(4000), @d9 nvarchar(4000),
    @a0 nvarchar(4000), @b0 nvarchar(4000), @c0 nvarchar(4000), @d0 nvarchar(4000),
    @Perm nvarchar(4000),
    @i int

if not exists(SELECT * FROM syscomments WHERE id = object_id(@spName))
Begin
    print @spName +' cannot be found'
    return
End

if exists(SELECT * FROM syscomments WHERE id = object_id(@spName) and encrypted = 0)
Begin
    print @spName +' is not encrypted'
    return
End

if (SELECT count(*) FROM syscomments WHERE id = object_id(@spName)) > 10
Begin
    print @spName +' is to large to decrypt'
    return
End

--    Get a list of the current permissions on the encrypted stored procedure
declare curPerm cursor fast_forward for
    select '['+ u.name +']' as name, p.actadd, p.actmod
    from    dbo.syspermissions p inner join dbo.sysusers u
        On p.grantee = u.uid
    where p.id = object_id(@spName)
open curPerm

Set @Perm = ''
while 1 = 1
begin
    declare @name sysname,
            @actadd smallint,
            @actmod smallint
    fetch next from curPerm into @name, @actadd, @actmod
    if @@fetch_status <> 0
        break
    --    For each permission in the list construct a GRANT or DENY command
    if @actadd & 32 = 32
        Set @Perm = @Perm +'GRANT EXECUTE ON '+ @spName +' TO '+ @name +char(13)+char(10)+'Go'+char(13)+char(10)
    else if @actmod & 32 = 32
        Set @Perm = @Perm +'DENY EXECUTE ON '+ @spName +' TO '+ @name +char(13)+char(10)+'Go'+char(13)+char(10)
end
close curPerm
deallocate curPerm

--    Get encrypted stored procedure
SELECT @a1=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 1
SELECT @a2=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 2
SELECT @a3=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 3
SELECT @a4=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 4
SELECT @a5=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 5
SELECT @a6=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 6
SELECT @a7=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 7
SELECT @a8=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 8
SELECT @a9=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 9
SELECT @a0=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 10

--    Create blank stored procedure
SET @b1='ALTER PROCEDURE '+ @spName +' WITH ENCRYPTION AS '+ REPLICATE('-', Len(@a1))
SET @b2=REPLICATE(N'-', len(@a2))
SET @b3=REPLICATE(N'-', len(@a3))
SET @b4=REPLICATE(N'-', len(@a4))
SET @b5=REPLICATE(N'-', len(@a5))
SET @b6=REPLICATE(N'-', len(@a6))
SET @b7=REPLICATE(N'-', len(@a7))
SET @b8=REPLICATE(N'-', len(@a8))
SET @b9=REPLICATE(N'-', len(@a9))
SET @b0=REPLICATE(N'-', len(@a0))

--    Wrap in transaction so original stored procedure can be restored
Begin transaction ReplaceSP

    Execute (@b1 + @b2 + @b3 + @b4 + @b5 + @b6 + @b7 + @b8 + @b9 + @b0)

    --    Get blank encrypted stored procedure
    SELECT @c1=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 1
    SELECT @c2=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 2
    SELECT @c3=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 3
    SELECT @c4=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 4
    SELECT @c5=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 5
    SELECT @c6=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 6
    SELECT @c7=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 7
    SELECT @c8=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 8
    SELECT @c9=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 9
    SELECT @c0=ctext FROM syscomments WHERE id = object_id(@spName) and colid = 10

If @Replace = 0
    Rollback Transaction ReplaceSP
Else
    Commit Transaction ReplaceSP

SET @b1='CREATE PROCEDURE '+ @spName +' WITH ENCRYPTION AS '+ REPLICATE('-', Len(@a1))

--    initalise the output variables
Set @d1 = ''
Set @d2 = ''
Set @d3 = ''
Set @d4 = ''
Set @d5 = ''
Set @d6 = ''
Set @d7 = ''
Set @d8 = ''
Set @d9 = ''
Set @d0 = ''

--    Set the counter to one
Set @i = 1
WHILE @i < datalength(@a1)/2 + 1
BEGIN
    --    (unencrypted original) = (encrypted original) XOR (unencrypted blank) XOR (encrypted blank)
    SET @d1 = @d1 + NCHAR(UNICODE(substring(@a1, @i, 1)) ^ (UNICODE(substring(@b1, @i, 1)) ^ UNICODE(substring(@c1, @i, 1))))
    SET @i=@i+1
END

--    Set the counter to one
Set @i = 1
WHILE @i < datalength(@a2)/2 + 1
BEGIN
    --    (unencrypted original) = (encrypted original) XOR (unencrypted blank) XOR (encrypted blank)
    SET @d2 = @d2 + NCHAR(UNICODE(substring(@a2, @i, 1)) ^ (UNICODE(substring(@b2, @i, 1)) ^ UNICODE(substring(@c2, @i, 1))))
    SET @i=@i+1
END

--    Set the counter to one
Set @i = 1
WHILE @i < datalength(@a3)/2 + 1
BEGIN
    --    (unencrypted original) = (encrypted original) XOR (unencrypted blank) XOR (encrypted blank)
    SET @d3 = @d3 + NCHAR(UNICODE(substring(@a3, @i, 1)) ^ (UNICODE(substring(@b3, @i, 1)) ^ UNICODE(substring(@c3, @i, 1))))
    SET @i=@i+1
END

--    Set the counter to one
Set @i = 1
WHILE @i < datalength(@a4)/2 + 1
BEGIN
    --    (unencrypted original) = (encrypted original) XOR (unencrypted blank) XOR (encrypted blank)
    SET @d4 = @d4 + NCHAR(UNICODE(substring(@a4, @i, 1)) ^ (UNICODE(substring(@b4, @i, 1)) ^ UNICODE(substring(@c4, @i, 1))))
    SET @i=@i+1
END

--    Set the counter to one
Set @i = 1
WHILE @i < datalength(@a5)/2 + 1
BEGIN
    --    (unencrypted original) = (encrypted original) XOR (unencrypted blank) XOR (encrypted blank)
    SET @d5 = @d5 + NCHAR(UNICODE(substring(@a5, @i, 1)) ^ (UNICODE(substring(@b5, @i, 1)) ^ UNICODE(substring(@c5, @i, 1))))
    SET @i=@i+1
END

--    Set the counter to one
Set @i = 1
WHILE @i < datalength(@a6)/2 + 1
BEGIN
    --    (unencrypted original) = (encrypted original) XOR (unencrypted blank) XOR (encrypted blank)
    SET @d6 = @d6 + NCHAR(UNICODE(substring(@a6, @i, 1)) ^ (UNICODE(substring(@b6, @i, 1)) ^ UNICODE(substring(@c6, @i, 1))))
    SET @i=@i+1
END

--    Set the counter to one
Set @i = 1
WHILE @i < datalength(@a7)/2 + 1
BEGIN
    --    (unencrypted original) = (encrypted original) XOR (unencrypted blank) XOR (encrypted blank)
    SET @d7 = @d7 + NCHAR(UNICODE(substring(@a7, @i, 1)) ^ (UNICODE(substring(@b7, @i, 1)) ^ UNICODE(substring(@c7, @i, 1))))
    SET @i=@i+1
END

--    Set the counter to one
Set @i = 1
WHILE @i < datalength(@a8)/2 + 1
BEGIN
    --    (unencrypted original) = (encrypted original) XOR (unencrypted blank) XOR (encrypted blank)
    SET @d8 = @d8 + NCHAR(UNICODE(substring(@a8, @i, 1)) ^ (UNICODE(substring(@b8, @i, 1)) ^ UNICODE(substring(@c8, @i, 1))))
    SET @i=@i+1
END

--    Set the counter to one
Set @i = 1
WHILE @i < datalength(@a9)/2 + 1
BEGIN
    --    (unencrypted original) = (encrypted original) XOR (unencrypted blank) XOR (encrypted blank)
    SET @d9 = @d9 + NCHAR(UNICODE(substring(@a9, @i, 1)) ^ (UNICODE(substring(@b9, @i, 1)) ^ UNICODE(substring(@c9, @i, 1))))
    SET @i=@i+1
END

--    Set the counter to one
Set @i = 1
WHILE @i < datalength(@a0)/2 + 1
BEGIN
    --    (unencrypted original) = (encrypted original) XOR (unencrypted blank) XOR (encrypted blank)
    SET @d0 = @d0 + NCHAR(UNICODE(substring(@a0, @i, 1)) ^ (UNICODE(substring(@b0, @i, 1)) ^ UNICODE(substring(@c0, @i, 1))))
    SET @i=@i+1
END


if @Replace = 0
Begin
    --    Output the unencrypted stored procedure to the screen
    select @d1 as 'Unencrypted Stored Procedure'
    select @d2
    select @d3
    select @d4
    select @d5
    select @d6
    select @d7
    select @d8
    select @d9
    select @d0
    --    Output any permissions that were on the encrypted stored procedure
    Select @Perm as 'Permissions'
End
Else
Begin
    --    Drop the encrypted stored procedure
    Exec('Drop Procedure '+ @spName)
    --    Remove the 'WITH ENCRYPTION' command from the stored procedure
    Set @d1 = Replace(@d1, 'WITH ENCRYPTION', '')
    --    Create the unencrypted stored procedure
    Exec(@d1 + @d2 + @d3 + @d4 + @d5 + @d6 + @d7 + @d8 + @d9 + @d0)
    --    Apply any permissions that were on the encrypted stored procedure
    Exec(@Perm)
End

Go

