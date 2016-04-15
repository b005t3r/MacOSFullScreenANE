

#include "MacOSFullScreen.h"
#include <stdlib.h>

//typedef char bool;

FREObject MacOSFullScreen_enableFullScreen(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    NSApplicationPresentationOptions presentationOptions = [NSApplication sharedApplication].presentationOptions;
    presentationOptions |= NSApplicationPresentationFullScreen;
    [NSApplication sharedApplication].presentationOptions = presentationOptions;
    
    NSWindow *mainWindow = [NSApplication sharedApplication].mainWindow;
    
    if (mainWindow != nil)
    {
        NSWindowCollectionBehavior behavior = [mainWindow collectionBehavior];
        behavior |= NSWindowCollectionBehaviorFullScreenPrimary;
        [mainWindow setCollectionBehavior:behavior];
    }
    
    //TODO: Return a boolean instead depending on if we found the main window
    return NULL;
}

FREObject MacOSFullScreen_toggleFullScreen(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    NSWindow *mainWindow = [NSApplication sharedApplication].mainWindow;
    
    if (mainWindow != nil)
    {
        [mainWindow toggleFullScreen:nil];
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
    *numFunctions = 2;
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctions));
    *functions = func;
    
    reg(func, 0, "enableFullScreen", MacOSFullScreen_enableFullScreen);
    reg(func, 1, "toggleFullScreen", MacOSFullScreen_toggleFullScreen);
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
