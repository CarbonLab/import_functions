% extract bottle data from the BOG database table BCTD
% for bctd fields see https://mww.mbari.org/bog/documents/new_users.htm#_Toc424970308
% 2019 April rpm
close all; reload=1;
if reload
    clear all
%     sql strings that make up a query. be sure to leave a blank at the end
%     of each string as these are concatenated. if you do not and the
%     strings run together, i.e. tmp, sal, oxy_ml, alk, pH, no3, no2, sio4,
%     po4, tco2from BCTD you will blow the compiler's mind.
    select_str='SELECT cruise, date_time, seq, ctrb_id, depth, ';
    parameter_str='tmp, sal, oxy_ml, alk, pH, no3, no2, sio4, po4, tco2 chl_gff';
    from_str='FROM BCTD ';
    criteria_str='WHERE ctrb_id in (''c1'',''mooring1'',''h3'',''67-50'',''mooring2'',''67-55'') and depth<10 and year_date>2014000 ';
    order_str='ORDER by date_time, seq, depth; '
%     concatenate strings
    strsql=[select_str,parameter_str,from_str,criteria_str,order_str];
    disp(['SQL string: ',strsql])
    % submit query string to the BOG database
    % errors can occur here if there is a problem with the query string
    b=bogquery(strsql);
    
end

if numel(b.cruise)>0
% do something with the data contained in the structure b. 
disp([num2str(numel(b.cruise)),' records extracted.'])
sdn=b.date_time;

else
    disp(['Error no records were extracted'])
end %if numel(b.cruise)>0

disp('extract_bctd finished.')