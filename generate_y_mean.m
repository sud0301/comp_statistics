function [obs_mean] = generate_y_mean(x_in)
    global_var;
    
    x_size = size(x_in,2);
   
    x_pos_1 = repmat( x_in(1,:), 7 , 1);
    x_pos_2 = repmat( x_in(4,:), 7 , 1);
    stat_1 = repmat(stations(1, :)', 1, 10000 );
    stat_2 = repmat(stations(2, :)', 1, 10000 );
    
    diff_1 = x_pos_1-stat_1;
    diff_2 = x_pos_2-stat_2;
    
    diff_mat = cat (3, diff_1, diff_2 );
    norm_diff = sqrt(sum(abs(diff_mat).^2,3));
     
    obs_mean = 90*ones(num_stations, x_size) - 10*eta*log10(norm_diff);
   
   % obs_mean  output will be 7 X 1000
end
