# OOP Basics in MATLAB

Notes from working on [`Fourier_Analysis_2/matlab_scripts/Experiments/Spectrum_Sim.m`](../Fourier_Analysis_2/matlab_scripts/Experiments/Spectrum_Sim.m)
(the OOP version of `Sim_Spectrum`).

## Table of Contents

1. [Anatomy of a class](#1-anatomy-of-a-class)
2. [Properties must be declared](#2-properties-must-be-declared)
3. [Access: MATLAB vs C++](#3-access-matlab-vs-c)
   - [`SetAccess = private`](#setaccess--private)
   - [`Dependent` and `Constant`](#dependent-and-constant)
4. [Constructor with name-value options](#4-constructor-with-name-value-options)
   - [Old version: `varargin` loop](#old-version-varargin-loop)
   - [New version: `arguments` block (R2019b+)](#new-version-arguments-block-r2019b)
5. [`nargin` / `nargout` and the hidden `obj` argument](#5-nargin--nargout-and-the-hidden-obj-argument)
   - [Optional argument with default value](#optional-argument-with-default-value)
   - [One function, two jobs](#one-function-two-jobs)
6. [Git reminders (for experimenting on the code)](#6-git-reminders-for-experimenting-on-the-code)

---

## 1. Anatomy of a class

```matlab
classdef Spectrum_Sim < handle          % handle class: obj is passed by reference
    properties                          % public parameters (read + write)
        bandwidth_Hz (1,1) double = 30
        nb_samples   (1,1) double = 800
    end
    properties (Dependent)              % computed on every read, not stored
        fs
    end
    properties (SetAccess = private)    % results: readable by all, written only by methods
        time_axis
        sig_sampled
        spectr
    end
    properties (Constant)               % fixed for the class
        signal_list = ["sin","sinc","periodic_rect"]
    end

    methods
        function obj = Spectrum_Sim(opts) ... end   % constructor
        function value = get.fs(obj) ... end        % getter of the Dependent property
        function run(obj) ... end
    end
    methods (Access = private)
        function sig = evalSignal(obj,t) ... end    % internal helper
    end
end
```

- `< handle` means a method that modifies `obj` (e.g. `obj.spectr = ...`) changes the
  same object the caller holds; no need to return `obj`.

---

## 2. Properties must be declared

A class object only has the properties listed in its `properties` blocks.

```matlab
obj.time_axis = time_axis;   % works only if time_axis is declared in a properties block
```

If it is not declared → error *"Unrecognized property 'time_axis' for class 'Spectrum_Sim'"*.

- **struct**: assigning a new field creates it on the fly.
- **class object**: no runtime fields (like C++). Exception: classes inheriting from
  `dynamicprops` can use `addprop` (rarely needed).

**Rule of thumb**
- Value used only inside one method → **local variable**, don't declare it.
- Value another method needs later (e.g. `computeSpectrum` needs `sig_sampled`) →
  **declare it as a property**.

---

## 3. Access: MATLAB vs C++

| | C++ `class` | MATLAB `classdef` |
|---|---|---|
| Default access | `private` | **`public`** |
| Syntax | `public:` / `protected:` / `private:` | `Access`, or separately `GetAccess` / `SetAccess` |
| Read-only from outside | private member + public `const` getter | `SetAccess = private` |

- A `properties` block with no attribute is **public**: `sim.bandwidth_Hz = 50;` works from
  the main script.
- MATLAB favours convenience (interactive/scientific use). Type/size declarations such as
  `(1,1) double` are checked on **every** assignment, so public properties are still
  validated (`sim.bandwidth_Hz = 'abc'` → error).

### `SetAccess = private`
- **Read**: public → `plot(sim.freq_bins, abs(sim.spectr))` works in the main script.
- **Write**: only the class's own methods.

Without it, the results could be overwritten silently:

```matlab
sim.run();
sim.spectr = zeros(1,1024);   % allowed if not private → wrong plot, no error
```

With it → *"Cannot set the read-only property 'spectr'"*.

C++ equivalent:

```cpp
class SpectrumSim {
public:
    const std::vector<double>& spectr() const { return spectr_; }
private:
    std::vector<double> spectr_;
};
```

### `Dependent` and `Constant`
- `Dependent` (`fs`): not stored; MATLAB calls `get.fs` on every read, so it is always
  consistent with `oversampling_factor * bandwidth_Hz`. No `set.fs` → cannot be assigned.

```matlab
function value = get.fs(obj)
    value = obj.oversampling_factor*obj.bandwidth_Hz;
end
```

- `Constant` (`signal_list`): fixed; nobody can change it, not even the class methods.

> Caveat: if a public parameter is changed after `run()` (e.g. `sim.bandwidth_Hz = 50`),
> the stored results still correspond to the old value until `run()` is called again.

---

## 4. Constructor with name-value options

### Old version: `varargin` loop

```matlab
function obj = Spectrum_Sim(varargin)
    for k = 1:2:numel(varargin)
        obj.(varargin{k}) = varargin{k+1};
    end
end
```

Call: `Spectrum_Sim('choice_signal','sinc','bandwidth_Hz',30)` →
`varargin = {'choice_signal','sinc','bandwidth_Hz',30}`

| index | 1 | 2 | 3 | 4 |
|---|---|---|---|---|
| content | name | value | name | value |

- Step of 2 → `k` always lands on a **name**, `k+1` is its **value**.
- `obj.(name)` = dynamic property access: `obj.('bandwidth_Hz') = 30` ≡ `obj.bandwidth_Hz = 30`.
- Weaknesses: odd number of args → index error; no validation; can set private results.

### New version: `arguments` block (R2019b+)

```matlab
function obj = Spectrum_Sim(opts)
    arguments
        opts.choice_signal       (1,1) string  {mustBeMember(opts.choice_signal, ...
            ["sin","sum_of_sinusoids_2","sum_of_sinusoids_3", ...
             "sinc","sinc_square","periodic_rect"])}
        opts.bandwidth_Hz        (1,1) double  {mustBePositive}
        opts.signal_amp          (1,1) double
        opts.oversampling_factor (1,1) double  {mustBeGreaterThan(opts.oversampling_factor,2)}
        opts.nb_samples          (1,1) double  {mustBeInteger, mustBePositive}
        opts.zero_padd           (1,1) logical
        opts.time_scale          (1,1) double  {mustBePositive}
        opts.show_debug          (1,1) logical
    end

    % copy only the options the caller actually passed
    names = fieldnames(opts);
    for i = 1:numel(names)
        obj.(names{i}) = opts.(names{i});
    end
end
```

- `opts.xxx` declares a **name-value** argument; MATLAB pairs names/values itself
  → no odd/even indexing.
- No default given → option is optional; if not passed it is **absent** from `opts`, and the
  property keeps its default from the `properties` block (single source of defaults).
- Validators (`mustBePositive`, `mustBeMember`, …) run before the body.
- Only public parameters are listed → callers cannot set `spectr`, `fs`, etc.
- The signal list is duplicated from `signal_list` → update both when adding a signal.

Calls:

```matlab
sim = Spectrum_Sim(choice_signal="sinc", bandwidth_Hz=30);    % R2021a+
sim = Spectrum_Sim('choice_signal','sinc','bandwidth_Hz',30);  % any version
sim = Spectrum_Sim();                                          % all defaults
sim.run();
```

---

## 5. `nargin` / `nargout` and the hidden `obj` argument

- `nargin`  = number of **inputs** actually received.
- `nargout` = number of **outputs** the caller asked for.
- In a method, **`obj` counts as an input**: `obj.generateSignal()` ≡ `generateSignal(obj)`.

| Call | Inputs | `nargin` |
|---|---|---|
| `obj.generateSignal()` | `obj` | 1 |
| `obj.generateSignal(4)` | `obj`, `4` | 2 |

→ For a method, `nargin` = (values in the parentheses) + 1.

### Optional argument with default value

```matlab
function [time_axis,sig] = generateSignal(obj,factor)
    if nargin < 2          % caller gave only obj
        factor = 1;
    end
    fs_loc = factor*obj.fs;
    N      = factor*obj.nb_samples;
    time_axis = ((-N/2):(N/2 - 1))./fs_loc;
    sig = obj.evalSignal(time_axis);

    if nargout == 0 || factor == 1     % store only the real sampled signal
        obj.time_axis   = time_axis;
        obj.sig_sampled = sig;
    end
end
```

`nargin < 1` would be wrong: a method always receives `obj`, so it would never be true and
`factor` would be undefined.

### One function, two jobs

| Caller | `factor` | Result | Stored in `obj`? |
|---|---|---|---|
| `run()` → `obj.generateSignal()` | 1 | sampled signal (used by FFT) | yes (`nargout == 0`) |
| `plot_time_Signal()` → `[t,s] = obj.generateSignal(4)` | 4 | dense "continuous" signal for plotting | no (`nargout = 2`, `factor ≠ 1`) |

- Multiplying **both** `fs` and `N` by the same factor keeps the same time window
  (see [`plot_time_signal.m`, lines 11–15](../Fourier_Analysis_2/matlab_scripts/Plotting_Logging/plot_time_signal.m#L11)).
- Start is identical: `-N/(2fs)`. End differs slightly: sampled `N/(2fs) - 1/fs`,
  dense `N/(2fs) - 1/(4fs)` (less than one sampling period, harmless for plots).
- Pitfall: `obj.generateSignal(4)` **without outputs** → `nargout == 0` → the dense signal
  overwrites `sig_sampled`. Stricter condition: `if factor == 1`.

---

## 6. Git reminders (for experimenting on the code)

- Untracked files belong to no branch: `git switch -c test` does not modify them, they
  "follow" you across branches.
- Checkout refuses if the target branch has a tracked file with the same path as an untracked one.
- `git clean -fd` permanently deletes untracked files. `git reset --hard` does not touch them.
- Isolation options: commit first, `git stash -u`, or `git worktree add ../DSP-test test`.
- `git add` only stages; a **commit** creates a version. To compare:

```bash
git diff Spectrum_Sim.m                       # working copy vs last commit (tracked files)
git log --oneline -- Spectrum_Sim.m           # history of the file
git show HEAD:path/to/Spectrum_Sim.m > old.m  # extract the old version
```

- Good habit: commit a baseline before each experiment, then `git diff`.
