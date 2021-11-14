function edgeArr = Alg_rigid(ConnectivityM)

[~,edgeArr] = pebbleGame_new(sparse(ConnectivityM));
edgeArr(:,all(edgeArr==0,1),:) = [];
edgeArr(all(edgeArr==0,2),:) = [];

end
