pushdef(`C',`dnl')dnl   The letter C indicates a comment in this m4 macro file
changecom(,)dnl         Disable the built in commenting mechanism
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C forloop.m4: A for loop for use with m4
C
C by Dan Nygren $Date: 2001/07/20 03:10:25 $
C E-mail: Dan.Nygren@sun.com
C Permanent E-mail: Dan.Nygren@alumni.clemson.edu
C
C Copyright 2001 by Daniel C. Nygren
C
C   m4 does not directly support for loops. The for loop below relies upon
C recursion to accomplish its task. To exit the for loop before it has completed
C its normal course, define the BREAK_MACRO.
C
C CALLING SEQUENCE  FOR_MACRO(`loop variable',start,end,`procedure')
C                   BREAK_MACRO breaks out of loop
C
C EXAMPLES          FOR_MACRO(`i',1,80,`*')dnl
C                   The above prints out eighty asterisks
C                   FOR_MACRO(`i',1,80,` i')dnl
C                   The above prints the loop count (digits 1 to 80)
C                   FOR_MACRO(`i',1,80,`ifelse(i,eval(2**5),
C                   `BREAK_MACRO',` i')')dnl
C                   Break out of the for loop if the loop count equals 32,
C                   else print the loop count
C
C TARGET SYSTEM     Any
C
C DEVELOPED USING   Windows95, Cygwin, GNU m4 version 1.4
C
C CALLS             None
C
C CALLED BY         m4
C
C INPUTS            A variable name, start count, end count, and a procedure
C                   to execute
C
C OUTPUTS           Output of `procedure'
C
C RETURNS           Nothing
C
C ERROR HANDLING    Checks to make sure start count <= end count and exits
C                   if it does not.
C
C WARNINGS          Do not put blank uncommented lines in this file, as they
C                   will be copied to the output.
C
C
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
C The FOR_MACRO is defined as:
C   If the start count is less than or equal to the end count
C      then undefine MY_BREAK_MACRO,
C      define the loop variable as the loop start value,
C      and the MY_FOR_MACRO.
define(`FOR_MACRO',
`ifelse(eval($2<=$3),`1',
`undefine(`MY_BREAK_MACRO')define(`$1',`$2')MY_FOR_MACRO(`$1',`$2',`$3',
`$4')')')dnl
C
C The MY_FOR_MACRO is defined as:
C   If the loop variable is less than or equal to the end value
C      If MY_BREAK_MACRO is not defined
C         then execute the procedure,
C         increment the loop variable,
C         and execute MY_FOR_MACRO recursively.
define(`MY_FOR_MACRO',
`ifelse(eval($1<=$3),`1',
`ifdef(`MY_BREAK_MACRO',,
`$4`'define(`$1',incr($1))MY_FOR_MACRO(`$1',`$2',`$3',`$4')')')')dnl
C
C The BREAK_MACRO is defined as:
C   The MY_BREAK_MACRO.
define(`BREAK_MACRO',`define(`MY_BREAK_MACRO')')dnl
C
popdef(`C')dnl Undefine C as a comment restoring any original definition
