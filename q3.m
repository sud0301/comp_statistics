q1
global_var;
load ('RSSI-measurements.mat');
tau = zeros(6, num_steps);

w_pdf = @(mu, var) mvnpdf(var, mu, obs_std);
part = mvnrnd(mu_x0, sigma_x0, num_part); 
part= part';
obs_density_mean = generate_y_mean(part);

w = w_pdf(obs_density_mean', Y(:,1)');
sum_w = sum(bsxfun(@times,part,w'),2);
tau(:, 1) = sum_w/sum(w);

for k = 2:num_steps, 
    new_part = generate_x(tau(:,k-1));
    obs_density_mean = generate_y_mean(new_part);
    w = w_pdf( obs_density_mean', Y(:, k)'); % weighting
    sum_nw = sum(bsxfun(@times, new_part, w'),2);
    tau(:,k) = sum_nw/sum(w); 
    k
end
plot(traj(1,:), traj(4,:), 'b-' );
hold on;
plot(tau(1,:), tau(4,:), 'r-');
