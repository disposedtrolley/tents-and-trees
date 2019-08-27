# Tents and Trees

A [Tents and Trees](https://www.reddit.com/r/IndieGaming/comments/93njyo/tents_trees_is_a_logic_puzzle_with_friendly/) generator and solver written in Racket.

## Game Overview

![tents and trees](./logic_tents_small.gif)

Tents and Trees is a logic puzzle played on a `board` of `n*n` `cell`s. The game starts with some of the `cell`s populated by `tree`s. Each `column` and `row` are annotated with a non-negative number representing the number of `tent`s which must be placed in that `column` or `row`. A `tent` is placed in a `cell` by `fill`ing the `cell` with `grass`, and then `fill`ing the `grass` with a `tent`. A column or row is `complete` when all of its `cell`s are either `fill`ed with `grass` or `tent`s.

### Constraints

Several constraints makes the game challenging:

1. A `tent` cannot be `adjacent` to any other `tent`. Adjacency in this regard covers **any** direction (horizontal, vertical, and diagonal).
2. Each `tree` must have an `adjacent` `tent`. Adjacency in this regard covers **only** the horizontal and vertical directions.
3. Each `tree` can **only** have a single `adjacent` `tent`.
4. Each `column` and `row` must contain the specified number of `tent`s as annotated.

### Scoring

The score is based on the minimum number of moves (`fill`s) used to satisfy the constraints.

## Representation

* The `board` is a list of lists, containing `n` number of lists which contain `n` number of `cell`s
* Each `cell` is a struct containing the textual representation of the `fill` and a boolean `large?` indicating whether an emoji was used (to cater for pretty-printing)

## Generator

* `Tree`s are the first type of `fill` to be made to `cell`s of the board. Trees can be placed randomly given the following constraints are made:
  1. Each `tree` must have at least one unfilled `cell` horizontally or vertically adjacent to it, allowing gameplay constraints #2 and #3 to be satisfied
  2. In a cluster of `tree`s, no more than one `tree` can have just a single horizontally or vertically unfilled cell
## Setup

### Prerequisites

* Racket 7.3
* `while-loop`
  * `raco pkg install while-loop`
