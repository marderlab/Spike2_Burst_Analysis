function [ output_args ] = scatter_plotter( parameter, title )
%Plot data, used with T_pH_plot_parms.m.

[num_conds,num_preps]=size(parameter);
x = 1:num_conds;
cond = x';
jitter = 0.3*rand(num_preps,1)-0.15;

minimum = round(min(min(parameter)),1) - 0.1;
maximum = round(max(max(parameter)),1) + 0.1;
y_axis = [minimum,maximum];

i = 1;
prep_start = 1;
hold off
scatter(cond+jitter(i),parameter(:,i),'MarkerFaceColor',[0.5 0.5 0.5],...
        'MarkerEdgeColor',[0.5 0.5 0.5]);
hold on
plot(cond(1:num_conds)+jitter(i),parameter(1:num_conds,i),'Color',[0.5 0.5 0.5],'LineWidth',2);

for i = 2:num_preps    
scatter(cond+jitter(i),parameter(:,i),'MarkerFaceColor',[0.5 0.5 0.5],...
        'MarkerEdgeColor',[0.5 0.5 0.5]);
plot(cond(1:num_conds)+jitter(i),parameter(1:num_conds,i),...
    'Color',[0.5 0.5 0.5],'LineWidth',2);    
end

patch([0.5 2.5 2.5 0.5],[y_axis(1) y_axis(1) y_axis(2) y_axis(2)],'k','FaceAlpha',0.1,'EdgeColor','w');
patch([11.5 13.5 13.5 11.5],[y_axis(1) y_axis(1) y_axis(2) y_axis(2)],'k','FaceAlpha',0.1,'EdgeColor','w');
patch([(num_conds-1.5) (num_conds+0.5) (num_conds+0.5) (num_conds-1.5)],...
   [y_axis(1) y_axis(1) y_axis(2) y_axis(2)],'k','FaceAlpha',0.1,'EdgeColor','w');

plot(cond(1:12),parameter(2,1)*ones(12,1),'--k','LineWidth',1);
plot(cond(13:24),parameter(13,1)*ones(12,1),'--k','LineWidth',1);

ax = gca;
ax.XTick = 1:num_conds;
conditions = {'11';'11';'15';'19';'23';'25';'27';'29';'31';'33';'35';'11';...
    '11';'15';'19';'23';'25';'27';'29';'31';'33';'35';'11';'11'};
set(gca,'XTickLabel',conditions)
xlim([0.5 (num_conds+0.5)]);
ylim([minimum maximum]);

ylabel(title)
xlabel('T (C)')
set(gca,'Box','off')

end

