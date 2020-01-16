###########################################################
# GNUMakefile: A Makefile to generate comment header blocks
#
# by Daniel C. Nygren
# E-mail: dan.nygren@gmail.com
#
# Copyright (c) 2020, Daniel C. Nygren.
#
#    This is the Makefile for use with a programming language independent
# comment header block and additional common and custom m4 files. The Makefile
# runs the m4 macro processor on the header source file with the m4 macro
# files and command line arguments providing the information needed for a
# particular programming language.
#    As some programming languages require a certain magic number at the
# beginning of a file or a certain end of file marker, sed is used to insert
# these extra lines.
#
# CALL SEQUENCE make [options] [target]
#
# EXAMPLES      make            (Makes all targets)
#               make all        (Makes all targets)
#               make debug      (Uses debug.src in place of header.src)
#               make header.ext (Just process target listed)
#               make clean      (Deletes all targets)
#
# TARGET SYSTEM Any
#
# DEVELOPED ON  Solaris, GNU make v3.80, GNU sed v3.02, GNU m4 v1.4
#
# CALLS         m4, sed
#
# CALLED BY     make
#
# INPUTS        header.src (or debug.src), common.m4, and custom m4 files.
#               Optional $COMMON and $CUSTOM environment variables are used to
#               find common and custom m4 files.
#
# OUTPUTS       header.ext, where .ext is the language's extension.
#
# RETURNS       GNU sed returns 0 if OK, 1 if error in Script,
#               and 2 if error during execution.
#
# ERRORS        make gives up on the current rule if there is an error in the
#               rule. m4 stops execution because --fatal-warnings is set.
#
# WARNINGS      1) If adding new entry rules, add name to the "all" target list.
#               2) Environment variable $COMMON defaults to ./common and
#               $CUSTOM defaults ./custom if not defined in your environment.
###########################################################

# Location of GNU sed
SED = /bin/sed

# Location of GNU m4
M4 = /usr/bin/m4

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^^^^^^^^^^ Place code that may need modification above this point. ^^^^^^^^^^
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# If COMMON has not been defined, set it to the below default
ifndef COMMON
COMMON := ./common
endif

# If CUSTOM has not been defined, set it to the below default
ifndef CUSTOM
CUSTOM := ./custom
endif

# Name of the header source file
HEADERFILE = $(COMMON)/header.src
debug: HEADERFILE = $(COMMON)/debug.src

