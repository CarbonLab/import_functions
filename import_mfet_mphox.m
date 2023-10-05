function [data,meta] = import_mfet_mphox(filepath)
%
%
% function m = import_mfet_mphox(filepath)
%
% saves a data, and meta structure
%
% data as a timetable
%
% Yui Takeshita
% MBARI
% Created 3/23/2022
% clear all; close all
% filepath = '/Volumes/CarbonLab/jacki/OCR testing/jsl01.txt';
% filepath = 'C:\Users\yui\Dropbox\Deep_sea_respirometer_barry\Test_cruise_March_2022\raw_data\control2.txt';
% 
% filepath = 'C:\Users\yui\Dropbox\Durafet_calibration\k2\SW\test_and_dev\test_no_discrete\M09R0308.txt';

fid = fopen(filepath);


% row number counter

%% extract headers/meta data

% decoder table for variable name in text file, to metadata name in matlab

mkey = {
    'Firmware version: ',       'firmware_version'
    'Sampling period (s)',      'sampling_freq'
    'Samples hour align:',      'align_to_hour'
    'Pump on time (s):',        'pump_on_sec'
    'Low battery voltage:',     'low_batt_volt'
    'Output mode:        ',     'output_mode'
    'Deploy time:   ',          'time_deployed'
    'Pump start:   ',           'pump_start'
    'Time zone:       ',        'time_zone'
    'TCOffset:     '            'dura_temp_offset'
    'k0int:        ',           'k0int'
    'k0ext:        ',           'k0ext'
    'k2int:        ',           'k2int'
    'k2ext:        ',           'k2ext'
    'Def Sal (ppt):',           'Default_psal'
    'Offset Ik:    ',           'Ik_offset'
    'S-H c0        ',           'SH_c0'
    'S-H c1        ',           'SH_c1'
    'S-H c2        ',           'SH_c2'
    'S-H c3        ',           'SH_c3'
    'Version Info: ',           'VersionInfo'            
    'File name:     ',          'filename'
    'User initials: ',          'user_initials'
    'Board SN:      ',          'board_sn'
    'MCAP SN:       ',          'mcap_sn'
    'DuraFET SN:    ',          'dura_sn'
    'Optode SN:     ',          'optode_sn'
    'CTD SN:        ',          'ctd_sn'
    'Pump SN:       ',          'pump_sn'
    'Package name:  ',          'package_name'
    'Fab Note:      ',          'fab_note'
    'Deploy note:   ',          'deploy_note'};
    
    
% get each line, and save the metadata variable
rownum = 0;

while(1)
    
    % increment row counter; needed for the readtable command.
    rownum = rownum+1;
    
    % get line without line termination character
    trex = fgetl(fid);
    
    % Skip starting empty lines 
    if(~isempty(trex))
        % Skip header declaraiton line
        if(~strcmp(trex(1:4),'//++'))
            
            % termination condition
            if(strcmp(trex(1:4),'//--'))
                break;
            end   
            
            % if it got here, means it has metadata. 
            
            % First, cut off the first three characters: '//\s'
            trex = trex(4:end);
            % metadata is separated by tab. deployment variable settings
            % are not. So use the size of textscan to identify which line
            % is what.
            trex = textscan(trex, '%s', 'delimiter', '\t');
            trex = trex{1}; 
            
            % See if the variable is in the metakey table
            if(~isempty(find(ismember(mkey(:,1),trex{1}),1)))
                % it is included. extract varname in matlab
                varname = mkey{strcmp(mkey(:,1),trex{1}),2};
                
                % if nothing was entered, then the variable value will be
                % empty. deal with this case.
                if(length(trex)==1)
                    meta.(varname) = ''; % empty 
                else
                    % look up metaname 
                    meta.(varname) = trex{2};
                end
                    
            else
%               deployment variable line. Initialize variable if it doesn't
%               exist
                if(~isfield(meta, 'dep_params'))
                    meta.dep_params = [];
                end
                
                % just keep appending to dep_params field.
                meta.dep_params = [meta.dep_params, trex{1},newline];
            end
            
            clear trex

        end
    end
    
end

% there are different number of lines after headers and data depending on
% version, so deal with that. they should be blank lines.
% 
while(isempty(fgetl(fid)))
    rownum = rownum+1;
end
% 
% % at this point rownum should equal headerlines for readtable
fclose(fid);
% 
% % read data as a table
data = readtable(filepath,'headerlines', rownum, 'delimiter', '\t');
% 
% % rename MM_DD_YYYYHH_MM_SS to DT (datetime)
















