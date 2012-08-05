/*
 *  DebugLog.h
 *  DebugLog
 *
 */

#if DEBUG

#define DebugLog(args...) _DebugLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);

//#elif TESTFLIGHT
//
//#define DebugLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define DebugLog(x...)

#endif

void _DebugLog(const char *file, int lineNumber, const char *funcName, NSString *format,...);
