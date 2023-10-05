% extract_BOG_O2_data_Hirsh_2018.m


clear
close all



% link to key BOG fields:
% https://www3.mbari.org/bog/documents/BOG_CTD_Key_Fields.htm



select_str='SELECT cruise, date_time, seq, ctrb_id, depth, ';
parameter_str='tmp, sal, oxy_ml, alk, pH, no3, no2, sio4, po4, tco2 ';
from_str='FROM BCTD ';
criteria_str='WHERE ctrb_id in (''c1'',''mooring1'',''mooring2'') and depth<510 and year_date>2018000 and year_date<20190000 ';
order_str='ORDER by date_time, seq, depth; ';
%     concatenate strings
strsql=[select_str,parameter_str,from_str,criteria_str,order_str];
disp(['SQL string: ',strsql])


db = database('BOG', 'everyone', 'guest');
c = exec(db, strsql);
c = fetch(c);

% get the data
trex = c.Data;

close(c); 

% extract and rename it into something a bit easier

bog.site = trex(:,4);
bog.depth = cell2mat(trex(:,5));
bog.tc = cell2mat(trex(:,6));
bog.psal = cell2mat(trex(:,7));
bog.oxy_ml = cell2mat(trex(:,8));
bog.pH = cell2mat(trex(:,10)); % dont' know which conditions these are at
bog.ta = cell2mat(trex(:,9));
bog.dic = cell2mat(trex(:,15));

bog.dens = sw_dens(bog.psal, bog.tc, bog.depth);
bog.doxy = bog.oxy_ml .* 44.661 ./ (bog.dens./ 1000);

save('BOG_bottle_carbonO2_2018.mat', 'bog');




figure
hold on; box on;
plot(bog.doxy, bog.depth, 'ko');
set(gca, 'ydir', 'reverse');

figure
hold on; box on;
plot(bog.dens, bog.doxy, 'ko');











