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

Then, in your app's ```Event.ADDED_TO_STAGE``` handler call this:

```as3
var macOSFullScreen:MacOSFullScreenANE = new MacOSFullScreenANE(true);
macOSFullScreen.enableFullScreen(stage.nativeWindow);
```

If you're going to target Mac OS X Yosemite, you need to pass an optional parameter, which enables a workaround (credits to Jamie from Simplest Ways) for this version (and probably next ones):

```as3
var macOSFullScreen:MacOSFullScreenANE = new MacOSFullScreenANE(true);
macOSFullScreen.enableFullScreen(stage.nativeWindow, true);
```

Now you can click the green maximize/minimize button to enter/leave the full screen mode or alt-click to maximize/minimize the window instead. 

You can also call:

```as3
macOSFullScreen.toggleFullScreen();
```

to manually enter or leave the full screen mode.

How to build it (hack it)?
--------------------------

There are two projects included. One is an AS3 wrapper and the other is an actual Obj-C native extension. You can edit and build the former as any other AS3 project. For the later you'll need XCode5. When you build the Obj-C part of this extension, `build.command' script is called, so make sure you first set the right path to it in the project settings. Other thing is to always create a release build, this can be done using Build -> Build for -> Profiling.

Special thanks
--------------

Special thanks to @kukulski (https://github.com/kukulski) for providing an example projects for all of this!

Special thanks to Jamie from Simplest Ways (http://www.simplestways.com) for the Yosemite bug workaround!

Special thanks to @kernelex (https://github.com/kernelex) for the 64-bit version of this ANE!
