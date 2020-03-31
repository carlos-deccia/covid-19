# func_read_nyt.jl
function func_read_nyt()
    save_data_folder = "input/nyt_covid-19-data-master/"
    data_us_counties = string("us-counties")
    data_us_states = string("us-states")


    myData_count = CSV.read(string(save_data_folder,data_us_counties, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)
    myData_state = CSV.read(string(save_data_folder,data_us_states, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)


    county_date_cal      = myData_count[:,1]
    county_string        = myData_count[:,2]
    county_state_string  = myData_count[:,3]
    county_fips_num      = myData_count[:,4]
    county_cases_num     = myData_count[:,5]
    county_deaths_num    = myData_count[:,6]

    state_date_cal       = myData_state[:,1]
    state_string         = myData_state[:,2]
    state_fips_num       = myData_state[:,3]
    state_cases_num      = myData_state[:,4]
    state_deaths_num     = myData_state[:,5]

return county_date_cal, county_string, county_state_string, county_fips_num, county_cases_num, county_deaths_num, state_date_cal, state_string, state_fips_num, state_cases_num, state_deaths_num
end
