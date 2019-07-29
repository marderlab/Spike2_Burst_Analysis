%Visualize baseline ramp phase relationships in conjunction with data_standardizer.m. 

mean_start_stops=[NaN(11,1),pd.cycle_end_m(2:12,2),lp.cycle_start_m(2:12,2),...
    lp.cycle_end_m(2:12,2),py.cycle_start_m(2:12,2),py.cycle_end_m(2:12,2)]; 
all_stds=[zeros(11,1),pd.cycle_end_std(2:12,2),lp.cycle_start_std(2:12,2),...
    lp.cycle_end_std(2:12,2),py.cycle_start_std(2:12,2),py.cycle_end_std(2:12,2)];

pd.width_cyc=pd.cycle_end_m(2:12,2);
lp.width_cyc=lp.cycle_end_m(2:12,2)-lp.cycle_start_m(2:12,2);
py.width_cyc=py.cycle_end_m(2:12,2)-py.cycle_start_m(2:12,2);
pd.width_cyc(isnan(pd.width_cyc)) = 0;
lp.width_cyc(isnan(lp.width_cyc)) = 0;
py.width_cyc(isnan(py.width_cyc)) = 0;

figure(6)
hold off
herrorbar( mean_start_stops(11,:),[6.6;6.6;4.3;4.3;2;2],all_stds(11,:), 'og');
hold on
herrorbar( mean_start_stops(10,:),[6.4;6.4;4.1;4.1;1.8;1.8],all_stds(10,:), 'or');
herrorbar( mean_start_stops(9,:),[6.2;6.2;3.9;3.9;1.6;1.6],all_stds(9,:), 'or');
herrorbar( mean_start_stops(8,:),[6;6;3.7;3.7;1.4;1.4],all_stds(8,:), 'or');
herrorbar( mean_start_stops(7,:),[5.8;5.8;3.5;3.5;1.2;1.2],all_stds(7,:), 'or');
herrorbar( mean_start_stops(6,:),[5.6;5.6;3.3;3.3;1;1],all_stds(6,:), 'oc');
herrorbar( mean_start_stops(5,:),[5.4;5.4;3.1;3.1;.8;.8], all_stds(5,:), 'oc');
herrorbar( mean_start_stops(4,:),[5.2;5.2;2.9;2.9;.6;.6], all_stds(4,:), 'ob');
herrorbar( mean_start_stops(3,:),[5;5;2.7;2.7;.4;.4],all_stds(3,:), 'ob');
herrorbar( mean_start_stops(2,:),[4.8;4.8;2.5;2.5;.2;.2], all_stds(2,:), 'ob');
herrorbar( mean_start_stops(1,:),[4.6;4.6;2.3;2.3;0;0], all_stds(1,:), 'ob');

%legend('',['Control'],'', ['Dec.'], '',['CabTRP'],'', ['Proct'], '',['CCAP'], '',['TNRFL'], '',['OXO']);

%title('Phase relationships of Pyloric neurons in a prep in saline with varying modulators');
mean_start_stops=[zeros(11,1),pd.cycle_end_m(2:12,2),lp.cycle_start_m(2:12,2),...
    lp.cycle_end_m(2:12,2),py.cycle_start_m(2:12,2),py.cycle_end_m(2:12,2)];
mean_start_stops(isnan(mean_start_stops)) = 2;

rectangle('Position', [mean_start_stops(11,1), 6.5, pd.width_cyc(11), 0.2], 'EdgeColor', 'g', 'FaceColor','g'); 
rectangle('Position', [mean_start_stops(10,1), 6.3, pd.width_cyc(10), 0.2],'EdgeColor','[1,0,0]', 'FaceColor','[1,0,0]');
rectangle('Position', [mean_start_stops(9,1), 6.1, pd.width_cyc(9), 0.2], 'EdgeColor', '[1,0.25,0]', 'FaceColor', '[1,0.25,0]');
rectangle('Position', [mean_start_stops(8,1), 5.9, pd.width_cyc(8), 0.2], 'EdgeColor', '[1,0.5,0]', 'FaceColor','[1,0.5,0]');
rectangle('Position', [mean_start_stops(7,1), 5.7, pd.width_cyc(7), 0.2], 'EdgeColor', '[1,0.75,0]', 'FaceColor','[1,0.75,0]'); 
rectangle('Position', [mean_start_stops(6,1), 5.5 pd.width_cyc(6), 0.2],'EdgeColor','[0,0.75,1]', 'FaceColor', '[0,0.75,1]');
rectangle('Position', [mean_start_stops(5,1), 5.3, pd.width_cyc(5), 0.2], 'EdgeColor', '[0,0.5,1]', 'FaceColor','[0,0.5,1]');
rectangle('Position', [mean_start_stops(4,1), 5.1, pd.width_cyc(4), 0.2], 'EdgeColor', '[0,0.25,1]', 'FaceColor', '[0,0.25,1]');
rectangle('Position', [mean_start_stops(3,1), 4.9, pd.width_cyc(3), 0.2], 'EdgeColor', 'b', 'FaceColor', 'b');
rectangle('Position', [mean_start_stops(2,1), 4.7, pd.width_cyc(2), 0.2], 'EdgeColor', '[0,0,0.75]', 'FaceColor', '[0,0,0.75]');
rectangle('Position', [mean_start_stops(1,1), 4.5, pd.width_cyc(1), 0.2], 'EdgeColor', '[0,0,0.5]', 'FaceColor', '[0,0,0.5]');

