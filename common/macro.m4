pushdef(`C',`dnl')dnl	The letter C indicates a comment in this m4 macro file
changecom(,)dnl		Disable the built in commenting mechanism
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C macro.m4 $Revision$: m4 macros for header files
C
C by Dan Nygren $Date$
C E-mail: Dan.Nygren@sun.com
C Permanent E-mail: Dan.Nygren@alumni.clemson.edu
C
C Copyright 2001 by Daniel C. Nygren
C
C	This file, combined with a generic header file containing m4 macros, will 
C produce a comment header block for a particular programming language. The 
C personal and company macros are contained in separate files and should be changed
C for your application. The programming language comment macros are selected on the
C command line with COMMENT_START_MACRO and optionally  COMMENT_END_MACRO. The 
C length of a comment block line is the COMMENT_LINE_LENGTH_MACRO. I always have 
C liked comment blocks with even length delimiters, so I allow you to specify the
C length of them, including the leading or trailing comment start or comment end
C macro. Note that the afore mentioned macros will be defined to be the same for
C programming languages that do not have end comment sequences. Likewise, the 
C COMMENT_BLOCK_FILLER_MACRO is set to be the same as the comment start macro if 
C it is left undefined.
C
C 	m4 uses the # as a comment delimiter. The problem is, m4 also copies comments
C to the output stream, which I do not consider normal comment behavior. Thus, the 
C first two lines in this program make the capital letter C a real comment delimiter 
C (by defining it to be replaced with "dnl" which discards all characters up to the 
C first newline), and disable the built in commenting mechanism with the changecom 
C built in macro. I tried using various combinations of capital letters coupled with 
C underscores as comment macros, but they gave me a headache when I looked at the file 
C too long. Having been exposed to Fortran 77, the capital C used as a comment 
C doesn't bother me too much. The "dnl" built in is also used after defines in order 
C to remove the following newline. 
C
C 	m4 macros are, by my convention, in uppercase and end with "_MACRO" so they 
C won't be confused with any other upppercase identifiers. The exceptions are the 
C letter C, defined at the top of this file for use in this m4 file only (it is 
C undefined at the end of this file so it won't interfere with your source code), and
C the bare underscore "_", which is used as a comment block filler. m4 only 
C recognizes C language identifiers as macros, so we can't use anything other than 
C macros that begin with an underscore or alphabetic letter and contain underscores, 
C alphabetic letters and C language digits. I won't begin a macro with an underscore 
C for the same reason I won't begin a #define with an underscore, it is bad programming
C practice, as using the underscore as the first character is reserved for system 
C defines. Macros are quoted with a ` and a ' (e.g. `NAME_MACRO') in the definitions 
C so they won't be expanded before they have been defined themselves. 
C
C
C CALLING SEQUENCE	m4 [options] this_file input_file > output_file
C
C EXAMPLES		m4 macro.m4 header.src > header.cpp
C
C			m4 -DCOMMENT_START_MACRO="/*" \
C			-DCOMMENT_END_MACRO="*/" \
C			-DCOMMENT_BLOCK_FILLER_MACRO="*" \
C			-DCOMMENT_LINE_LENGTH_MACRO="80" \
C			header.src > header.c
C
C
C TARGET SYSTEM		Any
C
C DEVELOPMENT SYSTEM	Windows95, Cygwin, GNU m4 version 1.4
C
C CALLS			forloop.m4, rcs.m4, personal.m4, company.m4
C
C CALLED BY		m4
C
C INPUTS		A file containing m4 header macros
C
C OUTPUTS		A file with m4 header macros replaced with the definitions 
C			in this file 
C
C RETURNS		None
C
C ERROR HANDLING	Accomplished by m4 options
C
C WARNINGS		Don't put blank uncommented lines in this file, as they 
C			will be copied to the output.
C
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C               REVISIONS
C
C $Log$
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
C **** Default Values ****
C The first line checks to see if the comment start macro is defined. If not, it 
C is defined as the C++ comment delimiter. The next line says if there is no comment
C end macro, make it the same as the comment start macro. The last two lines set the
C default value for the comment block filler macro to be the C++ comment, and the 
C comment line length to be eighty characters long. I temporarily undefine the 
C capital letter C not to be a comment and restore it after these m4 definitions in 
C case it is used as a comment in the source file. If we didn't do this, we wouldn't
C be able to assign other macros its value.
C
pushdef(`C')dnl
ifdef(COMMENT_START_MACRO,,define(COMMENT_START_MACRO,`//'))dnl
ifdef(COMMENT_END_MACRO,,define(COMMENT_END_MACRO,COMMENT_START_MACRO))dnl
ifdef(COMMENT_BLOCK_FILLER_MACRO,,define(COMMENT_BLOCK_FILLER_MACRO,COMMENT_START_MACRO))dnl
ifdef(COMMENT_LINE_LENGTH_MACRO,,define(COMMENT_LINE_LENGTH_MACRO,`80'))dnl
popdef(`C')dnl
C
C **** Programmer Specific Macros ****
include(`personal.m4')dnl
include(`company.m4')dnl
C
C **** Non-Programming Language Specific Macros ****
C ---- Comment Block Filler Macro ----
define(`_',`COMMENT_BLOCK_FILLER_MACRO')dnl
C ---- Revision Control System Macros ----
include(`rcs.m4')dnl
C
C **** Common Macros ****
C ---- m4 "for" loop ----
include(`forloop.m4')dnl
C
C ---- Comment Block Macros ----
C I temporarily undefine the capital letter C not to be a comment and restore it 
C after these m4 definitions in case it is used as a comment in the source file.
C If we didn't do this, we wouldn't be able to assign other macros its value.
C
pushdef(`C')dnl
define(`COMMENT_BLOCK_START_LENGTH_MACRO', eval((COMMENT_LINE_LENGTH_MACRO - len(COMMENT_START_MACRO)) / len(COMMENT_BLOCK_FILLER_MACRO)))dnl
define(`COMMENT_BLOCK_END_LENGTH_MACRO', eval((COMMENT_LINE_LENGTH_MACRO - len(COMMENT_END_MACRO)) / len(COMMENT_BLOCK_FILLER_MACRO)))dnl
define(`COMMENT_BLOCK_START_MACRO',`COMMENT_START_MACRO()FOR_MACRO(`i',1,COMMENT_BLOCK_START_LENGTH_MACRO,`COMMENT_BLOCK_FILLER_MACRO')')dnl
popdef(`C')dnl
C
C The ifelse statement's first two arguments are unquoted, so m4 will replace them
C with their actual definitions. If the start and end comments are identical, the 
C comment end block will start with the comment end macro. If they are different, 
C the comment end block will end with the comment end macro. This way programming 
C languages with both single and paired comment delimiters can be accommodated.
C
C Below, the letter C is undefined as a comment if this file defined it, so you 
C can use it later on in your source code, and also so it can be used, if necessary, 
C in the ifelse statement below.
C
popdef(`C')dnl Undefine C as a comment macro by restoring its original definition (if any)
ifelse(COMMENT_START_MACRO,COMMENT_END_MACRO,`define(`COMMENT_BLOCK_END_MACRO',`COMMENT_END_MACRO()FOR_MACRO(`i',1,COMMENT_BLOCK_END_LENGTH_MACRO,`COMMENT_BLOCK_FILLER_MACRO')')',`define(`COMMENT_BLOCK_END_MACRO',`FOR_MACRO(`i',1,COMMENT_BLOCK_END_LENGTH_MACRO,`COMMENT_BLOCK_FILLER_MACRO')COMMENT_END_MACRO()')')dnl
