# Arnold Tongues Calculations

This script calculates and visualizes the Arnold tongues, a concept from dynamical systems theory. It examines the behavior of a system across varying parameters `K` and `Omega`.

## Overview

The script iterates over ranges of `K` (amplitude parameter) and `Omega` (frequency parameter), computing a value `W` at each iteration. It compares `W` against predefined `Win` values to determine the start and end points of the Arnold tongues in the parameter space.

## Parameters

- **Niter**: The number of iterations for each calculation.
- **t0**: The initial value of `t`.
- **Win**: A list of window values for comparison against `W`.
- **epsilon**: The tolerance used for comparing `W` to `Win` values.
- **K**: The range of amplitude parameter values.
- **Omega**: The range of frequency parameter values.

## Outputs

- **Kb**, **Ob**: Arrays marking the start points of the Arnold tongues in the `K-Omega` parameter space.
- **Ke**, **Oe**: Arrays marking the end points of the Arnold tongues in the `K-Omega` parameter space.

# Tutorial: `quasip` Function

The `quasip` function simulates a dynamical system based on a set of parameters. It explores different behaviors of the system under various conditions.

## Parameters

- **Map** (int): Determines the type of system to simulate. Set to `0` for differential equation mode, `1` for map mode.
- **alpha**, **beta**, **gamma** (float): Parameters influencing the system's behavior in differential equation mode.
- **A**, **B** (float): Amplitude parameters used in the differential equation.
- **Omega** (float): Frequency parameter for the system.
- **Picture** (int): Determines the type of plot. `1` for a 1D map, `2` for theta_dot vs theta, and `3` for a 2D torus plot.
- **k**, **b** (float): Parameters used in map mode. k = coupling constant   

## Returns

- **Pendulum** (list of tuples): Contains positions (b1, b2) for plotting the pendulum's orientation.
- **Circle_map** (list of tuples): Contains positions for plotting the 1D map if `Picture == 1`.
- **Theta_dot** (list of tuples): Contains positions for plotting theta_dot vs theta if `Picture == 2`.
- **Torus** (list of tuples): Contains line segments for the 2D torus plot if `Picture == 3`.


## Example
Pendulum, Circle_map, Theta_dot, Torus = `quasip_test` (Map, alpha, beta, gamma, A, B, Omega, Picture, k, b)
