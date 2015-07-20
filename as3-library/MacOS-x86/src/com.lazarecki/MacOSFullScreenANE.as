package com.lazarecki {
import flash.desktop.NativeApplication;
import flash.display.NativeWindow;
import flash.display.NativeWindowDisplayState;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.NativeWindowDisplayStateEvent;
import flash.external.ExtensionContext;

public class MacOSFullScreenANE {
    private var _context:ExtensionContext;
    private var _verbose:Boolean;

    private var _alt:Boolean;
    private var _fullScreen:Boolean;

    public function MacOSFullScreenANE(verbose:Boolean = false) {
        _verbose = verbose;

        if(_verbose)
            trace("[MacOSFullScreen] Initalizing ANE...");

        try {
            _context = ExtensionContext.createExtensionContext("com.lazarecki.MacOSFullScreen", null);
        }
        catch(e:Error) {
            if(_verbose) {
                trace("[MacOSFullScreen] ANE not loaded properly. Future calls will fail.");
                trace(e.toString());
            }
        }

        if(_verbose)
            trace("[MacOSFullScreen] ANE initialization complete.");
    }

    public function get fullScreen():Boolean { return _fullScreen; }

    public function enableFullScreen(nativeWindow:NativeWindow, yosemiteCompatibility:Boolean = false):void {
        if(_verbose)
            trace("[MacOSFullScreen] Enabling full screen...");

        if(! nativeWindow.active) {
            if(_verbose)
                trace("[MacOSFullScreen] Waiting for the window to get activated...");

            nativeWindow.addEventListener(Event.ACTIVATE, onNativeWindowActivated);
        }
        else {
            if(_verbose)
                trace("[MacOSFullScreen] Full screen enabled.");

            _context.call("enableFullScreen");
        }

        if(yosemiteCompatibility) {
            if(_verbose)
                trace("[MacOSFullScreen] Enabling Yosemite compatibility.");

            var nativeApplication:NativeApplication = NativeApplication.nativeApplication;

            nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKey, true);
            nativeApplication.addEventListener(KeyboardEvent.KEY_UP, onKey, true);
            nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, onDisplayStateChanging);
        }
    }

    public function toggleFullScreen():void {
        if(_verbose)
            trace("[MacOSFullScreen] Toggling full screen.");

        _fullScreen = ! _fullScreen;

        _context.call("toggleFullScreen");
    }

    private function onNativeWindowActivated(event:Event):void {
        NativeWindow(event.target).removeEventListener(Event.ACTIVATE, onNativeWindowActivated);

        if(_verbose)
            trace("[MacOSFullScreen] Window activated, full screen enabled.");

        _context.call("enableFullScreen");
    }

    private function onKey(event:KeyboardEvent):void {
        _alt = event.altKey;
    }

    private function onDisplayStateChanging(event:NativeWindowDisplayStateEvent):void {
        if(event.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
            return;

        if(_alt && ! _fullScreen)
            return;

        if(_verbose)
            trace("[MacOSFullScreen] Yosemite compatibility: About to toggle full screen...");

        toggleFullScreen();
    }
}
}
