#define EXPORT __attribute__((visibility("default")))

#ifndef MacOSFullScreen_H_
#define MacOSFullScreen_H_
#include "FlashRuntimeExtensions.h" // should be included via the framework, but it's not picking up
EXPORT
void MacOSFullScreenInitializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);

EXPORT
void MacOSFullScreenFinalizer(void* extData);

#endif /* HelloANE_H_ */
