

###  REQUIRED MODULES ###
# using GMT
#########################

function func_plot_global(Lon, Lat, flag)

	# # ###############################################################################
	# # plot on map - OPTIONAL
	# plotting_requested_flag = flag[1]
	# plot_flag_Robinson = flag[2]
	# plot_flag_globe = flag[3]

	if flag
		# if plot_flag_globe
		# coast(region=[0 360 -90 90], proj=(name=:laea, center=(300,30)), frame=:g,
		#       res=:crude, land=:navy, figsize=6)
		# end
		# if plot_flag_Robinson
		coast(region=:d, proj=:Robinson, frame="b", res=:crude, area=10000, land="#CEB9A0", borders="1",
					water=:lightblue, figsize=10)
		# end
		plot!(Lon, Lat, fmt=:png, marker=:circle, markeredgecolor=:black, size=0.05, markerfacecolor=:red, show=true)
	end
	# # ###############################################################################

end
