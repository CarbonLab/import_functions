

% run this script to download data from BOG to be used for spray validation/calibration.


    select_str='SELECT cruise, date_time, seq, ctrb_id, depth, ';
    parameter_str='pressure tmp, sal, oxy_ml, alk, pH, no3, no2, sio4, po4, tco2, chl_gff ';
    from_str='FROM BCTD ';
    criteria_str='WHERE ctrb_id in (''c1'',''mooring1'',''h3'',''67-50'',''mooring2'',''67-55'') and depth<500 and year_date>2014000 ';
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






