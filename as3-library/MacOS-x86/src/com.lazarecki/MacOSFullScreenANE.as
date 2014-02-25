package com.lazarecki {
import flash.external.ExtensionContext;

public class MacOSFullScreenANE {
    private var _context:ExtensionContext;
    private var _verbose:Boolean;

    public function MacOSFullScreenANE(verbose:Boolean = false) {
        _verbose = verbose;

        if(_verbose)
            trace("[MacOSFullScreen] Initalizing ANE...");

        try {
            _context = ExtensionContext.createExtensionContext("com.lazarecki.MacOSFullScreen", null);
        }
        catch(e:Error) {
            if(_verbose) {
                trace(e.toString());
                trace("[HELLO] ANE Not loaded properly. Future calls will fail.");
            }
        }

        if(_verbose)
            trace("[MacOSFullScreen] ANE initialization complete.");
    }

    public function enableFullScreen():void {
        if(_verbose)
            trace("[MacOSFullScreen] Enabling full screen.")

        _context.call("enableFullScreen");
    }
}
}
