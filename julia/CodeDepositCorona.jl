






#Module for a collection of generally useful functions.

#Declare module name:
module CodeDepositCorona

    # #List of functions exported by this module:
    export func_read_in
    export func_read_in_ita

    #List of Julia scripts included in this module:
    include("func_read_in.jl")
    include("func_read_in_ita.jl")


    # Modules used by func_read_in
    using CSV            #
    # Modules used by func_plot_global
    # using GMT

end
