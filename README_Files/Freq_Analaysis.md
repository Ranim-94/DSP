
# Fourier Analysis

## Some Block Notes

### Throttle Block

- When running a flowgraph in GNU radio, if no hardware involve (like `Audio Sink` block), the CPU cycle will get overwhelmed,
- `Throttle` block prevent that

### QT GUI Frequency Sink

- It gives the magnitude square of the FFT
- So in other word the energy density, not the exact magnitude of the FFT

### FFT

- This block works only on `complex` data type, so if our `Signal Source` uses `float` type for example, we need some type conversion like `Float to Complex` block

## Some Notes and TODO Work

- The role of `Stream to Vector` and `Vector to Stream` blocks
- The `Throttle` block also: do some research about it
- Some DSP work (more math): the relation and visualisation about complex sisnusoid, how they are rotating,
  - Maybe read the article about the imagniary numbers
  - Do some simulation to grasp the concept

## Some Results

<u>Parameters:</u>

- `nfft = 32`
- `sampling rate = 32 Hz`

### For a cos waveform (type `float`)

- for `freq = 1`, we have 1 cycle in 32 samples
- freq bins at 1 and -1
- Notes that the dispalyed used will be in functions of bins, and not freq in Hz as in `QT GUI Frequency Sink`
  - the discrete freq = 1/32 cycle per sample
  - if we change the freq to `freq = 3`, we have 3 cycles per `32` samples

### For a sin waveform (type `float`)

For  `freq = 1`

- The time waveform: will not start from 0 as cos, but still we can see 1 cycle per 32 samples
- The freq spectrum: `I` components are 0 and `Q` components are +1 and -1

### A `Complex` sinusoid

- In `Signal Source` block, the signal type is `complex`
- No need `Float to Complex` for the `FFT` block
- In waveform time domain: we obtain a complex sinusoid with `I` and `Q` components
- The frequency domain: we have 1 impulse at bin 1
