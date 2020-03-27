function func_read_in_ita()

############################### read in data ###############################
saved_data_folder = "input/ITA_COVID-19-master/"


### Andamento nazionale
# **Directory:**  dati-andamento-nazionale<br>
# **Struttura file giornaliero:** dpc-covid19-ita-andamento-nazionale-yyyymmdd.csv (dpc-covid19-ita-andamento-nazionale-20200224.csv)<br>
# **File complessivo:** dpc-covid19-ita-andamento-nazionale.csv<br>
# **File ultimi dati (latest):** dpc-covid19-ita-regioni-latest.csv
#
#
# | Nome campo                  | Descrizione                       | Description                            | Formato                       | Esempio             |
# |-----------------------------|-----------------------------------|----------------------------------------|-------------------------------|---------------------|
# | **data**                        | Data dell’informazione            | Date of notification                   | YYYY-MM-DD HH:MM:SS (ISO 8601) Ora italiana | 2020-03-05 12:15:45 |
# | **stato**                       | Stato di riferimento              | Country of reference                   | XYZ (ISO 3166-1 alpha-3)      | ITA                 |
# | **ricoverati_con_sintomi**      | Ricoverati con sintomi            | Hospitalised patients with symptoms    | Numero                        | 3                   |
# | **terapia_intensiva**           | Ricoverati in terapia intensiva   | Intensive Care                         | Numero                        | 3                   |
# | **totale_ospedalizzati**        | Totale ospedalizzati              | Total hospitalised patients            | Numero                        | 3                   |
# | **isolamento_domiciliare**      | Persone in isolamento domiciliare | Home confinement                       | Numero                        | 3                   |
# | **totale_attualmente_positivi** | Totale attualmente positivi (ospedalizzati + isolamento domiciliare)      | Total amount of current positive cases (Hospitalised patients + Home confinement)  | Numero                        | 3                   |
# | **nuovi_attualmente_positivi**  | Nuovi attualmente positivi (ospedalizzati + isolamento domiciliare)       | News amount of current positive cases (Hospitalised patients + Home confinement)  | Numero                        | 3                   |
# | **dimessi_guariti**             | Persone dimesse guarite           | Recovered                              | Numero                        | 3                   |
# | **deceduti**                    | Persone decedute                  | Death                                  | Numero                        | 3                   |
# | **totale_casi**                 | Totale casi positivi              | Total amount of positive cases         | Numero                        | 3                   |
# | **tamponi**                     | Totale tamponi                    | Tests performed                        | Numero                        | 3                   |
#
# *Viene messo a disposizione un file JSON complessivo di tutte le date nella cartella "dati-json": dpc-covid19-ita-andamento-nazionale.json* e rispettivo file ultimi dati (latest) dpc-covid19-ita-andamento-nazionale-latest.json


    data_name_nazionale = string("dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale")
    myData_naz = CSV.read(string(saved_data_folder,data_name_nazionale, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)
    naz_dates_cal                   = myData_naz[:,1]
    naz_ricoverati_con_sintomi      = myData_naz[:,3]
    naz_terapia_intensiva           = myData_naz[:,4]
    naz_totale_ospedalizzati        = myData_naz[:,5]
    naz_isolamento_domiciliare      = myData_naz[:,6]
    naz_totale_attualmente_positivi = myData_naz[:,7]
    naz_nuovi_attualmente_positivi  = myData_naz[:,8]


#### Dati per Regione
# **Directory:**  dati-regioni<br>
# **Struttura file giornaliero:** dpc-covid19-ita-regioni-yyyymmdd.csv (dpc-covid19-ita-regioni-20200224.csv)<br>
# **File complessivo:** dpc-covid19-ita-regioni.csv<br>
# **File ultimi dati (latest):** dpc-covid19-ita-regioni-latest.csv
#
# | Nome campo                  | Descrizione                       | Description                            | Formato                       | Esempio             |
# |-----------------------------|-----------------------------------|----------------------------------------|-------------------------------|---------------------|
# | **data**                        | Data dell’informazione            | Date of notification                   | YYYY-MM-DD HH:MM:SS (ISO 8601) Ora italiana | 2020-03-05 12:15:45 |
# | **stato**                       | Stato di riferimento              | Country of reference                   | XYZ (ISO 3166-1 alpha-3)      | ITA                 |
# | **codice_regione**              | Codice della Regione (ISTAT 2019) | Code of the Region (ISTAT 2019)        | Numero                        | 13                  |
# | **denominazione_regione**       | Denominazione della Regione       | Name of the Region                     | Testo                         | Abruzzo             |
# | **lat**                         | Latitudine                        | Latitude                               | WGS84                         | 42.6589177          |
# | **long**                        | Longitudine                       | Longitude                              | WGS84                         | 13.70439971         |
# | **ricoverati_con_sintomi**      | Ricoverati con sintomi            | Hospitalised patients with symptoms    | Numero                        | 3                   |
# | **terapia_intensiva**           | Ricoverati in terapia intensiva   | Intensive Care                         | Numero                        | 3                   |
# | **totale_ospedalizzati**        | Totale ospedalizzati              | Total hospitalised patients            | Numero                        | 3                   |
# | **isolamento_domiciliare**      | Persone in isolamento domiciliare | Home confinement                       | Numero                        | 3                   |
# | **totale_attualmente_positivi** | Totale attualmente positivi (ospedalizzati + isolamento domiciliare)      | Total amount of current positive cases (Hospitalised patients + Home confinement)  | Numero                        | 3                   |
# | **nuovi_attualmente_positivi**  | Nuovi attualmente positivi (Totale attualmente positivi attuali - Totale attualmente positivi del giorno prima)       | News amount of current positive cases (Actual total amount of current positive cases - total amount of current positive cases of the previous day)  | Numero                        | 3                   |
# | **dimessi_guariti**             | Persone dimesse guarite           | Recovered                              | Numero                        | 3                   |
# | **deceduti**                    | Persone decedute                  | Death                                  | Numero                        | 3                   |
# | **totale_casi**                 | Totale casi positivi              | Total amount of positive cases         | Numero                        | 3                   |
# | **tamponi**                     | Totale tamponi                    | Tests performed                        | Numero                        | 3                   |
#
# *Le Province autonome di Trento e Bolzano sono indicate in "denominazione regione" e con il codice 04 del Trentino Alto Adige.*<br>
# *Viene messo a disposizione un file JSON complessivo di tutte le date nella cartella "dati-json": dpc-covid19-ita-regioni.json* e rispettivo file ultimi dati (latest) dpc-covid19-ita-regioni-latest.json


    data_name_regioni = string("dati-regioni/dpc-covid19-ita-regioni")
    myData_reg = CSV.read(string(saved_data_folder,data_name_regioni, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)
    reg_dates_cal                   = myData_reg[:,1]
    reg_codice_regione              = myData_reg[:,3]
    reg_denominazione_regione       = myData_reg[:,4]
    reg_lat                         = myData_reg[:,5]
    reg_long                        = myData_reg[:,6]
    reg_ricoverati_con_sintomi      = myData_reg[:,7]
    reg_terapia_intensiva           = myData_reg[:,8]
    reg_totale_ospedalizzati        = myData_reg[:,9]
    reg_isolamento_domiciliare      = myData_reg[:,10]
    reg_totale_attualmente_positivi = myData_reg[:,11]
    reg_nuovi_attualmente_positivi  = myData_reg[:,12]
    reg_dimessi_guariti             = myData_reg[:,13]
    reg_deceduti                    = myData_reg[:,14]
    reg_totale_casi                 = myData_reg[:,15]
    reg_tamponi                     = myData_reg[:,16]
    # reg_note_it                     = myData_reg[:,17]
    # reg_note_en                     = myData_reg[:,18]


### Dati per Provincia
# **Directory:**  dati-province<br>
# **Struttura file giornaliero:** dpc-covid19-ita-province-yyyymmdd.csv (dpc-covid19-ita-province-20200224.csv)<br>
# **File complessivo:** dpc-covid19-ita-province.csv<br>
# **File ultimi dati (latest):** dpc-covid19-ita-province-latest.csv
#
# | Nome campo              | Descrizione                         | Description                     | Formato            | Esempio              |
# |-------------------------|-------------------------------------|---------------------------------|--------------------|----------------------|
# | **data**                    | Data dell’informazione              | Date of notification            | YYYY-MM-DD HH:MM:SS (ISO 8601) Ora italiana           | 2020-03-05 12:15:45 |                   |
# | **stato**                   | Stato di riferimento                | Country of reference            | ISO 3166-1 alpha-3 | ITA                  |
# | **codice_regione**          | Codice della Regione (ISTAT 2019)   | Code of the Region (ISTAT 2019) | Numero             | 13                   |
# | **denominazione_regione**   | Denominazione della Regione         | Name of the Region              | Testo              | Abruzzo              |
# | **codice_provincia**        | Codice della Provincia (ISTAT 2019) | Code of the Province            | Numero             | 067                  |
# | **denominazione_provincia** | Denominazione della provincia       | Name of the Province            | Testo              | Teramo               |
# | **sigla_provincia**         | Sigla della Provincia               | Province abbreviation           | Testo              | TE                   |
# | **lat**                     | Latitudine                          | Latitude                        | WGS84              | 42.6589177           |
# | **long**                    | Longitudine                         | Longitude                       | WGS84              | 13.70439971          |
# | **totale_casi**             | Totale casi positivi                | Total amount of positive cases  | Numero             | 3                    |
#
# *Le Province autonome di Trento e Bolzano sono indicate in "denominazione regione" e con il codice 04 del Trentino Alto Adige.*<br>
# *Ogni Regione ha una Provincia denominata "In fase di definizione/aggiornamento" con il codice provincia da 979 a 999, utile ad indicare i dati ancora non assegnati alle Province.*<br>
# *Viene messo a disposizione un file JSON complessivo di tutte le date nella cartella "dati-json": dpc-covid19-ita-province.json* e rispettivo file ultimi dati (latest) dpc-covid19-ita-province-latest.json


    data_name_province = string("dati-province/dpc-covid19-ita-province")
    myData_pro = CSV.read(string(saved_data_folder,data_name_province, ".csv"); delim=',', missingstring="NA", decimal='.', copycols=true)
    pro_dates_cal                   = myData_pro[:,1]
    pro_codice_regione              = myData_pro[:,3]
    pro_denominazione_regione       = myData_pro[:,4]
    pro_codice_provincia            = myData_pro[:,5]
    pro_denominazione_provincia     = myData_pro[:,6]
    pro_sigla_provincia             = myData_pro[:,7]
    pro_lat                         = myData_pro[:,8]
    pro_long                        = myData_pro[:,9]
    pro_totale                      = myData_pro[:,10]
    # pro_note_it                     = myData_pro[:,10]
    # pro_note_en                     = myData_pro[:,11]


naz_data = [naz_dates_cal naz_ricoverati_con_sintomi naz_terapia_intensiva naz_totale_ospedalizzati naz_isolamento_domiciliare naz_totale_attualmente_positivi naz_nuovi_attualmente_positivi ]
reg_data = [reg_dates_cal reg_codice_regione reg_denominazione_regione reg_lat reg_long reg_ricoverati_con_sintomi reg_terapia_intensiva reg_totale_ospedalizzati reg_isolamento_domiciliare reg_totale_attualmente_positivi reg_nuovi_attualmente_positivi reg_dimessi_guariti reg_deceduti reg_totale_casi reg_tamponi]
pro_data = [pro_dates_cal pro_codice_regione pro_denominazione_regione pro_codice_provincia pro_denominazione_provincia pro_sigla_provincia pro_lat pro_long pro_totale]

return naz_data, reg_data, pro_data

end
