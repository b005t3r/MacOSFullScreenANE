

#include "MacOSFullScreen.h"
#include <stdlib.h>

//typedef char bool;

FREObject MacOSFullScreen_enableFullScreen(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //We should be okay to do this, even on 10.6, according to this post:
    //http://www.cocoabuilder.com/archive/cocoa/311124-implementing-full-screen-for-10-7-but-app-should-also-run-on-10-6.html
    //We can't use [NSApp mainWindow] - didn't appear to work
    //This seems to though:
    NSArray * allWindows = [NSApp windows];
    if (allWindows.count > 0)
    {
        NSWindow *mainWindow = [allWindows  objectAtIndex: 0];
        NSWindowCollectionBehavior behavior = [mainWindow collectionBehavior];
        behavior |= NSWindowCollectionBehaviorFullScreenPrimary;
        [mainWindow setCollectionBehavior:behavior];
    }
    
    //TODO: Return a boolean instead depending on if we found the main window
    return NULL;
}

void reg(FRENamedFunction *store, int slot, const char *name, FREFunction fn) {
    store[slot].name = (const uint8_t*)name;
    store[slot].functionData = NULL;
    store[slot].function = fn;
}

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
  *numFunctions = 1;
  FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctions));
  *functions = func;
    
  reg(func, 0, "enableFullScreen", MacOSFullScreen_enableFullScreen);
}

void contextFinalizer(FREContext ctx)
{
   return;
}

void MacOSFullScreenInitializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer)
{

  *ctxInitializer = &contextInitializer;
  *ctxFinalizer = &contextFinalizer;
 *extData = NULL;

}

void MacOSFullScreenFinalizer(void* extData)
{
	FREContext nullCTX;
	nullCTX = 0;

	contextFinalizer(nullCTX);
	return;
}