# Names of the files with m4 macros
M4FILES = $(COMMON)/macro.m4 $(CUSTOM)/*.m4

# Options to m4 command, including search path
M4FLAGS = --prefix-builtins --fatal-warnings -I $(COMMON) -I $(CUSTOM)

# Headers to process
all debug : header.c header.htm header.ps header.m4 header.sh header.pl \
header.py header.eps header.sp header.fth header.cpp header.lsp header.vhdl \
header.cad

# The HEADERFILE is run through the macro processor, using the M4FILES, to
# generate the comment header block. Note the $< macro is used to grab the
# first dependency, and $@ grabs the target
#
# The start comment, end comment (optional), comment block filler, and
# comment line length may be defined at the command line.

# No command line arguments defaults to C++ comments and 80 characters per line
header.cpp : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) $< $(HEADERFILE) > $@

# An HTML header
header.htm : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="<!--" \
			-DCOMMENT_END_MACRO="-->" \
			-DCOMMENT_BLOCK_FILLER_MACRO="\`-'" \
			-DCOMMENT_LINE_LENGTH_MACRO="80" \
	$< $(HEADERFILE) > $@

# A PostScript header an example of how to add a single line to the
# beginning of a header. In this case we insert the PostScript magic number.
header.ps : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="%" \
			-DCOMMENT_LINE_LENGTH_MACRO="80" \
	$< $(HEADERFILE) | $(SED) -e "1i\\" -e "%!PS-Adobe-3.0" > $@

# An m4 header showing how to add lines to turn off the built in m4 comments.
# Serves as an example of how to add multiple lines to a header beginning.
header.m4 : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="\`C'" \
			-DCOMMENT_END_MACRO="\`C'" \
			-DCOMMENT_BLOCK_FILLER_MACRO="\`C'" \
			-DCOMMENT_LINE_LENGTH_MACRO="80" \
	$< $(HEADERFILE) | $(SED) \
	-e "1i\\" -e "pushdef(\`C',\`dnl')dnl The letter C indicates comments" \
	-e "1i\\" -e "changecom(,)dnl Disable standard commenting mechanism" \
	-e "\$$a\\" -e "popdef(\`C')dnl Restore any previous definition" > $@

# A Bash shell header showing how to add lines using a separate sed script file.
# The line that is added tells the shell to run a separate shell invocation and
# defines the shell script interpreter that will process the script.
header.sh : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="#" \
			-DCOMMENT_LINE_LENGTH_MACRO="80" \
	$< $(HEADERFILE) | $(SED) -f $(COMMON)/bash.sed > $@

# Here's an example for Perl with the -w "warnings" flag.
header.pl: $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="#" \
			-DCOMMENT_LINE_LENGTH_MACRO="80" \
	$< $(HEADERFILE) | $(SED) -e "1i\\" -e "#!/usr/bin/perl -w" > $@

# Here's an example that uses the Python interpreter on the user's PATH.
header.py: $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="#" \
			-DCOMMENT_LINE_LENGTH_MACRO="80" \
	$< $(HEADERFILE) | $(SED) -e "1i\\" -e "#!/usr/bin/env python" > $@

# An Encapsulated PostScript (EPS) header as an example of how to add lines to
# both the beginning and end of a header. In this case we insert the general
# EPS document structuring conventions, and append an end of file marker.
header.eps : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="%" \
			-DCOMMENT_LINE_LENGTH_MACRO="80" \
	$< $(HEADERFILE) | $(SED) -f $(COMMON)/eps.sed > $@

# A SPICE header
header.sp : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="*" \
	$< $(HEADERFILE) | $(SED) -e \
"1i\\" -e "THE FIRST LINE OF A SPICE INPUT FILE IS CONSIDERED A COMMENT" > $@

# Perhaps we don't need to include the interpreter shebang/hashbang line.
# Here are more examples without one.
# A Forth language header
header.fth : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="\\" \
	$< $(HEADERFILE) > $@

# A Lisp language header
header.lsp : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO=";;" \
	$< $(HEADERFILE) > $@

# A VHDL language header
header.vhdl : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="--" \
	$< $(HEADERFILE) > $@

# An Cadence configuration file header
header.cad : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="{" \
			-DCOMMENT_END_MACRO="}" \
			-DCOMMENT_BLOCK_FILLER_MACRO="\`|'" \
			-DCOMMENT_LINE_LENGTH_MACRO="80" \
	$< $(HEADERFILE) > $@
# A C language header
# The C language header is different than most because the "*" characters of
# the block filler are aligned with the "*" character of the start or end macro.
# The two sed one liners that accomplish this read:
# Lines that start with a "*" replace with a " *".
# Lines that start with a " **" replace with a " *".
header.c : $(M4FILES) $(HEADERFILE)
	$(M4) $(M4FLAGS) -DCOMMENT_START_MACRO="/*" \
			-DCOMMENT_END_MACRO="*/" \
			-DCOMMENT_BLOCK_FILLER_MACRO="*" \
			-DCOMMENT_LINE_LENGTH_MACRO="80" \
	$< $(HEADERFILE) | $(SED) \
	-e "s/^\*/ \*/" \
	-e "s/^ \*\*/ \*/" > $@

# *** Phony Rules ****

# ### Rule to clean up the directory ###
# The "-" at the beginning of the command tells GNU make ignore errors like
# file not present etc.
.PHONY: clean
clean :
	-rm header.*
