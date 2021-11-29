# The Odin Project - Knight Travails

## What does it do?

This script determines the simplest path (i.e., fewest moves) for a knight to take to traverse from point A to point B on a chess board.

## Process

The underlying logic behind this code was initially relatively simple, the goal was to recursively create a tree of ALL valid moves from the starting position without doubling back and then trace the shortest of the discovered routes.  Naturally, this was an exceedingly dumb idea.

It turns out that having Ruby try to create a tree where every node has up to 8 children and a single chain could extend up to 64 nodes is a good way to eat several gigs of memory without a result before inevitably getting bored and halting the execution of the program.  Without radically redesigning the program, I figured that my best options were to either check to make sure that the moves were generally approaching the target or to head off unnecessarily circuitous paths early on.  The logic was a little bit fuzzy to me on the former because a knight's movement will occasionally necessitate moving away from the end goal.  However, staring at a hand drawn grid for a few minutes quickly made it apparent that the latter option would be rather easy to implement.

Initially, I determined that if you were to intentionally hit every diagonal space moving from one corner to another you could make the journey in 28 moves.  This is a highly inefficient way to traverse the board across the longest possible distance, so anything that does worse than that can clearly be cast aside.  Of course, this is *still* too big of a tree to compute in a reasonable amount of time (gigs of memory, 8% cpu usage on good hardware, boredom, etc.) so I stared at my hand drawn board some more before determining that any location could be reached in around 7 moves.

Ending the recursion at 7 levels deep created a tree that was *just* simple enough to generate and find the desired result in only a second or two.  Functional but probably far from optimal.  C'est la vie.
