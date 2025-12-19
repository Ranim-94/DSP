# Digital Signal Processing

## Table of Contents

- [Digital Signal Processing](#digital-signal-processing)
  - [Table of Contents](#table-of-contents)
  - [Repo Description](#repo-description)
  - [Tools Used](#tools-used)
    - [Installation](#installation)
  - [Resources](#resources)
    - [Youtube (GNU Radio)](#youtube-gnu-radio)
    - [Youtube and Websites (Signal Processing)](#youtube-and-websites-signal-processing)
    - [Websites](#websites)
    - [Githubs](#githubs)

## Repo Description

This repository contains simulation for ***digital signal processing*** concepts encoutered in all aspect of signal processing (communication, radar,audio,...)

In general, it can be viewed in 2 parts:

1. Time and Frequency domain operations: convolution, correlration, Fourier Trasnform (and frequency analysis),Z-transform
2. System Operation: Mainly filtering: FIR and IIR.

## Tools Used

MATLAB is the main tool.

In addition, GNU radio is also will be used

### Installation

GNU Radio on ubuntu:

<pre>sudo apt-get install gnuradio</pre>

If the command has give some erros, like broken dependencies,... shown below

<pre>Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
gnuradio : Depends: libjs-mathjax but it is not installable
Depends: python3-lxml but it is not installable
Depends: python3-numpy (>= 1:1.25.0) but it is not installable
Depends: python3-pyqtgraph but it is not going to be installed
Depends: python3-numpy-abi9 but it is not installable
Depends: libboost-program-options1.83.0 (>= 1.83.0) but it is not installable
Depends: libgnuradio-analog3.10.9t64 (>= 3.10.9.2) but it is not going to be installed</pre>

We can use `conda`:

<pre>conda install -c conda-forge gnuradio</pre>

`conda` will solve these issues and update the dependencies, espcially for `python`


## Resources

### Youtube (GNU Radio)

- [GNU Radio with HACKADAY](https://www.youtube.com/watch?v=ufxBX_uNCa0)
  - Good for starting point
- [SDR with Harvy Mudd](https://www.youtube.com/watch?v=tj_9p_rXULM&list=PLywxmTaHNUNyKmgF70q8q3QHYIw_LFbrX)
- [European GNU Radio](https://www.youtube.com/watch?v=_0xF_eQoSGA)
  - Introductory to Advanced topics
  - Todo once mastering the fundamental points(base)

### Youtube and Websites (Signal Processing)

In general, these channels are very educative, and present some nice content along with simulation example

- [Dr Adam Panagos](https://www.youtube.com/@AdamPanagos)
  - Also has [website](https://www.adampanagos.org/)

- [Dr Assia Kourgli](https://www.youtube.com/@assiakourgli/featured)
  - It explains in French, with nice demo and exercices in python

- [Barry Van Veen](https://www.youtube.com/@allsignalprocessing/playlists)
  - feature: contents for statistical signal processing

- [Rich Radke](https://www.youtube.com/@RichRadke)
  - also [DSP course class](https://sites.ecse.rpi.edu/~rjradke/dspcourse.html) 
  - [personal web page](https://sites.ecse.rpi.edu/~rjradke/index.htm)

- [Miki Lustig](https://www.youtube.com/@sm313)

- [Dr Mark Fowler](https://www.youtube.com/@mfowler314/featured)
  - [University Web Page](https://ws.binghamton.edu/fowler/)
  - [EECE 525 Digital Audio Signal Processing](https://www.youtube.com/watch?v=MuYSe1q_LPw&list=PL4BDg_AslePlaRojxVnCjNoJu70c58UiS)
  - [EECE 301 Signal and Systems](https://www.youtube.com/watch?v=0a3IWcjJ87A&list=PL4BDg_AslePmY2yj7PypRskTeZnJVCJVy)

### Websites

- [GNU Radio](https://wiki.gnuradio.org/index.php?title=Main_Page)

### Githubs

[Mathwork for DSP](https://github.com/MathWorks-Teaching-Resources/DSP-Signals-and-Filter-Design)
