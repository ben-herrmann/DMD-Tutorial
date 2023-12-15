function fhandle = plot_wake(q)

s = pcolor(q);
set(s,'FaceColor','interp','EdgeColor','none');
% yellow, red, black, blue, cyan
colors = [1 1 0; 1 0 0; 0 0 0; 0 0 1; 0 1 1];
colors_fine = interp1(0:0.25:1,colors,linspace(0,1,128));
colormap(colors_fine);
xticks([]); yticks([]);
daspect([1 1 1]);
set(gcf,'Color','w');
fhandle = gcf;
axis tight;
end