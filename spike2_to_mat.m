% Converts Spike2 file to data file used by matlab. Must use Spike2
% continuously with 2 min. files. Must change n_conds to reflect the number
% of files analyzed by Spike2.

%clear all

clear pd lp py directory

% Point to directory where Spike2 analysis occurred
directory=uigetdir(); % get directory

file_search = strcat(directory, '/*', '.abf');
files=dir(file_search);
n_conds = length(files);
%n_conds = 13;

%get filename data for different neurons
pd_data = dir(strcat(directory,'/*PD*.txt'));
py_data = dir(strcat(directory,'/*PY*.txt'));
lp_data = dir(strcat(directory,'/*LP*.txt'));

%load data from Spike2 .txt to matlab
pd1=get_bursts(strcat(directory,'/',pd_data(1).name));
lp1=get_bursts(strcat(directory,'/',lp_data(1).name));
py1=get_bursts(strcat(directory,'/',py_data(1).name));

%Use if Spike2 analysis started back at zero at some point
%add_time

%120s/file
chunks = 0*60:2*60:n_conds*2*60;
%chunks(12:end) = chunks(12:end) + 3266-1440+120;

%separate data by time
%discard 1st and last burst of file for calculations
for i = 1:(length(chunks)-1)
    block = pd1.tstart >= chunks(i) & pd1.tend < chunks(i+1);
    place_hold = pd1.hz.*block(1:(end-1));
    pd.freq{1,i} = place_hold(place_hold~= 0);
    pd.freq_m(i,1) = mean(pd.freq{i}(2:end-1));
    place_hold = pd1.tstart.*block;
    pd.start{1,i} = place_hold(place_hold~= 0);
    place_hold = pd1.tend.*block;
    pd.end{1,i} = place_hold(place_hold~= 0);
    pd.period{1,i}=pd.start{i}(3:(end-1))-pd.start{i}(2:(end-2));
    pd.period_m(i,1) = mean(pd.period{1,i});
    place_hold = pd1.burstlength.*block;
    pd.burst_length{1,i} = place_hold(place_hold~= 0);
    pd.burst_length_m(i,1) = mean(pd.burst_length{i}(2:end-1));
    place_hold = pd1.dutycycle.*block(1:(end-1));
    pd.duty_cycle{1,i} = place_hold(place_hold~= 0);
    pd.duty_cycle_m(i,1) = mean(pd.duty_cycle{i}(2:end-1));
    place_hold = pd1.spikecount.*block;
    pd.spike_count{1,i} = place_hold(place_hold~= 0);
    pd.spike_count_m(i,1) = mean(pd.spike_count{i}(2:end-1));

    for j=1:(length(pd.start{1,i})-3)
        pd.cycle_end{1,i}(j)=(pd.end{1,i}(j)-pd.start{1,i}(j))./pd.period{1,i}(j);
    end
    
    if isnan(pd.freq_m(i,1))==0
        pd.cycle_end_m(i,1)=mean(pd.cycle_end{1,i}(2:end-1));
        pd.cycle_end_std(i,1)=std(pd.cycle_end{1,i}(2:end-1));
    end
    
    
    
    block = lp1.tstart >= chunks(i) & lp1.tend < chunks(i+1);
    place_hold = lp1.hz.*block(1:(end-1));
    lp.freq{1,i} = place_hold(place_hold~= 0);
    lp.freq_m(i,1) = mean(lp.freq{i}(2:end-1));
    place_hold = lp1.tstart.*block;
    lp.start{1,i} = place_hold(place_hold~= 0);
    place_hold = lp1.tend.*block;
    lp.end{1,i} = place_hold(place_hold~= 0);
    place_hold = lp1.burstlength.*block;
    lp.burst_length{1,i} = place_hold(place_hold~= 0);
    lp.burst_length_m(i,1) = mean(lp.burst_length{i}(2:end-1));
    place_hold = lp1.dutycycle.*block(1:(end-1));
    lp.duty_cycle{1,i} = place_hold(place_hold~= 0);
    lp.duty_cycle_m(i,1) = mean(lp.duty_cycle{i}(2:end-1));
    place_hold = lp1.spikecount.*block;
    lp.spike_count{1,i} = place_hold(place_hold~= 0);
    lp.spike_count_m(i,1) = mean(lp.spike_count{i}(2:end-1));
    
    %Set starts and stops relative to pd_start
    k=1;
    for j=1:length(lp.start{1,i})-3
        
        if lp.start{1,i}(j)<pd.start{1,i}(k)
            continue
        end
        
        while lp.start{1,i}(j)>pd.start{1,i}(k)
            
            if (k+1)>length(pd.start{1,i})
                j=j-1;
                continue
            end
            
            if lp.start{1,i}(j)<pd.start{1,i}(k+1) && k <= length(pd.period{1,i})                                                                                                                                                            
            lp.cycle_start{1,i}(j)=(lp.start{1,i}(j)-pd.start{1,i}(k))/pd.period{1,i}(k);
            lp.cycle_end{1,i}(j)=(lp.end{1,i}(j)-pd.start{1,i}(k))/pd.period{1,i}(k);
            end
            k=k+1;
        end
    end
    if isnan(lp.freq_m(i,1))==0
        lp.cycle_start_m(i,1)=mean(lp.cycle_start{1,i}(2:end-1));
        lp.cycle_end_m(i,1)=mean(lp.cycle_end{1,i}(2:end-1));
        lp.cycle_start_std(i,1)=std(lp.cycle_start{1,i}(2:end-1));
        lp.cycle_end_std(i,1)=std(lp.cycle_end{1,i}(2:end-1));
    end
    
    
    block = py1.tstart >= chunks(i) & py1.tend < chunks(i+1);
    place_hold = py1.hz.*block(1:(end-1));
    py.freq{1,i} = place_hold(place_hold~= 0);
    py.freq_m(i,1) = mean(py.freq{i}(2:end-1));
    place_hold = py1.tstart.*block;
    py.start{1,i} = place_hold(place_hold~= 0);
    place_hold = py1.tend.*block;
    py.end{1,i} = place_hold(place_hold~= 0);
    place_hold = py1.burstlength.*block;
    py.burst_length{1,i} = place_hold(place_hold~= 0);
    py.burst_length_m(i,1) = mean(py.burst_length{i}(2:end-1));
    place_hold = py1.dutycycle.*block(1:(end-1));
    py.duty_cycle{1,i} = place_hold(place_hold~= 0);
    py.duty_cycle_m(i,1) = mean(py.duty_cycle{i}(2:end-1));
    place_hold = py1.spikecount.*block;
    py.spike_count{1,i} = place_hold(place_hold~= 0);
    py.spike_count_m(i,1) = mean(py.spike_count{i}(2:end-1));
    
        %Set starts and stops relative to pd_start
    k=1;
    for j=1:length(py.start{1,i})-3

        if py.start{1,i}(j)<pd.start{1,i}(k)
            continue
        end
        
        while py.start{1,i}(j)>pd.start{1,i}(k)
            
            if (k+1)>length(pd.start{1,i})
                j=j-1;
                continue
            end
            
            if py.start{1,i}(j)<pd.start{1,i}(k+1) && k <= length(pd.period{1,i})                                                                                                                                                               
            py.cycle_start{1,i}(j)=(py.start{1,i}(j)-pd.start{1,i}(k))/pd.period{1,i}(k);
            py.cycle_end{1,i}(j)=(py.end{1,i}(j)-pd.start{1,i}(k))/pd.period{1,i}(k);
            
            %To eliminate multiple bursts in one cycle
            if py.cycle_end{1,i}(j)<.3
                py.cycle_start{1,i}(j)=0;
                py.cycle_end{1,i}(j)=0;
                k=k-1;
                j=j+1;
            end
                
            end
            k=k+1;
        end
    end
    
    if isnan(py.freq_m(i,1))==0
        py.cycle_start_m(i,1)=mean(py.cycle_start{1,i}(2:end-1));
        py.cycle_end_m(i,1)=mean(py.cycle_end{1,i}(2:end-1));
        py.cycle_start_std(i,1)=std(py.cycle_start{1,i}(2:end-1));
        py.cycle_end_std(i,1)=std(py.cycle_end{1,i}(2:end-1));
    end
    
    
end

%Calculate freq cv, discarding 1st and last burst of file
for i = 1:(length(pd.freq))
pd.cv(i,1) = std(pd.freq{1,i}(2:(end-1)))/mean(pd.freq{1,i}(2:(end-1)));
end

% %save data
Bursts=strcat(directory, '/', pd_data.name(1:8), 'Bursts.mat');
save(Bursts,'pd','lp','py')

% par_name = strcat(directory, '/', 'par_as.mat');
% save(par_name,'data')

%In case a different file structure is needed for adding files to 
%main file structure
% d = pd;
% p = lp;
% y = py;
% 
% extra=strcat(directory, '/', pd_data.name(1:8), 'Bursts.mat');
% save(extra,'d','p','y')
