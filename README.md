GameControllerDemo
-------------------

By [Joachim Bengtsson](mailto:joachimb@gmail.com), October 1st 2014.

This app implements a rudimentary Powerpoint/Keynote app which can be controlled with a game controller. It is hard-coded to give a presentation on the basics of GameController.framework. One of the slides includes a simple multiplayer platform shooter game.

The app requires a game controller: you can't use it without one.

Presenter notes
================

HELLO! I’m nevyn, and I’m here to talk about something rather boring-sounding: Game controller support! Why? Two reasons:

* For many many games, Game controllers gives the gamer a *far* superior experience. The tactility of real buttons makes it much easier to do precision input, which makes gaming more fun.
* The API is really great. Epitome of Apple APIs — taking something complex and reducing it to just the important parts, and then building very very well.
* It’s so frickin’ easy. C’mon. There are so many games out there and so few support Game Controllers; My mission here is to convert YOU. Just do it. I’ll show you how.

First off, it’s good to know that there are two types of controllers, and only two types: this is not fragmentation hell. It’s also not very innovation heaven. There’s the Standard, and the Extended gamepad. The only difference is that the extended one has two thumbsticks and two extra shoulder buttons. Beyond that, the layout should be familiar: Four action buttons, two shoulder buttons, a D-pad and a pause button. There’s also the distinction of whether the gamepad is stuck to the phone or standalone, but that doesn’t affect the controls.

Let’s start with connecting.

* You can’t assume the controller is available immediately, so we’ll start out with listening for connection and disconnection of controllers.
* Once connected, we should remove any on-screen controllers that are replaced by the controller, since they will only be distracting.
* It’s worth pointing out here that Apple requires you to have a touch interface in addition to game controller — you’re not allowed to write a game that requires a controller.
* Also, note that you can have up to four controllers connected at the same time. It’s VERY easy to support multiple local players.

So, some code. Listen to controller connection and disconnection. Ask GCController for attached controllers. This is a good time to set up the player index, if multiple controllers are connected. This will light up the corresponding number on the controller.

So we’re connected. What now? There are two different APIs, corresponding to the two ways game developers commonly write games:

1. Polling. At the time when you need to know, you ask the controller if the interesting button is pressed. If it is, you do something. Otherwise, nothing.

2. Event based. You set up callbacks for each button, and assign code to each. When the value changes for that button, you react to it.

Let’s look at how to use these APIs.

Some other tiny nicities to think about:

* idleTimerDisabled √
* support pause button √
* value vs pressed √
* saveSnapshot √
* forwarding √
* motion forwarding
* support controllers on menus! √
* screen might be distant to controller X
* AppleTV‽ √


And really, that’s it. There are no more things to talk about. If you don’t get your laptops out during the break and implement game controller support, I am disappoint.

Thankyouuuu.