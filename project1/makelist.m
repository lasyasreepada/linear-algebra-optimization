function[lnodes] = makelist(lpoly)
l = size(lpoly,3);
lnodes=lpoly(:,:,1);

for i=2:l
lnodes = cat(2,lnodes,lpoly(:,2:end,i));
end
end