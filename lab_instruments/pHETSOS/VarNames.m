function [Vars,package] = VarNames(filename)

str = fileread(filename);
Pmfet = contains(str,'MFET') && ~contains(str,'NanoFET');
Pmfet_nano = contains(str,'MFET') && contains(str,'NanoFET');
Pmphox = contains(str,'MpHOx') && ~contains(str,'BEAMS');
Pbeams = contains(str,'BEAMS');

package = [Pmfet, Pmfet_nano, Pmphox, Pbeams];

if Pmfet == 1
    Vars = {
        'SampNum1','SampTime1','VbatMain1','VbatPos1','VbatNeg1',...
        'TC_Cont1','Humidity1','Vrse1','Vrse_std1','Vk1','Vk_std1',...
        'Ik1','Ib1'};
    % formatspec = {' '}; % This could work with textscan?
elseif Pmfet_nano == 1
    Vars = {
        'SampNum1','SampTime1','VbatMain1','VbatPos1','VbatNeg1',...
        'TC_Cont1','Humidity1','Vrse1','Vrse_std1','Vk1','Vk_std1',...
        'Ik1','Ib1','SampNum2','SampTime2','VBiasPos2','Vrse2',...
        'Vrse_std2','Vk2','Vk_std2','Ik2','Ib2'};
elseif Pmphox == 1
    Vars = {
        'SampNum1','SampTime1','VbatMain1','VbatPos1',...
        'TC_Cont1','Humidity1','Vtherm','Vtherm_std','TC_Dfet','Vrse1',...
        'Vrse_std1','pHextEst','Vk1','Vk_std1','Ik1','Ib1','Opt_PN',...
        'Opt_SN','Moxy','O2satper','TC_opt','Dphase','Bphase','Rphase',...
        'Bamp','Bpot','Ramp','Opt_rawtemp','TC_MCat','Cond','Pres',...
        'pSal','Date_MC','Time_MC'};
elseif Pbeams == 1
        Vars = {'SampNum1','SampTime1','VbatMain1','VbiasPos','VbiasNeg',...
       	'TC_cont','Humidity','Vrse1','Vrse_std1','Vk1','Vk_std1','Ik1','Ib1',...
    	'Opt_PN','Opt_SN','Moxy','O2satper','TC_opt','Dphase','Bphase',...
    	'Rphase','Bamp','Bpot','Ramp','Opt_rawtemp','TC_MCat',...
        'Cond','Pres','pSal','Date_MC','Time_MC','Pump'};
end

end