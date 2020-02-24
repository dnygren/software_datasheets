m4_pushdef(`C',`m4_dnl')m4_dnl  "C" indicates a comment in this m4 macro file
m4_changecom(,)m4_dnl           Disable the built in commenting mechanism
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C macro.m4 : m4 macros for header files
C
C Created by: Daniel C. Nygren
C Email: nygren@msss.com
C Permanent Email: dan.nygren@gmail.com
C
C Copyright (c) 2001, 2020, Daniel C. Nygren.
C
C   This file, combined with a generic header file containing m4 macros, will
C produce a comment header block for a particular programming language. The
C personal and organization macros are contained in separate files and should be
C changed for your application. The programming language comment macros are
C selected on the command line with the COMMENT_START_MACRO and optionally
C the COMMENT_END_MACRO. The length of a comment block line is the
C COMMENT_LINE_LENGTH_MACRO. I always have liked comment blocks with even length
C delimiters, so I allow you to specify the length of them, including the
C leading or trailing comment start or comment end macro. Note that the afore-
C mentioned macros will be defined to be the same for programming languages
C that do not have end comment sequences. Likewise, the
C COMMENT_BLOCK_FILLER_MACRO is set to be the same as the comment start macro if
C it is left undefined.
C
C   m4 uses the # as a comment delimiter. The problem is, m4 also copies
C comments to the output stream, which I do not consider normal comment
C behavior. Thus, the first two lines in this program make the capital letter C
C a real comment delimiter (by defining it to be replaced with "dnl" which
C discards all characters up to the first newline), and disable the built in
C commenting mechanism with the changecom built in macro. I tried using various
C combinations of capital letters coupled with underscores as comment macros,
C but they gave me a headache when I looked at the file too long. Having been
C exposed to Fortran 77, the capital C used as a comment  doesn't bother me too
C much. The "dnl" built in is also used after defines in order to remove the
C following newline.
C
C   m4 macros are, by my convention, in uppercase and end with "_MACRO" so
C they won't be confused with any other uppercase identifiers. The exceptions
C are the letter C, defined at the top of this file for use in this m4 file only
C (it is undefined at the end of this file so it won't interfere with your
C source code), and the bare underscore "_", which is used as a comment block
C filler. m4 only recognizes C language identifiers as macros, so we can't use
C anything other than  macros that begin with an underscore or alphabetic letter
C and contain underscores, alphabetic letters and C language digits. I won't
C begin a macro with an underscore for the same reason I won't begin a #define
C with an underscore, it is bad programming practice, as using the underscore
C as the first character is reserved for system defines. Macros are quoted with
C a ` and a ' (e.g. `NAME_MACRO') in the definitions so they won't be expanded
C before they have been defined themselves.
C
C
C CALL SEQUENCE m4 --prefix-builtins this_file input_file > output_file
C
C EXAMPLES      m4 macro.m4 header.src > header.cpp
C
C               m4 -DCOMMENT_START_MACRO="/*" \
C               -DCOMMENT_END_MACRO="*/" \
C               -DCOMMENT_BLOCK_FILLER_MACRO="*" \
C               -DCOMMENT_LINE_LENGTH_MACRO="80" \
C               header.src > header.c
C
C TARGET SYSTEM Any
C
C DEVELOPED ON  Windows, Cygwin, GNU m4 version 1.4
C
C CALLS         forloop.m4, rcs.m4, personal.m4, organization.m4
C
C CALLED BY     m4
C
C INPUTS        A file containing m4 header macros
C
C OUTPUTS       A file with m4 header macros replaced with the
C               definitions in this file.
C
C RETURNS       Nothing
C
C ERRORS        Accomplished by m4 options
C
C WARNINGS      1) Don't put blank uncommented lines in this file, as they
C               will be copied to the output.
C               2) All m4 builtins are prefixed with "m4_" so the -P or
C               --prefix-builtins option is required.
C
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
C **** Default Values ****
C The first line checks to see if the comment start macro is defined. If not, it
C is defined as the C++ comment delimiter. The next line says if there is no
C comment end macro, make it the same as the comment start macro. The last two
C lines set the default value for the comment block filler macro to be the C++
C comment, and the comment line length to be eighty characters long. I
C temporarily undefine the capital letter C not to be a comment and restore it
C after these m4 definitions in case it is used as a comment in the source file.
C If we didn't do this, we wouldn't be able to assign other macros its value.
C
m4_pushdef(`C')m4_dnl
m4_ifdef(COMMENT_START_MACRO,,m4_define(COMMENT_START_MACRO,`//'))m4_dnl
m4_ifdef(COMMENT_END_MACRO,,m4_define(COMMENT_END_MACRO,
COMMENT_START_MACRO))m4_dnl
m4_ifdef(COMMENT_BLOCK_FILLER_MACRO,,m4_define(COMMENT_BLOCK_FILLER_MACRO,
COMMENT_START_MACRO))m4_dnl
m4_ifdef(COMMENT_LINE_LENGTH_MACRO,,m4_define(COMMENT_LINE_LENGTH_MACRO,
`80'))m4_dnl
m4_popdef(`C')m4_dnl
C
C **** Programmer Specific Macros ****
m4_include(`personal.m4')m4_dnl
m4_include(`organization.m4')m4_dnl
C ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
C ^^^^^^^^^^ Place code that may need modification above this point. ^^^^^^^^^^
C ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
C
C **** Non-Programming Language Specific Macros ****
C ---- Comment Block Filler Macro ----
m4_pushdef(`C')m4_dnl
m4_define(`_',`COMMENT_BLOCK_FILLER_MACRO')m4_dnl
m4_popdef(`C')m4_dnl
C ---- Revision Control System Macros ----
m4_include(`rcs.m4')m4_dnl
C
C **** Common Macros ****
C ---- m4 "for" loop ----
m4_include(`forloop.m4')m4_dnl
C
C ---- Comment Block Macros ----
C I temporarily undefine the capital letter C not to be a comment and restore it
C after these m4 definitions in case it is used as a comment in the source file.
C If we didn't do this, we wouldn't be able to assign other macros its value.
C
m4_pushdef(`C')m4_dnl
m4_define(`COMMENT_BLOCK_START_LENGTH_MACRO',
m4_eval((COMMENT_LINE_LENGTH_MACRO - m4_len(COMMENT_START_MACRO))
/ m4_len(COMMENT_BLOCK_FILLER_MACRO)))m4_dnl
m4_define(`COMMENT_BLOCK_END_LENGTH_MACRO',
m4_eval((COMMENT_LINE_LENGTH_MACRO - m4_len(COMMENT_END_MACRO))
/ m4_len(COMMENT_BLOCK_FILLER_MACRO)))m4_dnl
m4_define(`COMMENT_BLOCK_START_MACRO',
`COMMENT_START_MACRO()FOR_MACRO(`i',1,COMMENT_BLOCK_START_LENGTH_MACRO,
`COMMENT_BLOCK_FILLER_MACRO')')m4_dnl
m4_popdef(`C')m4_dnl
C
C The ifelse statement's first two arguments are unquoted, so m4 will replace
C them with their actual definitions. If the start and end comments are
C identical, the comment end block will start with the comment end macro. If
C they are different, the comment end block will end with the comment end macro.
C This way programming languages with both single and paired comment delimiters
C can be accommodated.
m4_pushdef(`C')m4_dnl
m4_ifelse(COMMENT_START_MACRO,COMMENT_END_MACRO,
`m4_define(`COMMENT_BLOCK_END_MACRO',
`COMMENT_END_MACRO()FOR_MACRO(`i',1,COMMENT_BLOCK_END_LENGTH_MACRO,
`COMMENT_BLOCK_FILLER_MACRO')')',
`m4_define(`COMMENT_BLOCK_END_MACRO',
`FOR_MACRO(`i',1,COMMENT_BLOCK_END_LENGTH_MACRO,
`COMMENT_BLOCK_FILLER_MACRO')COMMENT_END_MACRO()')')m4_dnl
m4_popdef(`C')m4_dnl
C
C An "open block comment" is a block comment without top and bottom borders.
C
C The ifelse statement's first two arguments are unquoted, so m4 will replace
C them with their actual definitions. If the start and end comments are
C identical, an open block comment will not need a start or an end as the
C comment C block filler macro will serve to comment out the block.
C
C Below, the letter C is undefined as a comment if this file defined it, so you
C can use it later on in your source code. It can be also be used, if necessary,
C in the ifelse statement below.
C
m4_popdef(`C')m4_dnl Undefine C as a comment, restoring any original definition.
m4_ifelse(COMMENT_START_MACRO,COMMENT_END_MACRO,
`m4_define(`COMMENT_OPEN_BLOCK_START_MACRO',`m4_dnl')',
`m4_define(`COMMENT_OPEN_BLOCK_START_MACRO',COMMENT_START_MACRO)')m4_dnl
m4_ifelse(COMMENT_START_MACRO,COMMENT_END_MACRO,
`m4_define(`COMMENT_OPEN_BLOCK_END_MACRO',`m4_dnl')',
`m4_define(`COMMENT_OPEN_BLOCK_END_MACRO',COMMENT_END_MACRO)')m4_dnl
