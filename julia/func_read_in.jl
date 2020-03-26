
###  REQUIRED MODULES ###
# using CSV
#########################


function func_read_in()

    ###############################################################################

    ############################### read in data ###############################
    # save_data_folder = "COVID-19-master/csse_covid_19_data/csse_covid_19_time_series/"
    save_data_folder = "input/COVID-19-master/csse_covid_19_data/csse_covid_19_time_series/"
    data_name_conf = string("time_series_covid19_confirmed_global")
    data_name_deat = string("time_series_covid19_deaths_global")
    data_name_reco = string("time_series_covid19_recovered_global")


    myData_conf = CSV.read(string(save_data_folder,data_name_conf, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)
    myData_deat = CSV.read(string(save_data_folder,data_name_deat, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)
    myData_reco = CSV.read(string(save_data_folder,data_name_reco, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)

    #############################################################################

    Nr_entries_conf , col_time_conf  = size(myData_conf)
    Nr_entries_deat , col_time_deat  = size(myData_deat)
    Nr_entries_reco , col_time_reco  = size(myData_reco)
    # TimeSteps = col_time_conf-4
    times_steps = [col_time_conf col_time_deat col_time_reco]
    timesteps = maximum(times_steps)-4

    Data_matrix_conf = NaN*ones(Nr_entries_conf,timesteps)
    Data_matrix_deat = NaN*ones(Nr_entries_deat,timesteps)
    Data_matrix_reco = NaN*ones(Nr_entries_reco,timesteps)

    conf_Province_State = myData_conf[!,1]
    conf_Countries 	    = myData_conf[!,2]
    conf_Lat 		    = myData_conf[!,3]
    conf_Lon 		    = myData_conf[!,4]

    deat_Province_State = myData_deat[!,1]
    deat_Countries 	    = myData_deat[!,2]
    deat_Lat 		    = myData_deat[!,3]
    deat_Lon 		    = myData_deat[!,4]

    reco_Province_State = myData_reco[!,1]
    reco_Countries 	    = myData_reco[!,2]
    reco_Lat 		    = myData_reco[!,3]
    reco_Lon 		    = myData_reco[!,4]


    for i=1:Nr_entries_conf
        for j=5:col_time_conf
            Data_matrix_conf[i,j-4] = myData_conf[i,j]
        end
    end
    for i=1:Nr_entries_deat
        for j=5:col_time_deat
            Data_matrix_deat[i,j-4] = myData_deat[i,j]
        end
    end
    for i=1:Nr_entries_reco
        for j=5:col_time_reco
            Data_matrix_reco[i,j-4] = myData_reco[i,j]
        end
    end

    Data_entries = ["Confirmed" "Deaths" "Recovered"]


    setup = [Nr_entries_conf Nr_entries_deat Nr_entries_reco]
    conf_def   = [conf_Province_State conf_Countries conf_Lat conf_Lon]
    deat_def   = [deat_Province_State deat_Countries deat_Lat deat_Lon]
    reco_def   = [reco_Province_State reco_Countries reco_Lat reco_Lon]


    return setup, timesteps, conf_def, deat_def, reco_def, Data_matrix_conf, Data_matrix_deat, Data_matrix_reco, Data_entries

end
