function edgeModule = Alg_GRC_cut(ConnectivityM)

npoints = size(ConnectivityM,1);

[edgeArr,~] = pebbleGame_new(sparse(ConnectivityM));
dfdf = tril(ConnectivityM,-1);
[c_a,c_b,~] = find(dfdf~=0);
nodeArrS = [c_a,c_b];


edgeArr(:,all(edgeArr==0,1),:) = [];
edgeArr(all(edgeArr==0,2),:) = [];
edgeModule = zeros(1,1);
%对每个rigid模块进行三连通模块寻找
for k=1:size(edgeArr,2)
    
    ei = edgeArr(:,k);
    ei(find(ei==0)) = [];
    subMatrix = zeros(npoints,npoints);
    for eee=1:length(ei)
        leftNode = nodeArrS(ei(eee),1);
        rightNode = nodeArrS(ei(eee),2);
        subMatrix(leftNode,rightNode) = 1;
        subMatrix(rightNode,leftNode) = 1;
    end
    
    [~,triComponents,es] = cut_2(sparse(subMatrix),ei');
    noNum = sum(es~=0,1);
    triES = find(noNum ~= 0);
    maxArrLen = max(noNum);
    eses = es(1:maxArrLen,triES);

    if triComponents(1,1) == -1 && isempty(eses)
        len = size(edgeModule,2);
        edgeModule(1:length(ei),len+1) = ei;
    end
    
    while(~isempty(eses))
        test_i = unique(eses(:,1));
        eses(:,1) = [];
        test_i(find(test_i==0)) = [];
        if length(test_i) < 3
            continue;
        end
        tsMatrix = zeros(npoints,npoints);
        for te=1:length(test_i)
            leftNode = nodeArrS(test_i(te),1);
            rightNode = nodeArrS(test_i(te),2);
            tsMatrix(leftNode,rightNode) = 1;
            tsMatrix(rightNode,leftNode) = 1;
        end
        [~,ts,triMin] = cut_2(sparse(tsMatrix),test_i');
        if(ts(1,1) == -1)
            len = size(edgeModule,2);
            edgeModule(1:length(test_i),len+1) = test_i;
        else
            triMin(:,all(triMin==0,1),:) = [];
            for it=1:size(triMin,2)
                esit = triMin(:,it)';
                esit(find(esit==0)) = [];
                esit = unique(esit,"stable");
                if(length(esit) < 3)
                    continue;
                end
                eses(1:length(esit),end+1) = esit;
            end
        end
    end
end

edgeModule(:,all(edgeModule==0,1),:) = [];

end




