clear all;
%{
s = {'a' 'b' 'b' 'c' 'd' 'e' 'e' 'e' 'e' 'f' 'g' 'g' 'g' 'g' 'h' 'i' 'i' 'i' 'i' 'j' 'k' 'k' 'k' 'l' 'l' 'l'};
t = {'e' 'e' 'g' 'b' 'e' 'b' 'd' 'g' 'i' 'g' 'b' 'e' 'i' 'j' 'i' 'h' 'e' 'g' 'l' 'g' 'h' 'i' 'l' 'k' 'i' 'j'};
G = digraph(s,t);
labels = {'a/1' 'b/2' 'b/2' 'c/1' 'd/1' 'e/4' 'e/4' 'e/4' 'e/4' 'f/1' 'g/4' 'g/4' 'g/4' 'g/4' 'h/1' 'i/4' 'i/4' 'i/4' 'i/4' 'j/1' 'k/3' 'k/3' 'k/3' 'l/3' 'l/3' 'l/3'};
p = plot(G,'Layout','layered','EdgeLabel',labels);
%highlight(p,[1 1 1],[2 3 4],'EdgeColor','g')
%highlight(p,[2 2],[1 4],'EdgeColor','r')
%highlight(p,3,2,'EdgeColor','m')
title('PageRank Score Transfer Between Nodes')

pr = centrality(G,'pagerank','FollowProbability',0.85)
%}

matrix = [1 2 4 0; 0 3 2 6; 2 9 0 3 ; 1 2 4 0; 0 3 2 6; 2 9 0 3];
[W,H] = nnmf(matrix, 2);