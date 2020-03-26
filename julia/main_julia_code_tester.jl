# main_julia_code_tester.jl
push!(LOAD_PATH, "/Users/carlosdeccia/Google Drive/_COVID/covid-19/julia")

using CodeDepositCorona
using Dates

save_figs_folder = "figs/"
save_figs_folder_prov = string(save_figs_folder,"timeline_by_province_state/")
save_figs_folder_coun = string(save_figs_folder,"timeline_by_country/")

### Read in data
# setup = [Nr_entries_conf col_time_conf; Nr_entries_deat col_time_deat; Nr_entries_reco col_time_reco]
# conf_def   = [conf_Province_State conf_Countries conf_Lat conf_Lon]
# deat_def   = [deat_Province_State deat_Countries deat_Lat deat_Lon]
# reco_def   = [reco_Province_State reco_Countries reco_Lat reco_Lon]
# Province_State, Countries, Lat, Lon, Data_matrix_conf, Data_matrix_deat, Data_matrix_reco, Data_entries, TimeSteps, Nr_entries = func_read_in()
setup, timesteps, conf_def, deat_def, reco_def, Data_matrix_conf, Data_matrix_deat, Data_matrix_reco, Data_entries = func_read_in()

println("loading completed")

### Create date string for plots
calendar_date_start = Dates.DateTime(2020, 1, 22, 0, 0, 0)
julian_date_start = Dates.datetime2julian.(calendar_date_start)
calendar_date_end = Dates.julian2datetime(julian_date_start+timesteps-1) # to compensate for the first 5 columns
time_span_days = calendar_date_start:Dates.Day(1):calendar_date_end
datestrings = Dates.format.(time_span_days, "u dd")

###
# WARNING: Plot the maps or the timeline plots. Do NOT run them at the same time. The GMT and Plots packages conflict with each other!
# use flag_world_map for the maps OR plot_timelines for the timelines


### Plot world map
flag_world_map = false

if flag_world_map
    using GMT

    function findnonzero(c) #https://stackoverflow.com/questions/42232411/find-indices-of-non-zero-elements-from-1-2-0-0-4-0-in-julia-and-create-an-arrr
        a = similar(c, Int)
        count = 1
        @inbounds for i in eachindex(c)
            a[count] = i
            count += (c[i] != zero(eltype(c)))
        end
        return resize!(a, count-1)
    end

    # confirmed cases
    for i=1:timesteps #timesteps confirmed
        if sum(isnan.(Data_matrix_conf[:,i])) < 1
            date_tmp = datestrings[i]
            indx_nonzero = findnonzero(Data_matrix_conf[:,i])
            Lat = conf_def[:,3]
            Lon = conf_def[:,4]

            coast(region=:d, proj=:Robinson, frame="b", res=:crude, area=10000, land="#CEB9A0", borders="1", water=:lightblue, figsize=10)
            plot!(Lon[indx_nonzero], Lat[indx_nonzero], seriestype = :scatter, title="$date_tmp", fmt=:png, marker=:circle, markeredgecolor=:black, size=0.05, markerfacecolor=:red,  show=false)
            if i<10
                cp("/private/var/folders/m_/3xgqq6d56qx1fsmwntx74b5w0000gp/T/GMTjl_tmp.png","figs/map_global_confirmed/map_confirmed_0$i.png")
            else
                cp("/private/var/folders/m_/3xgqq6d56qx1fsmwntx74b5w0000gp/T/GMTjl_tmp.png","figs/map_global_confirmed/map_confirmed_$i.png")
            end
        end

    end

    # deaths
    for i=1:timesteps #timesteps deaths
        if sum(isnan.(Data_matrix_deat[:,i])) < 1
            date_tmp = datestrings[i]
            indx_nonzero = findnonzero(Data_matrix_deat[:,i])
            Lat = deat_def[:,3]
            Lon = deat_def[:,4]

            coast(region=:d, proj=:Robinson, frame="b", res=:crude, area=10000, land="#CEB9A0", borders="1", water=:lightblue, figsize=10)
            plot!(Lon[indx_nonzero], Lat[indx_nonzero], seriestype = :scatter, title="$date_tmp", fmt=:png, marker=:circle, markeredgecolor=:black, size=0.05, markerfacecolor=:red,  show=false)
            if i<10
                cp("/private/var/folders/m_/3xgqq6d56qx1fsmwntx74b5w0000gp/T/GMTjl_tmp.png","figs/map_global_deaths/map_deaths_0$i.png")
            else
                cp("/private/var/folders/m_/3xgqq6d56qx1fsmwntx74b5w0000gp/T/GMTjl_tmp.png","figs/map_global_deaths/map_deaths_$i.png")
            end
        end
    end

    # recovered
    for i=1:timesteps #timesteps recovered
        if sum(isnan.(Data_matrix_reco[:,i])) < 1
            date_tmp = datestrings[i]
            indx_nonzero = findnonzero(Data_matrix_reco[:,i])
            Lat = reco_def[:,3]
            Lon = reco_def[:,4]
            coast(region=:d, proj=:Robinson, frame="b", res=:crude, area=10000, land="#CEB9A0", borders="1", water=:lightblue, figsize=10)
            plot!(Lon[indx_nonzero], Lat[indx_nonzero], seriestype = :scatter, title="$date_tmp", fmt=:png, marker=:circle, markeredgecolor=:black, size=0.05, markerfacecolor=:red,  show=false)

            if i<10
                cp("/private/var/folders/m_/3xgqq6d56qx1fsmwntx74b5w0000gp/T/GMTjl_tmp.png","figs/map_global_recovered/map_recovered_0$i.png")
            else
                cp("/private/var/folders/m_/3xgqq6d56qx1fsmwntx74b5w0000gp/T/GMTjl_tmp.png","figs/map_global_recovered/map_recovered_$i.png")
            end

        end

    end

