clear all;
q1

Y =  zeros(7, num_steps);
obs_mean = zeros(7,num_steps);

for n=1: num_steps
    x_gt = repmat ([traj(1, num_steps) traj(4,num_steps)], num_stations ,1);
    norm_diff = sqrt(sum(abs(x_gt-stations').^2,2));
    obs_mean(:, num_steps) = 90*ones(num_stations,1) - 10*eta*log10(norm_diff);
    Y(:,num_steps)= obs_mean(:, num_steps) + mvnrnd(mu_noise, std_noise,7,1); 
end

