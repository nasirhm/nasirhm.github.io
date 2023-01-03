---
title: "Coding Conway's Game of Life - Cellular Automata - The Maths"
date: 2023-01-01T19:25:32+05:00
tags: ["math", "cellular-automata", "computational-theory"]
categories: ["maths"]
---

![Conway's Game of Life](/images/posts-static/exploring-google-cloud/pub_sub-512-color.png)

In the past few days, I've been exploring mathematics and it's various applications in Computational Theory and User Experience.

In this part one, I'll be looking at Conway's Game of Life from the mathematical perspective and it's application on user experience.

Without any further ado, Let's take a dive into it.

## What is Cellular Automata?

Cellular Automata is a field of Automata Theory which is a part of Discrete Maths. Automata Theory has applications in Physics, Computational Theory, Biology, etc. Automata Theory consists of the study of various Computational Classes: Combinatorial Logic, Finite-State Machines, Pushdown Automation and Turing Machines.

Cellular Automata deals with Artificial life, which examines systems related to natural life, it's processes, it's evolution, through the usage of simulations with computer models.

### Cellular Automata - How ??

Cellular Automata consists of a grid of cells, with discrete (finite states) e.g: On and Off. For each cell a set, a set of cells are called it's neighborhood. It also consists of a set of discrete rules which are applied on each iteration. An initial state (t=0) is selected by defining the state of various cells. Upon each iteration (t+1), The set of rules are applied upon the whole grid and then the change is the state of the neighboring cells is then observed.

[Image for Grid of Cells, and state.]

## Conway's Game of Life

Conway's Game of Life is invented by the famous Mathematician, "John Conway". It is also often referred as "Life". It is a zero-player game, meaning for it's evolution to be defined by the initial state. It's played on an infinite two-dimentional grid (However, For the sake of computing it, we'll be using an nxn size for the grid).

Each cell has eight neighboring cells which are horizontally, vertically, or diagonally adjacent.

It consists of the following rules:

- Any live cell with fewer than two live neighbours dies, as if by underpopulation.
- Any live cell with two or three live neighbours lives on to the next generation.
- Any live cell with more than three live neighbours dies, as if by overpopulation.
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

Let's look at the rules in action. (GIF for Rules).

Simple, Right ?

It consists of a grid of squares, simple rules and simple states for each cell.

### Well, You're in for a treat. Patterns:

There are various patterns (alot !!) that are discovered. However, we'll be looking at some promiment ones below:

- **Still Life**: It's the most obvious pattern we can think of, It's a state of cells, which are stabilized. Where neither cell is producing nor dying out.
- **Oscillators**: It's another obvious pattern where a set of cells keep oscilating between two states.

Simple rules, Simple patters, Huh ?

Let's look at onther one:
- **Spaceships**: A set of cells, which move together in one direction, leaving no traces behind. e.g: Glider (GIF below.)

Cool, Isn't it. How about a Glider generator.
- **Glider Gun**: It's a pattern, which keeps oscilating (like an oscillator) and periodically emits spaceships like the Glider. e.g: Gosper's Glider Gun creating gliders. (GIF).

Hmm, how about some pattern that leaves some traces behind, Introducing:
- **Puffer**: It's similar to a spaceship, however it leaves the traces behind. (Examples)

### Why does it matter ?

Conway's game of life is a perfect example to demonstrate how complex behaviour can emerge from simple rules iterated overtime along with providing a simple way to trace back each iteration.

It got me thinking about system design and how often times in order to develop a complex system, simplicity is often neglected. However, with simple rules we can create complex systems.

Thank You for Reading ! Stay tuned, I'll be writing more about it and how to program it in Go Language. 

Looking forward to your feedback on the post.

---
