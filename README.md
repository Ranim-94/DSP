# Digital Signal Processing

## Table of Contents

- [Digital Signal Processing](#digital-signal-processing)
  - [Table of Contents](#table-of-contents)
    - [Main Folders](#main-folders)
  - [Repo Description](#repo-description)
  - [Tools Used](#tools-used)
    - [Installation](#installation)
  - [Resources](#resources)
    - [Youtube (GNU Radio)](#youtube-gnu-radio)
    - [Websites](#websites)

### Main Folders

- [ADSP_toolbox](#adsp_toolbox)
- [Aliasing](#aliasing)
- [Convolution_Correlation](#convolution_correlation)
- [FIR](#fir)
- [Fourier_Analysis](#fourier_analysis)
- [Fourier_Analysis_2](#fourier_analysis_2)
- [I_Q_Sampling](#i_q_sampling)
- [Power Spectral Density](#power-spectral-density)
- [Sampling_Reconstruction](#sampling_reconstruction)
- [Simulink Training](#simulink-training)
- [Time_Frequency_Analysis](#time_frequency_analysis)
- [Z_Transform](#z_transform)

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

### Websites

-[GNU Radio](https://wiki.gnuradio.org/index.php?title=Main_Page)
