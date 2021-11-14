%% Initial
clc;clear all;close all;
currentFolder = pwd;
addpath(genpath(currentFolder));


%% Parameter：ConnectivityM (Graph Adjacency Matrix)
%% Output: edgelist of MRC, MRRC, MGRC

edgeModule = Alg_rigid(ConnectivityM);

edgeModule = Alg_redundant_rigid(ConnectivityM);

edgeModule = Alg_GRC_cut(ConnectivityM);
