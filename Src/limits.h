/*
 * Spin types and limits
 */

#ifndef INCLUDED_limits_hpp_cee54847_a9de_42f5_951c_51396fb8e7e0
#define INCLUDED_limits_hpp_cee54847_a9de_42f5_951c_51396fb8e7e0

#pragma once

#include <limits.h>

#ifdef SPIN16
#  define SPIN_PID_T        ushort
#  define MAX_SPIN_PID      SHRT_MAX
#  define SPIN_QID_T        int
#  define MAX_SPIN_QID      SHRT_MAX
#  define SPIN_MSGID_T      ushort
#  define MAX_SPIN_MSGID    SHRT_MAX
#else
#  define SPIN_PID_T        uchar
#  define MAX_SPIN_PID      UCHAR_MAX
#  define SPIN_QID_T        short
#  define MAX_SPIN_QID      UCHAR_MAX
#  define SPIN_MSGID_T      uchar
#  define MAX_SPIN_MSGID    UCHAR_MAX
#endif /* SPIN16 */

#define STROP(x)  #x
#define TOSTR(x)  STROP(x)

#endif //#define INCLUDED_limits_hpp_cee54847_a9de_42f5_951c_51396fb8e7e0
