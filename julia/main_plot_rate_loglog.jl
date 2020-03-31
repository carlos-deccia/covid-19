# main_julia_code_tester.jl
push!(LOAD_PATH, "/Users/carlosdeccia/Google Drive/_COVID/covid-19/julia")

using CodeDepositCorona
using Dates
using Plots

save_figs_folder = "figs/"


### Read in data
setup, timesteps, conf_def, deat_def, reco_def, Data_matrix_conf, Data_matrix_deat, Data_matrix_reco, Data_entries = func_read_in()
println("loading completed")

### Create date string for plots
calendar_date_start = Dates.DateTime(2020, 1, 22, 0, 0, 0)
julian_date_start = Dates.datetime2julian.(calendar_date_start)
calendar_date_end = Dates.julian2datetime(julian_date_start+timesteps-1) # to compensate for the first 5 columns
time_span_days = calendar_date_start:Dates.Day(1):calendar_date_end
datestrings = Dates.format.(time_span_days, "u dd")

conf_Country = conf_def[:,2]
countries_unique = unique(conf_def[:,2])
###
global_rate_CITUU_7days = true
if global_rate_CITUU_7days
delay_days = 7
for idx_c = 1:length(countries_unique)
    if occursin("China",countries_unique[idx_c]) || occursin("Italy",countries_unique[idx_c]) || occursin("Spain",countries_unique[idx_c]) || occursin("Turkey",countries_unique[idx_c]) || occursin("Uruguay",countries_unique[idx_c]) || occursin("US",countries_unique[idx_c])
        indx_tmp_c = findall(isequal(countries_unique[idx_c]),conf_Country)
# countries_unique[78]

        rate_data = zeros(timesteps-delay_days)
        rate_data_new = zeros(timesteps-delay_days-1)
        for i = timesteps-delay_days:-1:delay_days+1
            rate_data[i] = sum(Data_matrix_conf[indx_tmp_c,i-delay_days:i])
        end
        for ii = 1:length(rate_data)-1
        rate_data_new[ii] = rate_data[ii+1] - rate_data[ii]
        end

        total_data = zeros(timesteps)
        for i=1:timesteps
            total_data[i] = sum(Data_matrix_conf[indx_tmp_c,1:i])
        end

        Data_entries = countries_unique[idx_c]
        plot!(total_data[delay_days+2:timesteps],rate_data_new, xscale = :log10, xlims = (10, 10^7), yscale = :log10, ylims = (1, 10^6), xlabel="Total cases [-]",  ylabel="Rate of cases [per 3 days]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
    end
end
savefig(string(save_figs_folder,"global_rate_CISTUU_7days.png"))
end
###
#
global_rate_CITUU_3days = false
if global_rate_CITUU_3days
delay_days = 3
for idx_c = 1:length(countries_unique)
    if occursin("China",countries_unique[idx_c]) || occursin("Italy",countries_unique[idx_c]) || occursin("Spain",countries_unique[idx_c]) || occursin("Turkey",countries_unique[idx_c]) || occursin("Uruguay",countries_unique[idx_c]) || occursin("US",countries_unique[idx_c])
        indx_tmp_c = findall(isequal(countries_unique[idx_c]),conf_Country)
# countries_unique[78]

        rate_data = zeros(timesteps-delay_days)
        rate_data_new = zeros(timesteps-delay_days-1)
        for i = timesteps-delay_days:-1:delay_days+1
            rate_data[i] = sum(Data_matrix_conf[indx_tmp_c,i-delay_days:i])
        end
        for ii = 1:length(rate_data)-1
        rate_data_new[ii] = rate_data[ii+1] - rate_data[ii]
        end

        total_data = zeros(timesteps)
        for i=1:timesteps
            total_data[i] = sum(Data_matrix_conf[indx_tmp_c,1:i])
        end

        Data_entries = countries_unique[idx_c]
        plot!(total_data[delay_days+2:timesteps],rate_data_new, xscale = :log10, xlims = (10, 10^7), yscale = :log10, ylims = (1, 10^6), xlabel="Total cases [-]",  ylabel="Rate of cases [per 3 days]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
    end
end
savefig(string(save_figs_folder,"global_rate_CISTUU_3days.png"))
end
#
