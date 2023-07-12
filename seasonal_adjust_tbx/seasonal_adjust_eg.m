%% 
% load Airline data
clc,clear;
load Data_Airline;

get_dynare_src = strrep(which('dynare'),'dynare.m','');
% load dseries object
addpath([get_dynare_src 'modules\dseries\src\'],[get_dynare_src 'missing\rows_columns\'])
initialize_dseries_class();
% convert data into dseries object
ts = dseries(Data,'1949M1');

% create the x13 object
o = x13(ts);
% adjust options
o.transform('function','log');
o.arima('model',' (0 1 1)12');
o.x11('save','(d10)');
% run
o.run();
% extract the multiplicative seasonal pattern
season_y = o.results.d10;

% display results
figure;
plot(dates,o.y.data,dates,(o.y.data)./(season_y.data))
xlim([min(dates),max(dates)])
datetick('x','mm-yyyy','keeplimits')
grid on;


