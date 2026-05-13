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
#  define SPIN_QID_T        ushort
#  define MAX_SPIN_QID_T    SHRT_MAX
#  define SPIN_MSGID_T      ushort
#  define MAX_SPIN_MSGID_T  SHRT_MAX
#else
#  define SPIN_PID_T        uchar
#  define MAX_SPIN_PID      UCHAR_MAX
#  define SPIN_QID_T        uchar
#  define MAX_SPIN_QID_T    UCHAR_MAX
#  define SPIN_MSGID_T      uchar
#  define MAX_SPIN_MSGID_T  UCHAR_MAX
#endif /* SPIN16 */

#endif //#define INCLUDED_limits_hpp_cee54847_a9de_42f5_951c_51396fb8e7e0
