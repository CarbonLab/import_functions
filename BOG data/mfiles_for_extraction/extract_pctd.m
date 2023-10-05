% extract bottle data from the BOG database table PCTD
% for pctd fields see https://mww.mbari.org/bog/documents/new_users.htm#_Toc424970311
% 2019 April rpm
close all; reload=1;
tic
if reload
    clear all
%     sql strings that make up a query. be sure to leave a blank at the end
%     of each string as these are concatenated. if you do not and the
%     strings run together, i.e. tmp, sal, oxy_ml, alk, pH, no3, no2, sio4,
%     po4, tco2from pctd you will blow the compiler's mind.
    select_str='SELECT cruise, date_time, seq, ctrb_id, depth, ';
    parameter_str='tmp, sal, oxy_ml  ';
    from_str='FROM pctd ';
    criteria_str='WHERE ctrb_id in (''c1'',''mooring1'',''h3'',''67-50'',''mooring2'',''67-55'') and depth<210 and year_date>2019000 ';
    order_str='ORDER by date_time, seq, depth; ';
%     concatenate strings
    strsql=[select_str,parameter_str,from_str,criteria_str,order_str];
    disp(['SQL string: ',strsql])
    % submit query string to the BOG database
    % errors can occur here if there is a problem with the query string
    p=bogquery(strsql);
    
end

if numel(p.cruise)>0
% do something with the data contained in the structure p. 
disp([num2str(numel(p.cruise)),' records extracted.'])
sdn=p.date_time;

else
    disp(['Error no records were extracted'])
end %if numel(p.cruise)>0

disp('extract_pctd finished.')
toc