# cgorigin

Set display alignment of monitors on the CLI

## usage

#### --list
shows a list of currently online displays, in the format:

display `index`: `width`x`height` `posX`x`posY`

#### --origin
sets the origin for a display. `posX` & `posY` can be both positive and negative values. `index` defaults to the second monitor.

usage: `posX` `posY` `index`

##### example:

*assuming we have two monitors connected, both at 1920x1080*
```
cgorigin --origin -1920 0  # positions the second monitor to the left of the main display
cgorigin --origin 0 0  # positions the second monitor to the right of the main display
cgorigin --origin -1920 1080 0  # positions the first monitor below the second display
```

## build

```
make
```

*(p.s. you probably need xcode)*
