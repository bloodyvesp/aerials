parameters
random_data
printf("ALGORITHM STARTS\n\n");

printf("Getting relevant points.\n");
RP = relevant_points(P, Re, sigma);
printf("%d relevant points found.\n", size(RP, 1));

printf("Getting weights.\n");
tic;
W = weights(RP, P, Re, sigma);
toc;

printf("Filtering most important points.\n");
[MI, IW] = filter_most_important_points(RP, W, n);

printf("Getting position. \n");
y = get_position(IW, MI);

printf("------------------------------------\n\n");
printf("PLOTTING RESULTS.\n");

d = norm(x-y);
printf("Distance from real position: %f.\n", d);

[X,Y] = poinst_for_circles_plotting(P, Re);
[s1, s2] = segment(x, y);

plot(X, Y, "5", RP(:,1), RP(:,2), ".b", MI(:,1), MI(:,2), "or", x(1), x(2), "+", y(1), y(2), "x", s1, s2);
map_size = 4*max_coordinate;
axis([-map_size, map_size, -map_size, map_size], "square");
