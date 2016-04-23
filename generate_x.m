function [x_out] = generate_x( tau)   % tau should be 6X1
    global_var;
    z0_index = randi(5, num_part, 1);
    x_out = zeros(6, num_part); 
    p = P(z0_index, :);
    [~, z_index] = find(mnrnd(1 ,p));
    z = z_dist(:, z_index);
    wx = mvnrnd(mu_w, sigma_w, num_part)'; 
    tau_rep = repmat (tau, 1, num_part);
    x_out = phi*tau_rep + si_z*z + si_w*wx;  % x_out will be 6 X 1000
end