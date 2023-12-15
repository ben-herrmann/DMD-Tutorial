function fhandle = plot_heat(x,y,q)

s = pcolor(x,y,q);
set(s,'FaceColor','interp','EdgeColor','none');
colormap("hot")
xticks([]); yticks([]);
daspect([1 1 1]);
set(gcf,'Color','w');
fhandle = gcf;
axis tight;
end