end

### TO DO: Create animation of the global map
# with circles that increase in size
#
### PLOT TIMELINES
plot_timelines = true

if plot_timelines
    using Plots
    ### Plot timeline by Province
    #  ...in progress
    # flag_timeline_prov = true
    # if flag_timeline_prov
    #     println("plotting... Province/State")
    #     conf_Province_State = conf_def[:,1]
    #     deat_Province_State = deat_def[:,1]
    #     reco_Province_State = reco_def[:,1]
    #     conf_Country = conf_def[:,2]
    #     deat_Country = deat_def[:,2]
    #     reco_Country = reco_def[:,2]
    #     provinces_unique = unique([unique(conf_Province_State); unique(deat_Province_State); unique(reco_Province_State)])
    #
    #     for idx_p = 2:length(provinces_unique)
    #         indx_tmp_conf = findall(isequal(provinces_unique[idx_p]),conf_Province_State)
    #         indx_tmp_deat = findall(isequal(provinces_unique[idx_p]),deat_Province_State)
    #         indx_tmp_reco = findall(isequal(provinces_unique[idx_p]),reco_Province_State)
    #
    #         tmp_prov = [Data_matrix_conf[indx_tmp_conf,:]', Data_matrix_deat[indx_tmp_deat,:]', Data_matrix_reco[indx_tmp_reco,:]']
    #             # tmp_prov = [Data_matrix_conf[indx_tmp_p,:]' Data_matrix_deat[indx_tmp_p,:]' Data_matrix_reco[indx_tmp_p,:]']
    #
    #             plot( 1:timesteps,tmp_prov, title=string("Country: ",Countries[indx_tmp_p][1],", Province/State: ",Province_State[indx_tmp_p][1]),  xlabel = "Days", xticks = (1:3:timesteps, datestrings[1:3:timesteps]), xrotation=60, ylabel="Number [-]", labels=Data_entries, legend=:topleft, show=true)
    #             country_idx = string( Countries[indx_tmp_p][1],"_", join(split(Province_State[indx_tmp_p][1])) )
    #             savefig(string(save_figs_folder_prov,country_idx,".pdf"))
    #     end
    # end


    ### Plot timeline by country
    flag_timeline_coun = true

    if flag_timeline_coun
        println("plotting... Countries")
        conf_Country = conf_def[:,2]
        deat_Country = deat_def[:,2]
        reco_Country = reco_def[:,2]
        countries_unique = unique([conf_Country; deat_Country; reco_Country])

        for idx_c=1:length(countries_unique)
            indx_tmp_c = findall(isequal(countries_unique[idx_c]),conf_Country)
            indx_tmp_d = findall(isequal(countries_unique[idx_c]),deat_Country)
            indx_tmp_r = findall(isequal(countries_unique[idx_c]),reco_Country)

            tmp_conf = sum(Data_matrix_conf[indx_tmp_c,:],dims = 1)
            tmp_deat = sum(Data_matrix_deat[indx_tmp_d,:],dims = 1)
            tmp_reco = sum(Data_matrix_reco[indx_tmp_r,:],dims = 1)
            tmp_coun = [tmp_conf'  tmp_deat' tmp_reco']

            plot( 1:timesteps,tmp_coun, title=string("Country: ",countries_unique[idx_c]), xticks = (1:3:timesteps, datestrings[1:3:timesteps]), xrotation=60, ylabel="Number of cases [-]", labels=Data_entries, legend=:topleft, show=true)
            savefig(string(save_figs_folder_coun, join(split(countries_unique[idx_c])),".pdf"))

        end
    end
    ### PLOT timeline globaly
    flag_timeline_glob = true

    if flag_timeline_glob
        println("plotting... Global")
        Data_matrix_conf, Data_matrix_deat, Data_matrix_reco

        global_conf = sum(Data_matrix_conf,dims=1)
        global_deat = sum(Data_matrix_deat,dims=1)
        global_reco = sum(Data_matrix_reco,dims=1)
        tmp_coun = [global_conf' global_deat' global_reco']
        max_value =  maximum(filter(!isnan,tmp_coun))

        plot( 1:timesteps,tmp_coun, title=string("Global situation"), yticks = (0:100000:max_value), xticks = (1:3:timesteps, datestrings[1:3:timesteps]), xrotation=60, ylabel="Number of cases [-]", labels=Data_entries, legend=:topleft, show=true)
        savefig(string(save_figs_folder,"timeline_global_confirmed_death_recovered.pdf"))
    end

end

println("done")

# Data_matrix_conf, Data_matrix_deat, Data_matrix_reco
