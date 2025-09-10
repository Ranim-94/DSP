

def comp_alias_freq(fs,freq_signal):
       
       
       if (fs < 2 * freq_signal) == True:
       
              keep_going , m = True , 0
              
              while keep_going:
                     
                     f_alias = abs(freq_signal - m * fs)
       
                     if f_alias <= fs/2 == True:
                            
                            keep_going = False
                            
                     else:
                            m += 1
                            
       else:
              
              # no aliasing occure
              # we have respec the Nyquits Theorem
              f_alias, m = freq_signal, 0

       return f_alias,m