function distribution(T)
%  create histograms of each parameter
%  saves each to file
excel_Table = 'table.xlsx';
summary = table;
num = 1;
numBins = 20;
name = regexprep(excel_Table,'.xlsx','');

while num < width(T)+1
    if sum(~isnan(T{:,num})) > 1
        % Probability density function automatically fitted by MATLAB
        pd = fitdist(T{:,num},'Normal');

        % Plot the data as a histogram
        figure;
        histfit(T{:,num},numBins,'normal');
        xlabel(T.Properties.VariableNames{num},'interpreter','none')
        ylabel('Count');
        figname = strcat(T.Properties.VariableNames{num},' distribution.jpg');
        saveas(gcf,figname);

        % Create new column in summary table
        summary(:,num) = num2cell([pd.mu; pd.sigma]);
        num = num+1;
    else
        num = num+1;
    end
end
summary.Properties.VariableNames = {'original_2D_int','fitted_2D1_int','fitted_2D2_int',...
    'original_G_int','fitted_G_int','original_D_int','fitted_D_int','Dpr_int',...
	'twoD1_area','twoD2_area','G_area','D_area','Dpr_area','original_2D_freq',...
    'fitted_2D1_freq','fitted_2D2_freq','original_G_freq','fitted_G_freq',...
    'original_D_freq','fitted_D_freq','Dpr_freq','twoD1_FWHM','twoD2_FWHM',...
    'G_FWHM','D_FWHM','Dpr_FWHM','original_2D_offset','fitted_2D1_offset',...
	'fitted_2D2_offset','original_G_offset','fitted_G_offset','original_D_offset',...
    'fitted_D_offset','Dpr_offset',...
    'I2D_IG','ID_IG','IDpr_IG','ID_IDpr','A2D_AG','AD_AG','ADpr_AG',...
    'L_a','n_d','L_d'};


summary.Properties.RowNames = {'Mean','Sigma'};
writetable(summary,strcat(name,' summary.xlsx'),'WriteRowNames',true);
end