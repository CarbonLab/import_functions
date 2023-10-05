%% Accessing the BOG Database

clear;close all;clc

bpath = '/Users/fassbender/Documents/OneDrive_MBARIalias/MATLAB/Organic_Alkalinity';
% cd(bpath)

%% Create a connection to the database

    %conn = database('jdbc:jtds:sqlserver://solstice.shore.mbari.org/BOG', 'everyone', 'guest')
    conn = database('jdbc:jtds:sqlserver://perseus.shore.mbari.org/BOG', 'everyone', 'guest')


    %% See what carbon data are availble...

    %Collect multiple variables from a cruise
    data = jdbcquery(conn, 'SELECT ALK, year_date, pH, TCO2, dec_lat, dec_long, DEPTH FROM BCTD WHERE YEAR_DATE > 2011001');

time = num2str(data.year_date);
yr = str2num(time(:,1:4));
uyr = unique(yr);
d = str2num(time(:,5:6));
[date] = doy2date(d,yr);

depth = data.DEPTH;
lat = data.dec_lat;
lon = data.dec_long;
ta = data.ALK;
x = find(ta<1000);
ta(x)=NaN;

figure(2);clf
col = colormap(jet(length(uyr)));
for i = 1:length(uyr)
    z = find(uyr(i)==yr);
    subplot(131)
    plot(date(z),ta(z),'.','color',col(i,:));hold on
    subplot(132)
    plot(ta(z), -depth(z),'ok','markerfacecolor',col(i,:));hold on
    subplot(133)
    if i==1
        m_proj('lambert','long',[228 262],'lat',[12 39]);
    end
    [X,Y]=m_ll2xy(360+lon(z),lat(z));
    plot(X,Y,'*','color',col(i,:));hold on
    if i==length(uyr)
        set(gca,'fontsize',13);grid off;title('Coastal Cruises','fontsize',14)
        m_gshhs_l('patch',[0.7 0.7 0.7],'edgecolor','k'); hold on
        m_grid('box','fancy','tickdir','in');grid off
    end
end
subplot(131)
ylabel('TA (\mumol kg^{-1})')
datetick('x','yyyy')
subplot(132)
xlabel('TA (\mumol kg^{-1})');ylabel('Depth (m)');ylim([-1000 0])
title('TA Profiles Colored by Year')
subplot(133)
title('Sample Stations')

%%


data = jdbcquery(conn, 'SELECT pco2 FROM UNDERWAY WHERE YEAR_DATE > 2018001');


%pseudocode:
%structure = jdbcquery(conn, ?SELECT variable1, variable2, varbiable3 FROM table WHERE define restriction)


%%
% ? Example queries:
 
% Query single record
a = jdbcquery(conn, 'SELECT expedition_id, expd, seq, project FROM EXPEDITION WHERE expedition_id=13619')
% This is creating a structure ?a? that includes the variables: expedition_id, 
% expd, seq, and project, which are located under the table EXPEDITION. Only data 
% from the expedition_id ?13619? will be included

% Query a ton of records
b = jdbcquery(conn, 'SELECT expedition_id, expd, seq, project FROM EXPEDITION')
% This creates a structure ?b? with the same variables as ?a?, however now all 
% the expedition_id are included
 
% Customize filenames in Matlab's data structure
b = jdbcquery(conn, 'SELECT expedition_id AS id, expd AS expedition, seq AS divenumber, project FROM EXPEDITION')
% This will collect the same variables as above into a structure ?b?, and
% rename them
 
% Collect specific data in time
data = jdbcquery(conn, 'SELECT SAL FROM PCTD WHERE YEAR_DATE > 2018050');
% Pull all salinity data from the Profiling CTD down casts (PCTD) after 2018 050
Salinity = data.SAL
 
%Collect multiple variables from a cruise
data = jdbcquery(conn, 'SELECT SAL, TMP, CHLA, DEPTH FROM PCTD WHERE cruise = insert cruise name');
 
%pseudocode:
%structure = jdbcquery(conn, ?SELECT variable1, variable2, varbiable3 FROM table WHERE define restriction)

