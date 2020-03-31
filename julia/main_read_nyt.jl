# main_julia_code_tester.jl
push!(LOAD_PATH, "/Users/carlosdeccia/Google Drive/_COVID/covid-19/julia")

using CodeDepositCorona
using Dates
using Plots

save_figs_folder = "figs/"
save_figs_folder_us_count = string(save_figs_folder,"us_county_timeline/")
save_figs_folder_us_rate = string(save_figs_folder,"us_county_rate_change/")


county_date_cal, county_string, county_state_string, county_fips_num, county_cases_num, county_deaths_num, state_date_cal, state_string, state_fips_num, state_cases_num, state_deaths_num= func_read_nyt()

county_datestrings = Dates.format.(county_date_cal, "u dd")
uni_county_string = unique(county_string)

# for idx_county = 1:length(uni_county_string)
#         idx_vec = findall(isequal(uni_county_string[idx_county]),county_string)
#
#         Data_entries = ["cases" "deaths"]
#         tmp_val = [county_cases_num[idx_vec] county_deaths_num[idx_vec]]
#         # timeline
#         plot(county_datestrings[idx_vec],tmp_val, xrotation=60, title=string(county_string[idx_vec[1]]," ",county_state_string[idx_vec[1]]), labels=Data_entries, legend=:topleft, dpi=300, show=true)
#         savefig(string(save_figs_folder_us_count, string(join(split(county_state_string[idx_vec[1]])),"_",join(split( county_string[idx_vec[1]]))),".png"))
#   println(idx_county-length(uni_county_string))
# end

delay_days = 7
for idx_c = 1:length(uni_county_string)
        idx_vec = findall(isequal(uni_county_string[idx_c]),county_string)

        timesteps = length(county_datestrings[idx_vec])
        rate_data = zeros(timesteps-delay_days)
        rate_data_new = zeros(timesteps-delay_days-1)
        tmp = county_cases_num[idx_vec]

        for i = timesteps-delay_days:-1:delay_days+1
            rate_data[i] = sum(tmp[i-delay_days:i])
        end
        for ii = 1:length(rate_data)-1
        rate_data_new[ii] = rate_data[ii+1] - rate_data[ii]
        end

        total_data = tmp[1:timesteps-delay_days-1]

        plot(total_data,rate_data_new, xscale = :log10, xlims = (1, 10^6), yscale = :log10, ylims = (1, 10^6), title=string(county_string[idx_vec[1]]," ",county_state_string[idx_vec[1]]), xlabel="Total cases [-]",  ylabel="Rate of cases [per $delay_days days]", dpi=300, show=true)
        savefig(string(save_figs_folder_us_rate, string(join(split(county_state_string[idx_vec[1]])),"_",join(split( county_string[idx_vec[1]]))),".png"))
        println(idx_c-length(uni_county_string))
end

# xticks = (1:3:timesteps, datestrings[1:3:timesteps]),
