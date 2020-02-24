m4_pushdef(`C',`m4_dnl')m4_dnl  "C" indicates a comment in this m4 macro file
m4_changecom(,)m4_dnl           Disable the built in commenting mechanism
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C forloop.m4: A for loop for use with m4
C
C Created by: Daniel C. Nygren
C Email: nygren@msss.com
C Permanent Email: dan.nygren@gmail.com
C
C Copyright (c) 2020, Daniel C. Nygren.
C
C   m4 does not directly support for loops. The for loop below relies upon
C recursion to accomplish its task. To exit the for loop before it has completed
C its normal course, define the BREAK_MACRO.
C
C CALL SEQUENCE FOR_MACRO(`loop variable',start,end,`procedure')m4_dnl
C               The BREAK_MACRO breaks out of the loop.
C
C EXAMPLES      FOR_MACRO(`i',1,80,`*')m4_dnl
C               The above prints out eighty asterisks
C               FOR_MACRO(`i',1,80,` i')m4_dnl
C               The above prints the loop count (digits 1 to 80)
C               FOR_MACRO(`i',1,80,`m4_ifelse(i,eval(2**5),
C               `BREAK_MACRO',` i')')m4_dnl
C               Break out of the for loop if the loop count equals 32,
C               else print the loop count.
C
C TARGET SYSTEM Any
C
C DEVELOPED ON  Windows, Cygwin, GNU m4 version 1.4
C
C CALLS         None
C
C CALLED BY     m4
C
C INPUTS        A variable name, start count, end count, and a procedure
C               to execute
C
C OUTPUTS       Output of `procedure'
C
C RETURNS       Nothing
C
C ERRORS        Checks to make sure start count <= end count and exits
C               if it does not.
C
C WARNINGS      1) Do not put blank uncommented lines in this file, as they
C               will be copied to the output.
C               2) All m4 builtins are prefixed with "m4_" so the -P or
C               --prefix-builtins option is required.
C
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
C The FOR_MACRO is defined as:
C   If the start count is less than or equal to the end count
C      then undefine MY_BREAK_MACRO,
C      define the loop variable as the loop start value,
C      and the MY_FOR_MACRO.
m4_define(`FOR_MACRO',
`m4_ifelse(m4_eval($2<=$3),`1',
`m4_undefine(`MY_BREAK_MACRO')m4_define(`$1',`$2')MY_FOR_MACRO(`$1',`$2',`$3',
`$4')')')m4_dnl
C
C The MY_FOR_MACRO is defined as:
C   If the loop variable is less than or equal to the end value
C      If MY_BREAK_MACRO is not defined
C         then execute the procedure,
C         increment the loop variable,
C         and execute MY_FOR_MACRO recursively.
m4_define(`MY_FOR_MACRO',
`m4_ifelse(m4_eval($1<=$3),`1',
`m4_ifdef(`MY_BREAK_MACRO',,
`$4`'m4_define(`$1',m4_incr($1))MY_FOR_MACRO(`$1',`$2',`$3',`$4')')')')m4_dnl
C
C The BREAK_MACRO is defined as:
C   The MY_BREAK_MACRO.
m4_define(`BREAK_MACRO',`m4_define(`MY_BREAK_MACRO')')m4_dnl
C
m4_popdef(`C')m4_dnl Undefine "C" as a comment restoring any original definition
