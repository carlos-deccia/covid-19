# main_julia_code_tester.jl
# https://github.com/nytimes/covid-19-data
push!(LOAD_PATH, "/Users/carlosdeccia/Google Drive/_COVID/covid-19/julia")

using CodeDepositCorona
using Dates
using Plots

save_figs_folder = "figs/"
save_figs_folder_us_count = string(save_figs_folder,"us_county_timeline/")
save_figs_folder_us_rate = string(save_figs_folder,"us_county_rate_change/")


county_date_cal, county_string, county_state_string, county_fips_num, county_cases_num, county_deaths_num, state_date_cal, state_string, state_fips_num, state_cases_num, state_deaths_num= func_read_nyt()

county_datestrings = Dates.format.(county_date_cal, "u dd")
county_timesteps_conf = length(unique(county_datestrings))
uni_county_string = unique(county_string)



# delay_days = 7
# for idx_c=1:length(uni_county_string)
#     # if occursin("Boulder",uni_county_string[idx_c]) || occursin("Los Angeles",uni_county_string[idx_c]) || occursin("New York City",uni_county_string[idx_c]) || occursin("Denver",uni_county_string[idx_c])
#
#         indx_tmp_c = findall(isequal(uni_county_string[idx_c]),county_string)
#
#         total_data = county_cases_num[indx_tmp_c]
#         county_timesteps_conf = county_datestrings[indx_tmp_c]
#         # total_data = sum(Data_matrix_conf[indx_tmp_c,1:county_timesteps_conf],dims=1)'
#         time_steps = length(county_timesteps_conf)
#         cases_tmp  = zeros(time_steps)
#         rate_data_new = zeros(time_steps-1)
#         for i = 1:time_steps
#             if i<7
#                 cases_tmp[i] = sum(total_data[1:i])
#             else
#                 cases_tmp[i] = sum(total_data[i-delay_days+1:i])
#             end
#         end
#         for ii = 2:length(cases_tmp)
#             rate_data_new[ii-1] = cases_tmp[ii] - cases_tmp[ii-1]
#         end
#
#         Data_entries = county_string[indx_tmp_c][1]
#         plot(total_data[2:end],rate_data_new, xscale = :log10, xlims = (1, 10^6), yscale = :log10, ylims = (1, 10^6), xlabel="Total cases [-]",  ylabel="Rate of cases [per $delay_days days]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
#
#         savefig(string(save_figs_folder_us_rate, string( join(split( Data_entries )) ),".png"))
#         println(idx_c-length(uni_county_string))
#     # end
# end

delay_days = 7
for idx_c=1:length(uni_county_string)
    if occursin("Boulder",uni_county_string[idx_c]) || occursin("Los Angeles",uni_county_string[idx_c]) || occursin("New York City",uni_county_string[idx_c]) || occursin("Denver",uni_county_string[idx_c]) || occursin("Detroit",uni_county_string[idx_c])

        indx_tmp_c = findall(isequal(uni_county_string[idx_c]),county_string)

        total_data = county_cases_num[indx_tmp_c]
        county_timesteps_conf = county_datestrings[indx_tmp_c]
        # total_data = sum(Data_matrix_conf[indx_tmp_c,1:county_timesteps_conf],dims=1)'
        time_steps = length(county_timesteps_conf)
        cases_tmp  = zeros(time_steps)
        rate_data_new = zeros(time_steps-1)
        for i = 1:time_steps
            if i<7
                cases_tmp[i] = sum(total_data[1:i])
            else
                cases_tmp[i] = sum(total_data[i-delay_days+1:i])
            end
        end
        for ii = 2:length(cases_tmp)
            rate_data_new[ii-1] = cases_tmp[ii] - cases_tmp[ii-1]
        end

        Data_entries = county_string[indx_tmp_c][1]
        plot!(total_data[2:end],rate_data_new, xscale = :log10, xlims = (1, 10^6), yscale = :log10, ylims = (1, 10^6), xlabel="Total cases [-]",  ylabel="Rate of cases [per $delay_days days]", labels=Data_entries, legend=:topleft, dpi=300, show=true)

        savefig(string(save_figs_folder_us_rate, "_sample.png"))
        println(idx_c-length(uni_county_string))
    end
end
