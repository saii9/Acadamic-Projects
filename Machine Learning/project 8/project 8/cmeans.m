data = load('data8.txt');  % load some sample data
n_clusters = 2;              % number of clusters
[center,U,obj_fcn] = fcm(data, n_clusters);