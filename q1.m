clear all;
global_var;

x0 = mvnrnd(mu_x0, sigma_x0); 
z_index = randi(5,1);
mu_w = zeros(2,1);
sigma_w = diag([0.5, 0.5]);
traj(:, 1) = x0'; 

for m = 2:num_steps    
    p = P(z_index, :);
    z_index = find(mnrnd(1 ,p ,1));
    z = z_dist(:, z_index);
    w = mvnrnd(mu_w, sigma_w, 1)'; 
    x_new = phi*traj(:, m-1) + si_z*z + si_w*w;
    traj = [traj x_new];
end
%plot(traj(1,:), traj(4,:) )
%hold on;
%plot(stations(1,:), stations(2,:), '*');

Y =  zeros(7, num_steps);
obs_mean = zeros(7,num_steps);

for n = 1:num_steps
    x_gt = repmat ([traj(1, num_steps) traj(4,num_steps)], num_stations ,1);
    norm_diff = sqrt(sum(abs(x_gt-stations').^2,2));
    obs_mean(:, num_steps) = 90*ones(num_stations,1) - 10*eta*log10(norm_diff);
    Y(:,num_steps)= obs_mean(:, num_steps) + mvnrnd(mu_noise, std_noise,7,1); 
end