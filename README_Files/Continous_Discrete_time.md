
# Continous vs Discrete Time Gnu Radio

In `QT GUI Time Sink`:

- <u> 1st Note: Nb of Points:</u>
  - Usually people let the number of points for the default, but change it according to our need
  - Be aware of the data type between this block and `Signal Source` block, in my experiments both are float (they should be the same, or an red arrow appear)
- <u>2nd Note:</u> In `config` tab, we set `Control Panel` to `yes`

<u>Simulation Parameters:</u>

- Signal type: cos
- freq range(Hz):500:step=100:2e3
- Nb of points: 100
