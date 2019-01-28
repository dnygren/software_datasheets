pushdef(`C',`dnl')dnl The letter C indicates comments
changecom(,)dnl Disable standard commenting mechanism
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C Module Name: Follow here with one phrase describing module.
C
C Created by: Daniel C. Nygren
C Email: nygren@msss.com
C Permanent Email: Dan.Nygren@alumni.clemson.edu
C
C Copyright 2019 by Daniel C. Nygren
C
C   Permission to use and modify this software for any purpose other than
C its incorporation into a commercial product is hereby granted without fee.
C Permission to copy and distribute this software only for non-commercial use
C is also granted without fee, provided that the above copyright notice and
C this entire permission notice appear in all copies and any supporting
C documentation. The author makes no representations about the suitability of
C this software for any purpose. It is provided "as is" without express or
C implied warranty.
C
C   Start here a paragraph explaining what the module does and how it works.
C Include a description of module limitations and algorithms.
C
C CALLING SEQUENCE  (Example with explanation of call parameters)
C
C EXAMPLES          (Examples of calls)
C
C TARGET SYSTEM     (System code targeted for)
C
C DEVELOPED USING   (System code developed on)
C
C CALLS             (List of modules this routine calls)
C
C CALLED BY         (List of modules that call this one)
C
C INPUTS            (Parameters used but not modified, include global and
C                   static data)
C
C OUTPUTS           (Parameters modified, include global and static data)
C
C RETURNS           (Type and meaning of return value, if any)
C
C ERROR HANDLING    (Describe how errors are handled)
C
C WARNINGS          (1. Describe anything a maintainer should be aware of)
C                   (2. Describe anything a maintainer should be aware of)
C                   (N. Describe anything a maintainer should be aware of)
CFOR_MACRO(i,1,80,
COMMENT_BLOCK_FILLER_MACRO)
popdef(`C')dnl Restore any previous definition
