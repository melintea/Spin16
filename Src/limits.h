/*
 * Spin types and limits
 */

#ifndef INCLUDED_limits_hpp_cee54847_a9de_42f5_951c_51396fb8e7e0
#define INCLUDED_limits_hpp_cee54847_a9de_42f5_951c_51396fb8e7e0

#pragma once

#include <limits.h>

#ifdef SPIN16
#  define SPIN_PID_T        ushort
#  define MAX_SPIN_PID      4095 /* <= SHRT_MAX*/
#  if MAX_SPIN_PID > SHRT_MAX
#    error MAX_SPIN_PID <= SHRT_MAX
#  endif
#  define SPIN_QID_T        short
#  define MAX_SPIN_QID      4095 /* <= SHRT_MAX*/
#  if MAX_SPIN_QID > SHRT_MAX
#    error MAX_SPIN_QID <= SHRT_MAX
#  endif
#  define SPIN_MSGID_T      ushort
#  define MAX_SPIN_MSGID    SHRT_MAX
#  define MAXQ        MAX_SPIN_QID
#  define MAXPROC     MAX_SPIN_PID
/* VECTORSZ in disguise, value must be in clear */
#  define XVECTORSZ    1048592  /* > (MAXPROC+MAXQ+4)*sizeof(void*) on 64 bits */
#  if XVECTORSZ < (MAXPROC+MAXQ+4)*8
#    error XVECTORSZ too small
#  endif
#else
#  define SPIN_PID_T        uchar
#  define MAX_SPIN_PID      UCHAR_MAX
#  define SPIN_QID_T        short
#  define MAX_SPIN_QID      UCHAR_MAX
#  define SPIN_MSGID_T      uchar
#  define MAX_SPIN_MSGID    UCHAR_MAX
#  define MAXQ        MAX_SPIN_QID
#  define MAXPROC     MAX_SPIN_PID
#endif /* SPIN16 */

#define SPINBUFSZ 512

#define STROP(x)  #x
#define TOSTR(x)  STROP(x)

#endif //#define INCLUDED_limits_hpp_cee54847_a9de_42f5_951c_51396fb8e7e0
