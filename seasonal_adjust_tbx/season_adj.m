function x_dseason=season_adj(x,time_start)
% input= x: original series
%        time_start: string of start time
% output= x_dseason: seasonal ajusted data

% refference: 
% https://vermandel.fr/2022/12/30/deseasonalize-time-series-with-x13-in-matlab/

currentPath = pwd;
cd 'D:\MAT_Toolkits\seasonal_adjust_tbx\waste'

% load dseries object
get_dynare_src = strrep(which('dynare'),'dynare.m','');
addpath([get_dynare_src 'modules\dseries\src\'],[get_dynare_src 'missing\rows_columns\'])
initialize_dseries_class();

% convert original series into dseries object
xt = dseries(x,time_start);
% create the x13 object
o = x13(xt);

% create the x13 object
o = x13(xt);
% adjust options
o.transform('function','log');
%o.arima('model',' (0 1 1)12');
o.x11('save','(d10)');
% run
o.run();
% extract the multiplicative seasonal pattern
season_x = o.results.d10;
x_dseason= (o.y.data)./(season_x.data);
delete('*.*');

cd(currentPath);
end