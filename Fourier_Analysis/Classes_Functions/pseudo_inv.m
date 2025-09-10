


classdef pseudo_inv
    
    properties
        
        f_cos
        
        fs_in
        
        fs_ch
        
        delayed_channels
        
        ctft_channels_comp
        
        length_ctft_input
        
        gain_channels
        
        nb_channels
        
        freq_domain
        
    end 
    
            methods
                
                
                % Constructor
                function obj = pseudo_inv(param) 

                    obj.f_cos = param.f_cos;
                    
                    obj.fs_ch = param.fs_ch;
                    
                    obj.fs_in = param.fs_in;
                    
                    obj.delayed_channels = param.delayed_channels;
                    
                    obj.ctft_channels_comp = param.ctft_channels_comp;
                    
                    obj.length_ctft_input = param.length_ctft_input;
                    
                    obj.gain_channels = param.gain_channels ;
                    
                    obj.nb_channels = param.nb_channels;
                    
                    obj.fs_in = param.fs_in;
                    
                    obj.freq_domain =  param.freq_domain;
                    
                    
                end 
                
                
                function [ctft_pseudo_inv_amp, ctft_pseudo_inv_phase,...
                        ctft_pseudo_inv_comp,freq_vector_omega_1,...
                        freq_vector_omega_2,index_amp_max] = do_pseudo_inv(obj)
                
                    reminder = rem(2*obj.f_cos,obj.fs_ch);

                    if reminder == 0

                    aliasing_factor = 2*obj.f_cos/obj.fs_ch ;

                    else

                    aliasing_factor = ...
                    [ceil(2*obj.f_cos/obj.fs_ch), floor(2*obj.f_cos/obj.fs_ch)];

                    end
                    

                    c = 2*pi*obj.fs_ch;

                % Sampling Period per channel

                
                Ts_ch = 1/obj.fs_ch;

                vand_input = exp(-i*c*obj.delayed_channels) ;
                
                gamma_gain = diag(obj.gain_channels./Ts_ch);

                % computing frequ vec of the dowsampled channel

             

                % this is the omega in the authors paper
                choice_freq = 'choice_1';
                
                nb_of_point_for_sim = length(obj.freq_domain);
                
                freq_step_meas = reminder/(nb_of_point_for_sim/2);
                
                switch choice_freq
                    
                    case 'choice_1' 

                freq_vector_omega_1 = ...
                linspace(-obj.f_cos, -obj.f_cos + reminder - freq_step_meas,...
                nb_of_point_for_sim/2);

                freq_vector_omega_2 = ...
                linspace(-obj.f_cos + reminder ,...
                -obj.f_cos + obj.fs_ch,...
                nb_of_point_for_sim/2);

                    case 'choice_2'
                       freq_vector_omega_1 =  obj.freq_domain(1:end/2);
                        
                       freq_vector_omega_2 =  obj.freq_domain(end/2 + 1: end);
                    
                       
                    case 'choice_3'
                        
                    freq_vector_omega_1 = ...
                linspace(-obj.fs_in, -obj.fs_in + reminder - freq_step_meas,...
                nb_of_point_for_sim/2);

                freq_vector_omega_2 = ...
                linspace(-obj.fs_in + reminder ,...
                -obj.fs_in + obj.fs_ch,...
                nb_of_point_for_sim/2);    
                        
                        
                       
                end 

                %%
                fprintf('--> Starting Reconstruction using Pseudo Inv \n');

                
                nb_col_vand = aliasing_factor(1) - 1;

                vand_matrix = fliplr( vand_input(:).^(nb_col_vand:-1:0));
                
               index_meas = 0; 
                
              [ctft_pseudo_inv_amp_1, ctft_pseudo_inv_phase_1,...
                  ctft_pseudo_inv_comp_1,index_amp_max] = ...
              loop_over_omega(obj,vand_matrix,gamma_gain,...
               freq_vector_omega_1,index_meas);

            % 2nd interval P2
                
            nb_col_vand = aliasing_factor(2) - 1;

           vand_matrix = fliplr( vand_input(:).^(nb_col_vand:-1:0));
                
           index_meas = length(freq_vector_omega_1) + 1;
           
%            index_meas = 0;
               [ctft_pseudo_inv_amp_2, ctft_pseudo_inv_phase_2,...
                   ctft_pseudo_inv_comp_2,~] = ...
              loop_over_omega(obj,vand_matrix,gamma_gain,...
              freq_vector_omega_2,index_meas);  
          
          
%             ctft_pseudo_inv = [ctft_pseudo_inv_1,ctft_pseudo_inv_2];
          
             ctft_pseudo_inv_comp = ...
              vertcat(ctft_pseudo_inv_comp_1,ctft_pseudo_inv_comp_2) ;    

              ctft_pseudo_inv_amp = ...
              vertcat(ctft_pseudo_inv_amp_1,ctft_pseudo_inv_amp_2) ;  
           
              ctft_pseudo_inv_phase = ...
              vertcat(ctft_pseudo_inv_phase_1,ctft_pseudo_inv_phase_2) ;    
            
            fprintf('--> Finish Reconstruction using Pseudo Inv \n');
                    
                    
                    
                    
                end 
                    
            end
    
    
end 