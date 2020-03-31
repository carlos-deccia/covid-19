# main_julia_code_tester_ITA.jl
push!(LOAD_PATH, "/Users/carlosdeccia/Google Drive/_COVID/covid-19/julia")

using CodeDepositCorona
using Dates
using Plots
save_figs_folder = "figs/"
save_figs_folder_reg = string(save_figs_folder,"ita_timeline_by_region/")
save_figs_folder_pro = string(save_figs_folder,"ita_timeline_by_province/")

### Read in data
naz_data, reg_data, pro_data = func_read_in_ita()

### Plot per region
flag_region_plot = true
if flag_region_plot
for ind_reg = 1:maximum(reg_data[:,2])
   ind_tmp = findall(isequal(ind_reg),reg_data[:,2])
   # constant definitions
   reg_dates_cal_vec               = reg_data[ind_tmp,1]
   reg_codice_regione              = reg_data[ind_tmp[1],2]
   reg_denominazione_regione       = reg_data[ind_tmp[1],3]
   reg_lat                         = reg_data[ind_tmp[1],4]
   reg_long                        = reg_data[ind_tmp[1],5]
   # data per region
   reg_ricoverati_con_sintomi      = reg_data[ind_tmp,6]
   reg_terapia_intensiva           = reg_data[ind_tmp,7]
   reg_totale_ospedalizzati        = reg_data[ind_tmp,8]
   reg_isolamento_domiciliare      = reg_data[ind_tmp,9]
   reg_totale_attualmente_positivi = reg_data[ind_tmp,10]
   reg_nuovi_attualmente_positivi  = reg_data[ind_tmp,11]
   reg_dimessi_guariti             = reg_data[ind_tmp,12]
   reg_deceduti                    = reg_data[ind_tmp,13]
   reg_totale_casi                 = reg_data[ind_tmp,14]
   reg_tamponi                     = reg_data[ind_tmp,15]

   reg_datestrings = Dates.format.(reg_dates_cal_vec, "dd u")
   timesteps = length(reg_dates_cal_vec)

   tmp_coun_over = [ reg_totale_attualmente_positivi reg_deceduti reg_dimessi_guariti ]
   Data_entries = ["Totale attualmente positivi" "Deceduti" "Dimessi guariti"]
   separation = round(maximum(tmp_coun_over),digits=-( ndigits(maximum(tmp_coun_over))-2 ))/5
   plot( 1:timesteps,tmp_coun_over, title=reg_denominazione_regione, yticks = (0:separation:maximum(tmp_coun_over)), xticks = (1:3:timesteps, reg_datestrings[1:3:timesteps]), xrotation=60, ylabel="Numero di casi [-]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
   savefig(string(save_figs_folder_reg,reg_denominazione_regione,"_overview.png"))

   tmp_coun_ther = [ reg_ricoverati_con_sintomi reg_terapia_intensiva reg_totale_ospedalizzati reg_isolamento_domiciliare reg_dimessi_guariti reg_deceduti ]
   Data_entries = ["Ricoverati con sintomi" "Terapia intensiva" "Totale ospedalizzati" "Isolamento domiciliare" "Dimessi guariti" "Deceduti" ]
   separation = round(maximum(tmp_coun_ther),digits=-( ndigits(maximum(tmp_coun_ther))-2 ))/5
   plot( 1:timesteps,tmp_coun_ther, title=reg_denominazione_regione, yticks = (0:separation:maximum(tmp_coun_ther)), xticks = (1:3:timesteps, reg_datestrings[1:3:timesteps]), xrotation=60, ylabel="Numero di casi [-]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
   savefig(string(save_figs_folder_reg,reg_denominazione_regione,"_therapy.png"))

   tmp_coun_rate = reg_nuovi_attualmente_positivi
   Data_entries = "Nuovi attualmente positivi"
   separation = round(maximum(tmp_coun_rate),digits=-( ndigits(maximum(tmp_coun_rate))-2 ))/5
   plot( 1:timesteps,tmp_coun_rate, title=reg_denominazione_regione, yticks = (0:separation:maximum(tmp_coun_rate)), xticks = (1:3:timesteps, reg_datestrings[1:3:timesteps]), xrotation=60, ylabel="Numero di casi [-]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
   savefig(string(save_figs_folder_reg,reg_denominazione_regione,"_rate_new_infections.png"))

end
end

### Plot per province
flag_province_plot = true
if flag_province_plot
for ind_pro = unique(pro_data[:,4])

   ind_tmp = findall(isequal(ind_pro),pro_data[:,4])

   # constant definitions
   pro_dates_cal_vec               = pro_data[ind_tmp,1]
   pro_codice_regione              = pro_data[ind_tmp[1],2]
   pro_denominazione_regione       = pro_data[ind_tmp[1],3]
   pro_codice_provincia            = pro_data[ind_tmp[1],4]
   pro_denominazione_provincia     = pro_data[ind_tmp[1],5]
   pro_sigla_provincia             = pro_data[ind_tmp[1],6]
   pro_lat                         = pro_data[ind_tmp[1],7]
   pro_lon                         = pro_data[ind_tmp[1],8]
   pro_totale                      = pro_data[ind_tmp,9]
   pro_datestrings = Dates.format.(pro_dates_cal_vec, "dd u")
   timesteps = length(pro_dates_cal_vec)

   pro_denominazione_provincia = replace(pro_denominazione_provincia, "In fase di definizione/aggiornamento" => "TBD")

   Data_entries = "Totale"
   separation = round(maximum(pro_totale),digits=-( ndigits(maximum(pro_totale))-2 ))/5

   # if pro_denominazione_provincia == "TBD"
   #    plot( 1:timesteps,pro_totale, title=string(pro_denominazione_regione," ",pro_denominazione_provincia), yticks = (0:separation:maximum(pro_totale)), xticks = (1:3:timesteps, pro_datestrings[1:3:timesteps]), xrotation=60, ylabel="Numero di casi [-]", labels=Data_entries, legend=:topleft, show=true)
   # else
   # println(ind_pro)
   if separation > 0
      plot( 1:timesteps,pro_totale, title=pro_denominazione_provincia, yticks = (0:separation:maximum(pro_totale)), xticks = (1:3:timesteps, pro_datestrings[1:3:timesteps]), xrotation=60, ylabel="Numero di casi [-]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
   else
      plot( 1:timesteps,pro_totale, title=pro_denominazione_provincia, xticks = (1:3:timesteps, pro_datestrings[1:3:timesteps]), xrotation=60, ylabel="Numero di casi [-]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
   end
   pro_denominazione_regione   = replace(pro_denominazione_regione, " " => "_")
   pro_denominazione_provincia = replace(pro_denominazione_provincia, " " => "_")

   savefig(string(save_figs_folder_pro,pro_denominazione_regione,"_",pro_denominazione_provincia,".png"))


end
end


## Plot for the whole nation
flag_nation_plot = true
if flag_nation_plot
naz_dates_cal_vec               = naz_data[:,1]
naz_ricoverati_con_sintomi      = naz_data[:,2]
naz_terapia_intensiva           = naz_data[:,3]
naz_totale_ospedalizzati        = naz_data[:,4]
naz_isolamento_domiciliare      = naz_data[:,5]
naz_totale_attualmente_positivi = naz_data[:,6]
naz_nuovi_attualmente_positivi  = naz_data[:,7]


naz_datestrings = Dates.format.(naz_dates_cal_vec, "dd u")
timesteps = length(naz_dates_cal_vec)

tmp_coun_ther = [ naz_ricoverati_con_sintomi naz_terapia_intensiva naz_totale_ospedalizzati naz_isolamento_domiciliare ]
Data_entries = ["Ricoverati con sintomi" "Terapia intensiva" "Totale ospedalizzati" "Isolamento domiciliare" ]
separation = round(maximum(tmp_coun_ther),digits=-( ndigits(maximum(tmp_coun_ther))-2 ))/5

plot( 1:timesteps,tmp_coun_ther, title="Italia", yticks = (0:separation:maximum(tmp_coun_ther)), xticks = (1:3:timesteps, naz_datestrings[1:3:timesteps]), xrotation=60, ylabel="Numero di casi [-]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
savefig(string(save_figs_folder,"ita_national_therapy.png"))

tmp_coun_rate = naz_nuovi_attualmente_positivi
Data_entries = "Nuovi attualmente positivi"
separation = round(maximum(tmp_coun_rate),digits=-( ndigits(maximum(tmp_coun_rate))-2 ))/5
plot( 1:timesteps,tmp_coun_rate, title="Italia", yticks = (0:separation:maximum(tmp_coun_rate)), xticks = (1:3:timesteps, naz_datestrings[1:3:timesteps]), xrotation=60, ylabel="Numero di casi [-]", labels=Data_entries, legend=:topleft, dpi=300, show=true)
savefig(string(save_figs_folder,"ita_national_rate_new_infections.png"))
end



## other things to plot
# LA
# NYC
# traffic accidents vs corona
# crime
# pollution
# world temperature changes
# reduction in STD

# re compute all plots by % of the population
# Get information of population numbers worldwide
