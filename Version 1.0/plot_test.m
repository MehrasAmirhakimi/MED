clc
close all
hold on
specifier = {'-ob' '-+g' '-*r' '-sc' '-xm' '-dk' '-.dy'};
legendn = cell(1, numel(n));

for i = 1:numel(n)
    
    plot(TV0,output2(i,:),specifier{i},'LineWidth',1.25);
    legendn{i} = ['n = ',num2str(n(i))];
    
end
legend(legendn,'Location','NorthEastOutside');
pbaspect([1.25 1 1]);
hold off