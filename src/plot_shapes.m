function fhandle = plot_shapes(q)

s = pcolor(q);
set(s,'FaceColor','interp','EdgeColor','none');
colors = [1 0 1; 0 0 0; 0 1 1]; % magenta, black, cyan
colors_fine = interp1(linspace(0,1,3),colors,linspace(0,1,64));
colormap(colors_fine);
% colormap(redblue(64));
xticks([]); yticks([]);
daspect([1 1 1]);
set(gcf,'Color','w');
fhandle = gcf;
axis tight;
end