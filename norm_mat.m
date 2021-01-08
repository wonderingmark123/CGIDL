function Y=norm_mat(X)
Y=(X-min(min(X)))./(max(max(X))-min(min(X)));
end