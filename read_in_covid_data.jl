
############################ MODULES ##########################################
using CSV            #
using GMT
###############################################################################

############################### read in data ###############################
save_data_folder = "COVID-19-master/csse_covid_19_data/csse_covid_19_time_series/"
data_name_conf = string("time_series_19-covid-Confirmed")
data_name_deat = string("time_series_19-covid-Deaths")
data_name_reco = string("time_series_19-covid-Recovered")


myData_conf = CSV.read(string(save_data_folder,data_name_conf, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)
# myData_deat = CSV.read(string(save_data_folder,data_name_deat, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)
# myData_reco = CSV.read(string(save_data_folder,data_name_reco, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)

#############################################################################

rows_entries , col_time  = size(myData_conf)
Ntime_elements = col_time-4
Time_matrix = zeros(rows_entries,Ntime_elements)

Province_State = myData_conf[!,1]
Countries 	   = myData_conf[!,2]
Lat 		   = myData_conf[!,3]
Lon 		   = myData_conf[!,4]

for i=1:rows_entries
    for j=5:col_time
        Time_matrix[i,j-4] = myData_conf[i,j]
    end
end


# ###############################################################################
# # plot on map - OPTIONAL
plotting_requested_flag = false
plot_flag_Robinson = false
plot_flag_globe = true

if plotting_requested_flag
	if plot_flag_globe
	coast(region=[0 360 -90 90], proj=(name=:laea, center=(300,30)), frame=:g,
	      res=:crude, land=:navy, figsize=6)
	end
	if plot_flag_Robinson
	coast(region=:d, proj=:Robinson, frame="b", res=:crude, area=10000, land="#CEB9A0", borders="1",
				water=:lightblue, figsize=10)
	end
	plot!(Lon, Lat, fmt=:png, marker=:circle, markeredgecolor=:black, size=0.05, markerfacecolor=:red, show=true)
end
# ###############################################################################


irow = 1
Time_matrix[irow,:]

plot(1:Ntime_elements,Time_matrix[irow,:])


# plot(Lon, Lat, lw=0.1, lc=:red, fmt=:png, marker=:circle, markeredgecolor=0, size=0.0005, markerfacecolor=:red, show=true)



# basemap(region=(2000,2020,35,45), frame=(axes=:S, annot=2, ticks=:auto, slanted=-30),
#         fmt=:png, show=true)