rectangle('Position', [mean_start_stops(11,3), 4.2, lp.width_cyc(11), 0.2], 'EdgeColor', 'g', 'FaceColor','g'); 
rectangle('Position', [mean_start_stops(10,3), 4, lp.width_cyc(10) ,0.2],'EdgeColor','[1,0,0]', 'FaceColor','[1,0,0]');
rectangle('Position', [mean_start_stops(9,3), 3.8, lp.width_cyc(9), 0.2], 'EdgeColor', '[1,0.25,0]', 'FaceColor', '[1,0.25,0]');
rectangle('Position', [mean_start_stops(8,3), 3.6, lp.width_cyc(8), 0.2], 'EdgeColor', '[1,0.5,0]', 'FaceColor','[1,0.5,0]');
rectangle('Position', [mean_start_stops(7,3), 3.4, lp.width_cyc(7), 0.2], 'EdgeColor', '[1,0.75,0]', 'FaceColor','[1,0.75,0]'); 
rectangle('Position', [mean_start_stops(6,3), 3.2, lp.width_cyc(6) ,0.2],'EdgeColor','[0,0.75,1]', 'FaceColor', '[0,0.75,1]');
rectangle('Position', [mean_start_stops(5,3), 3.0, lp.width_cyc(5), 0.2], 'EdgeColor', '[0,0.5,1]', 'FaceColor','[0,0.5,1]');
rectangle('Position', [mean_start_stops(4,3), 2.8, lp.width_cyc(4), 0.2], 'EdgeColor','[0,0.25,1]', 'FaceColor', '[0,0.25,1]');
rectangle('Position', [mean_start_stops(3,3), 2.6, lp.width_cyc(3), 0.2], 'EdgeColor', 'b', 'FaceColor', 'b');
rectangle('Position', [mean_start_stops(2,3), 2.4, lp.width_cyc(2), 0.2], 'EdgeColor', '[0,0,0.75]', 'FaceColor', '[0,0,0.75]');
rectangle('Position', [mean_start_stops(1,3), 2.2, lp.width_cyc(1), 0.2], 'EdgeColor', '[0,0,0.5]', 'FaceColor', '[0,0,0.5]');

rectangle('Position', [mean_start_stops(11,5), 1.9, py.width_cyc(11), 0.2], 'EdgeColor', 'g', 'FaceColor','g'); 
rectangle('Position', [mean_start_stops(10,5), 1.7, py.width_cyc(10), 0.2], 'EdgeColor', '[1,0,0]', 'FaceColor','[1,0,0]'); 
rectangle('Position', [mean_start_stops(9,5), 1.5 py.width_cyc(9) ,0.2],'EdgeColor','[1,0.25,0]', 'FaceColor', '[1,0.25,0]');
rectangle('Position', [mean_start_stops(8,5), 1.3, py.width_cyc(8), 0.2], 'EdgeColor', '[1,0.5,0]', 'FaceColor','[1,0.5,0]');
rectangle('Position', [mean_start_stops(7,5), 1.1, py.width_cyc(7), 0.2], 'EdgeColor', '[1,0.75,0]', 'FaceColor','[1,0.75,0]'); 
rectangle('Position', [mean_start_stops(6,5), .9 py.width_cyc(6) ,0.2],'EdgeColor','[0,0.75,1]', 'FaceColor', '[0,0.75,1]');
rectangle('Position', [mean_start_stops(5,5), .7, py.width_cyc(5), 0.2], 'EdgeColor', '[0,0.5,1]', 'FaceColor','[0,0.5,1]');
rectangle('Position', [mean_start_stops(4,5), .5, py.width_cyc(4), 0.2], 'EdgeColor', '[0,0.25,1]', 'FaceColor', '[0,0.25,1]');
rectangle('Position', [mean_start_stops(3,5), .3, py.width_cyc(3), 0.2], 'EdgeColor', 'b', 'FaceColor', 'b');
rectangle('Position', [mean_start_stops(2,5), 0.1, py.width_cyc(2), 0.2], 'EdgeColor', '[0,0,0.75]', 'FaceColor', '[0,0,0.75]');
rectangle('Position', [mean_start_stops(1,5), -.1, py.width_cyc(1), 0.2], 'EdgeColor', '[0,0,0.5]', 'FaceColor', '[0,0,0.5]');

xlim([0 1]);
ylim([-.2 6.7]);

set(gca,'YTickLabel',[]);
set(gca,'ytick',[]);
xlabel('phase')
set(gca,'FontSize',14)
set(gca,'FontWeight','bold')
set(gca,'Box','off')
