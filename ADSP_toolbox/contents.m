% ADSP TOOLBOX
% Matlab functions to accompany the companian book
%     Adaptive Digital Signal Processing
%             by Manolakis and Ingle
%             Publisher: Pearson
%             Copyright 2011
% Version 1.00
%
% Chapter02: Discrete-Time Signals and Systems
%       conv            - Computation of convolution sequence
%       conv0           - *Computation and its support
%       conv2           - Compute convolution and its support
%       convmtx         - Convolution matrix
%       convser         - Serial computation of convolution
%       convvec         - Vector computation of convolution
%       delta           - *Generate unit sample sequence
%       filter          - Implementation of a difference equation
%       filter2         - Implementation of 2D FIR spatial filter
%       firstream       - *Real-time FIR filter simulation
%       fold            - *Fold or flip a sequence
%       impz            - Computation of impulse response
%       persegen        - *Generate periodic sequence
%       plot            - General plotting function
%       pulsetrain      - Generate a pulse train
%       shift           - *Shift a sequence by n_0 samples
%       stem            - Plot a sequence
%       stepz           - Computation of step response
%       sound           - Playing of audio signals
%       timealign       - *Create sequences with the same support
%       unitpulse       - *Generate unit pulse sequence
%       unitstep        - *Generate unit step sequence
%       wavread         - Read a wave audio file
%       wavwrite        - Write a wave audio file
% Chapter03: The z-Transform
%       conv            - Multiplies two polynomials
%       deconv          - Evaluation of long division
%       filter          - Determines response of a LCCDE
%       filtic          - Determines initial condition array for use in filter
%       poly            - Determines the coefficients of a polynomial from its roots
%       polyval         - Evaluates the value of a polynomial
%       residuez        - Determines the coefficients of partial fraction expansion
%       roots           - Computes the roots of a polynomial
%       zplane          - Plots the pole-zero pattern of a rational system function
% Chapter04: Fourier Representation of Signals
%       angle           - Computes angle of a complex number
%       diric           - Computes the digital sinc function
%       dtfs            - *Computes the DTFS
%       dtft12          - *Computes the DTFT of x[n], N_1 <= n <= N_2
%       fft             - Computes the DTFS
%       freqz           - Computes the DTFT of finite duration sequences
%       idtfs           - *Computes the inverse DTFS
%       ifft            - Computes the inverse DTFS
%       sinc            - Computes the sinc function
%       unwrap          - Computes a 'continuous' phase from principal values
% Chapter05: Transform Analysis of LTI Systems
%       abs             - Computes the magnitude of frequency response
%       angle           - Computes the principal value of phase response
%       contphase       - Computes the continuous phase from group delay
%       fft             - Computes equidistant values of the DTFT
%       freqs           - Computes continuous-time frequency response
%       freqz           - Computes the frequency response function
%       freqz0          - Computes the frequency response function
%       grpdelay        - Computes the group delay response
%       grpdelay0       - Computes the group delay response
%       fvtool          - Filter analysis and visualization tool
%       phasez          - Computes phase response in radians
%       phasedelay      - Computes phase delay in 'samples'
%       polystab        - Converts polynomial to minimum phase
%       splane          - Plots poles and zeros of a rational H(s)
% Chapter06: Sampling of Continuous-Time Signals
%       audiorecorder   - Records sound as an object using an audio input device
%       audioplayer     - Creates a player object for use with the play function
%       ceil            - Quantizes a number to the nearest integer toward \infty
%       fix             - Quantizes a number to the nearest integer toward 0
%       floor           - Quantizes a number to the nearest integer toward -\infty
%       play            - Plays a player object through an audio  output device
%       round           - Quantizes a number to the nearest integer
%       sinc            - Computes the sin(pi*x)/(pi*x) interpolating function
%       sound           - Plays sampled signal as a sound through speakers
%       wavrecord       - Records sound through mic or input-line (PC only)
%       wavplay         - Plays sampled signal as a sound through speaker (PC only)
% Chapter07: The Discrete Fourier Transform
%       bartlett        - Computes the N-point Bartlett window coefficients
%       circfold        - *Circular time reversal of a sequence using modulo-N
%       circonv         - *Circular convolution in the time-domain
%       circonvfft      - *Circular convolution using the FFT algorithm
%       cirshift0       - *Circular shift of a sequence using modulo-N
%       fft             - Fast algorithm for the computation of the 1D-DFT
%       fft2            - Fast algorithm for the computation of the 2D-DFT
%       fftshift        - Moves the zero-frequency component to the center
%       hann            - Computes the N-point Hann window coefficients
%       hamming         - Computes the N-point Hamming window coefficients
%       ifft            - Fast algorithm for the computation of the inverse 1D-DFT
%       ifft2           - Fast algorithm for the computation of the inverse 2D-DFT
%       ifftshift       - Moves time-origin componnet to the center
%       mod             - Performs the modulo-N operation on signal arguments
%       overlap_add     - *Overlap-and-add method of block convolution
%       overlap_save    - *Overlap-and-save method of block convolution
%       rectwin         - Computes the N-point rectangular window coefficients
%       spectrogram0    - *Calculation and display of spectrograms
% Chapter08: Computation of the Discrete Fourier Transform
%       dftdirect       - *Direct computation of the DFT
%       fftrecur        - *Recursive computation using divide & conquer
%       bitrev          - *Bit-reversal algorithm based on Gold and Rader (1969)
%       fftditr2        - *Decimation-in-time Radix-2 FFT algorithm
%       gafft           - *Goertzel's algorithm
%       fft             - Fast algorithm for the computation of the 1D-DFT
%       fft2            - Fast algorithm for the computation of the 2D-DFT
%       fftshift        - Moves the zero-frequency component to the center
%       cta             - *Chirp transform algorithm
%       czt             - Chirp z-transform
%       ifft            - Fast algorithm for the computation of the inverse 1D-DFT
%       ifft2           - Fast algorithm for the computation of the inverse 2D-DFT
%       ifftshift       - Moves time-origin component to the center
%       zfa             - *Zoom FFT algorithm
% Chapter09: Structures for Discrete-Time Systems
%       filterdf1       - *Implementation of direct form I (Normal form)
%       filterdf2t      - *Implementation of direct form II (Transposed form)
%       filter          - Implementation of direct form II (Transposed form)
%       filtic          - Computation of initial conditions for filter
%       tf2sos          - Direct form to cascade form conversion
%       sos2tf          - Cascade form to direct form conversion
%       sosfilt         - Implementation of cascade form
%       residuez        - Computatoin of residues needed in parallel form
%       conv            - FIR system implementation using convolution
%       filterfirdf     - *Direct form implementation of FIR system
%       fir2lat         - *FIR direct form to lattice form conversion
%       lat2fir         - *Lattice form to FIR direct form conversion
%       azlatfilt       - *All-zero lattice form implementation
%       aplatfilt       - *All-pole lattice form implementation
%       tf2zp           - Direct form to zero-pole form conversion
%       zp2tf           - Zero-pole form to direct form conversion
%       sos2zp          - Cascade form to zero-pole form conversion
%       zp2sos          - Zero-pole form to cascade form conversion
%       filtercf        - *Implementation of cascade form
%       filterpf        - *Implementation of parallel form
%       tf2pf           - *Direct form to parallel form conversion
%       pf2tf           - *Parallel form to direct form conversion
% Chapter10: Design of FIR Filters
%       amplresp        - *Computation of the amplitude response
%       bartlett        - Computation of Bartlett window function
%       fdatool         - GUI-based filter design and analysis tool
%       fir1            - FIR filter design using the window method
%       fir2            - FIR filter design using the frequency-sampling method
%       fircls          - FIR filter design by constrained least-squares (CLS)
%       fircls1         - Low & high pass FIR filter design by CLS
%       firls           - FIR filter design by least-squares optimization
%       firpm           - FIR filter design using the Parks-McClellan algorithm
%       firpmord        - Filter order calculation for the firpm function
%       hamming         - Computation of Hamming window function
%       hann            - Computation of Hann window function
%       ideallp         - *Ideal lowpass filter impulse response
%       kaiser          - Computation of Kaiser window funciton
%       kaiser0         - *Computation of residues needed in parallel form
%       kaiserord       - Filter order calculations for the kaiser function
%       rectwin         - Computation of rectangular window function
% Chapter11: Design of IIR Filters
%       bilinear        - Analog to digital filter transformation-bilinear mapping
%       buttord         - Butterworth analog/digital filter order computation
%       butter          - Butterworth analog/digital filter design
%       cheb1ord        - Chebyshev I analog/digital filter order computation
%       cheby1          - Chebyshev I analog/digital filter design
%       cheb2ord        - Chebyshev II analog/digital filter order computation
%       cheby2          - Chebyshev II analog/digital filter design
%       ellipord        - Elliptic analog/digital filter order computation
%       ellip           - Elliptic analog/digital filter design
%       ellipke         - Complete elliptic integral of the first kind
%       fdatool         - GUI-based filter design and analysis tool
%       filtfilt        - Zero-phase IIR filtering
%       impinvar        - Analog to digital filter transformation-impulse invariance
%       lp2bp           - Analog lowpass to bandpass filter transformation
%       lp2bs           - Analog lowpass to bandstop filter transformation
%       lp2hp           - Analog lowpass to highpass filter transformation
%       lp2lp           - Analog lowpass to lowpass filter transformation
%       z2z             - *Analog lowpass to lowpass filter transformation
% Chapter12: Multirate Signal Processing
%       decimate        - Resamples data at a lower rate after lowpass filtering
%       downsample      - Retains every N-th sample starting with the first
%       firdec          - *FIR decimation by an integer factor
%       interp          - Resamples data at a higher rate using lowpass interpolation
%       ppdecim         - *Polyphase implementation of the decimation filter
%       ppinterp        - *Polyphase implementation of the interpolation filter
%       resample        - Changes the sampling rate of a signal
%       reshape         - Changes the shape of an array
%       src             - *Sample rate compressor
%       sre             - *Sample rate expander
%       upfirdn         - Resamples a signal using FIR filter
%       upsample        - Inserts (N-1) zeros between input samples
% Chapter13: Random Signals
%       epdf            - Computes the empirical probability density function
%       rand            - Generates uniform random numbers
%       randn           - Generates normal random numbers
% Chapter14: Random Signal Processing
%       acrs            - *Computes the sample ACRS
%       acrsfft         - *Computes the sample ACRS using the FFT
%       corrcoef        - Computes the sample correlation coefficient
%       cov             - Computes the sample covariance
%       eig             - Computes the eigenvalues and eigenvectors
%       klt             - *Computes the KLT
%       mean            - Computes the sample mean
%       psdbt           - *Computes the BT PSD estimate
%       psdmodper       - *Computes the modified periodogram
%       psdper          - *Computes the periodogram
%       psdwelch        - *Computes Welch's PSD estimate
%       pwelch          - *Computes Welch's PSD estimate
%       svd             - Computes the singular value decomposition
%       var             - Computes the sample variance
% Chapter15: Finite Wordlength Effects
%       bin2dec         - Retains every N-th sample starting with the first
%       dec2bin         - Resamples data at a lower rate after lowpass filtering
%       dec2beqR        - *FIR decimation by an integer factor
%       dec2beqT        - *Resamples data at a higher rate using lowpass interpolation
%       tf2sos          - Polyphase implementation of the decimation filter
%       zp2sos          - Polyphase implementation of the interpolation filter