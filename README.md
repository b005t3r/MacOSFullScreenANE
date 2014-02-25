Mac OS Full screen AIR Native Extension (ANE)
==================

AIR Native Extension enabling native full screen mode (app has its own space created, is accessible through Mission Control, etc.) on Mac OS (Lion or higher).

How to use it?
--------------

Add `MacOSFullScreen.ane` as a dependency and include this in your app's descriptor file:

```xml
<!-- Identifies the ActionScript extensions used by an application. -->
<extensions>
    <extensionID>com.lazarecki.MacOSFullScreen</extensionID>
</extensions>
```

Then, in your app's code, as soon as the app starts call this:

```as3
var macOSFullScreen:MacOSFullScreenANE = new MacOSFullScreenANE(true);
macOSFullScreen.enableFullScreen();
```

That's it. You have native full screen support in your AIR app now.

How to build it (hack it)?
--------------------------

There are two projects included.
