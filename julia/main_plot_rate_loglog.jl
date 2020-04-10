# main_julia_code_tester.jl
# https://github.com/CSSEGISandData/COVID-19
push!(LOAD_PATH, "/Users/carlosdeccia/Google Drive/_COVID/covid-19/julia")

using CodeDepositCorona
using Dates
using Plots

save_figs_folder = "figs/"


### Read in data
setup, conf_def, deat_def, reco_def, Data_matrix_conf, Data_matrix_deat, Data_matrix_reco, Data_entries = func_read_in()
println("loading completed")

timesteps_conf = setup[4]
### Create date string for plots
calendar_date_start = Dates.DateTime(2020, 1, 22, 0, 0, 0)
julian_date_start   = Dates.datetime2julian.(calendar_date_start)
calendar_date_end   = Dates.julian2datetime(julian_date_start+timesteps_conf-1) # to compensate for the first 5 columns
time_span_days      = calendar_date_start:Dates.Day(1):calendar_date_end
datestrings         = Dates.format.(time_span_days, "u dd")

conf_Country        = conf_def[:,2]
conf_Country_unique = unique(conf_def[:,2])
###



global_rate_CITUU_7days = true
if global_rate_CITUU_7days
delay_days = 7
for idx_c = 1:length(conf_Country_unique)
    if occursin("China",conf_Country_unique[idx_c]) || occursin("Italy",conf_Country_unique[idx_c]) || occursin("France",conf_Country_unique[idx_c]) || occursin("Netherlands",conf_Country_unique[idx_c]) || occursin("Spain",conf_Country_unique[idx_c]) || occursin("Korea, South",conf_Country_unique[idx_c]) || occursin("Turkey",conf_Country_unique[idx_c]) || occursin("Uruguay",conf_Country_unique[idx_c]) || occursin("US",conf_Country_unique[idx_c])

        indx_tmp_c = findall(isequal(conf_Country_unique[idx_c]),conf_Country)

        total_data = sum(Data_matrix_conf[indx_tmp_c,1:timesteps_conf],dims=1)'
        cases_tmp  = zeros(timesteps_conf)
        rate_data_new = zeros(timesteps_conf-1)
        for i = 1:timesteps_conf
            if i<7
                cases_tmp[i] = sum(total_data[1:i])
            else
                cases_tmp[i] = sum(total_data[i-delay_days+1:i])
            end
        end
        for ii = 2:length(cases_tmp)
            rate_data_new[ii-1] = cases_tmp[ii] - cases_tmp[ii-1]
        end

        Country_entries = conf_Country_unique[idx_c]
        # println(Country_entries)
        # plot!(total_data[2:end],rate_data_new, xscale = :log10, xlims = (1, 10^6), yscale = :log10, ylims = (1, 10^6), xlabel="Total cases [-]",  ylabel="Rate of cases [per $delay_days days]", labels=Country_entries, legend=:topleft, dpi=300, show=true)
        plot!(total_data[2:end],rate_data_new, xscale = :log10, xlims = (1, 10^6), yscale = :log10, ylims = (1, 10^6), xlabel="Total cases [-]",  ylabel="Rate of cases [per $delay_days days]", legend=false, dpi=300, show=true)
        annotate!(total_data[end],rate_data_new[end], Plots.text(Country_entries, 5, :black, :top, :left))
    end
end
savefig(string(save_figs_folder,"global_rate_CISTUU_$delay_days","days.png"))
end

global_rate_CITUU_3days = false
if global_rate_CITUU_3days
delay_days = 3
for idx_c = 1:length(conf_Country_unique)
    if occursin("China",conf_Country_unique[idx_c]) || occursin("Italy",conf_Country_unique[idx_c]) || occursin("France",conf_Country_unique[idx_c]) || occursin("Spain",conf_Country_unique[idx_c]) || occursin("Korea, South",conf_Country_unique[idx_c]) || occursin("Turkey",conf_Country_unique[idx_c]) || occursin("Uruguay",conf_Country_unique[idx_c]) || occursin("US",conf_Country_unique[idx_c])

        indx_tmp_c = findall(isequal(conf_Country_unique[idx_c]),conf_Country)

        total_data = sum(Data_matrix_conf[indx_tmp_c,1:timesteps_conf],dims=1)'
        cases_tmp  = zeros(timesteps_conf)
        rate_data_new = zeros(timesteps_conf-1)
        for i = 1:timesteps_conf
            if i<7
                cases_tmp[i] = sum(total_data[1:i])
            else
                cases_tmp[i] = sum(total_data[i-delay_days+1:i])
            end
        end
        for ii = 2:length(cases_tmp)
            rate_data_new[ii-1] = cases_tmp[ii] - cases_tmp[ii-1]
        end

        Data_entries = conf_Country_unique[idx_c]
        plot!(total_data[2:end],rate_data_new, xscale = :log10, xlims = (1, 10^6), yscale = :log10, ylims = (1, 10^6), xlabel="Total cases [-]",  ylabel="Rate of cases [per $delay_days days]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
    end
end
savefig(string(save_figs_folder,"global_rate_CISTUU_$delay_days","days.png"))
end

# USE DEATH RATE - wHATS the difference?
# create simple stupid html js website that takes the julia data
