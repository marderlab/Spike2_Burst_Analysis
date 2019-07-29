function [ filedata ] = get_bursts( filename, progressflag )
% takes bursts from file produced by spike 2 scripts, computes things about them
% outputs data in a struct

if nargin<2
    progressflag=false;
end

filedata=struct();

fid=fopen(filename,'r');
text_array=textscan(fid,'%s','delimiter',',');
text_array=text_array{1};
burst_count=(length(text_array)/12);
bursts=zeros(burst_count,8);

howmany=length(text_array);

if (howmany<10000)
    progressflag=false;
end

if progressflag
    ProgressBar('Importing...',howmany);
end

for i=1:length(text_array)
    
    if progressflag
    ProgressBar('Importing...');
    end
    
    burst_num=floor(i/12)+1;
    data_field=rem(i,12);
    
    switch data_field;
        
        case 1
            
            file_string=text_array{i};

            numb='blank';
            this='blank';
            lastthis='blank';

            while(strcmp(numb,'blank'))

                [this, file_string]=strtok(file_string,'_');

                if (strcmp(this,''))
                    numb=lastthis;
                end

                lastthis=this;

            end

            bursts(burst_num,1)=str2double(numb);
        
        case 2
            
            bursts(burst_num,2)=str2double(text_array{i});
            
        case 3
            
            bursts(burst_num,3)=str2double(text_array{i});
            
        case 4
            
            bursts(burst_num,4)=str2double(text_array{i});
            
        case 5
            
            bursts(burst_num,5)=str2double(text_array{i});
            
        case 9
            
            bursts(burst_num,6)=str2double(text_array{i});
            
%         case 10
%             
%             bursts(burst_num,7)=str2double(text_array{i});
%             
%         case 11
%             
%             bursts(burst_num,8)=str2double(text_array{i});
%             
%         case 0
%             
%             bursts(burst_num-1,9)=str2double(text_array{i});
%                   
        
    end
    
end


bursts=flipud(bursts);

starts=bursts(:,4);
ends=bursts(:,5);

if (length(starts) < 3)
    hz=nan;
    duty=nan;
    duration=nan;
    anic=nan;
    
end

hz=zeros(length(starts)-1,1);
duty=zeros(length(starts)-1,1);
duration=zeros(length(starts),1);
anic=zeros(length(starts)-2,1);


for i=1:(length(starts)-1)
    
    hz(i)=1/(starts(i+1)-starts(i));
    
    duty(i)=(ends(i)-starts(i))/(starts(i+1)-starts(i));
    
    duration(i)=ends(i)-starts(i);

end

for i=1:(length(hz)-1)
    
    anic(i)= abs(hz(i+1)-hz(i)) / hz(i);
    
end


filedata.tstart=bursts(:,4);
filedata.tend=bursts(:,5);
filedata.hz=hz;
filedata.dutycycle=duty;
filedata.burstlength=duration;
filedata.anic=anic;
filedata.filenums=bursts(:,1);
filedata.spikecount=bursts(:,6);

end

