function fhandle = plot_sst(x,y,q)

[xx,yy] = meshgrid(x,y);
s = pcolor(xx,yy,q);
set(s,'FaceColor','interp','EdgeColor','none');
colormap('jet');
set(gca,'Color',[0.4 0.4 0.4]);
xticks([]); yticks([]);
daspect([1 1 1]);
set(gcf,'Color','w');
fhandle = gcf;
axis tight;
end