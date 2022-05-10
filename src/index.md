---
title: Sample jekyll website
description: Index page

metadata:
  read_time: 1 minute
  date: 24/04/2022
---

## What's new

To see changes to the site since our last release,
see [What's new][].

This document explains how to listen for, and respond to, gestures in Flutter. Examples of gestures include taps, drags, and scaling.

The gesture system in Flutter has two separate layers. The first layer has raw pointer events that describe the location and movement of pointers (for example, touches, mice, and styli) across the screen. The second layer has gestures that describe semantic actions that consist of one or more pointer movements.

On pointer down, the framework does a hit test on your app to determine which widget exists at the location where the <code>pointer contacted</code> the screen. The pointer down event (and subsequent events for that pointer) are then dispatched to the innermost widget found by the hit test. From there, the events bubble up the tree and are dispatched to all the widgets on the path from the innermost widget to the root of the tree. There is no mechanism for canceling or stopping pointer events from being dispatched further.

```armasm
        AREA     ARMex, CODE, READONLY
                                ; Name this block of code ARMex
        ENTRY                   ; Mark first instruction to execute
start
        MOV      r0, #10        ; Set up parameters
        MOV      r1, #3
        ADD      r0, r0, r1     ; r0 = r0 + r1
stop
        MOV      r0, #0x18      ; angel_SWIreason_ReportException
        LDR      r1, =0x20026   ; ADP_Stopped_ApplicationExit
        SVC      #0x123456      ; ARM semihosting (formerly SWI)
        END                     ; Mark end of file
```

When there is more than one gesture recognizer for a given pointer on the screen, the framework disambiguates which gesture the user intends by having each recognizer join the gesture arena. The gesture arena determines which gesture wins using the following rules:

* At any time, a recognizer can declare defeat and leave the arena. If there’s only one recognizer left in the arena, that recognizer is the winner.

* At any time, a recognizer can declare victory, which causes it to win and all the remaining recognizers to lose.


For example, when disambiguating horizontal and vertical dragging, both recognizers enter the arena when they receive the pointer down event. The recognizers observe the pointer move events. If the user moves the pointer more than a certain number of logical pixels horizontally, the horizontal recognizer declares victory and the gesture is interpreted as a horizontal drag. Similarly, if the user moves more than a certain number of logical pixels vertically, the vertical recognizer declares victory.

The gesture arena is beneficial when there is only a horizontal (or vertical) drag recognizer. In that case, there is only one recognizer in the arena and the horizontal drag is recognized immediately, which means the first pixel of horizontal movement can be treated as a drag and the user won’t need to wait for further gesture disambiguation.

<code>
  Stmt = Expr<br>
  Expr = if | else
<code>

[What's new]: {{site.url}}/whats-new
