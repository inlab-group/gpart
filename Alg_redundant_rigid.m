function edgeArr = Alg_redundant_rigid(ConnectivityM)

[edgeArr,~] = pebbleGame_new(sparse(ConnectivityM));

edgeArr(:,all(edgeArr==0,1),:) = [];
edgeArr(all(edgeArr==0,2),:) = [];

end
