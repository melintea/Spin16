/*
 * Spin types and limits
 */

#ifndef INCLUDED_limits_hpp_cee54847_a9de_42f5_951c_51396fb8e7e0
#define INCLUDED_limits_hpp_cee54847_a9de_42f5_951c_51396fb8e7e0

#pragma once

#include <limits.h>

/*
 * Process/queue IDs were uchar, are now short types
 */
#ifdef SPIN16
#  define MAX_SPIN_PID      4095 /* <= SHRT_MAX*/
#  if MAX_SPIN_PID > SHRT_MAX
#    error MAX_SPIN_PID <= SHRT_MAX
#  endif
#  define MAX_SPIN_QID      4095 /* <= SHRT_MAX*/
#  if MAX_SPIN_QID > SHRT_MAX
#    error MAX_SPIN_QID <= SHRT_MAX
#  endif
#  define MAX_SPIN_MSGID    SHRT_MAX
#  if MAX_SPIN_QID > 2500
#    define MAXQ        MAX_SPIN_QID
#  else
#    define MAXQ        2500
#  endif
#  define MAXPROC     MAX_SPIN_PID
/* VECTORSZ in disguise, value must be in clear */
#  define XVECTORSZ    1048592  /* > (MAXPROC+MAXQ+4)*sizeof(void*) on 64 bits */
#  if XVECTORSZ < (MAXPROC+MAXQ+4)*8
#    error XVECTORSZ < (MAXPROC+MAXQ+4)*sizeof(void*)
#  endif
#else
#  define MAX_SPIN_PID      UCHAR_MAX
#  define MAX_SPIN_QID      UCHAR_MAX
#  define MAX_SPIN_MSGID    UCHAR_MAX
#  define MAXQ        2500
#  define MAXPROC     MAX_SPIN_PID
#endif /* SPIN16 */

#define STROP(x)  #x
#define TOSTR(x)  STROP(x)

#endif //#define INCLUDED_limits_hpp_cee54847_a9de_42f5_951c_51396fb8e7e0
