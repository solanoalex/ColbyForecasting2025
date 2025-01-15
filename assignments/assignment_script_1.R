DB = brickman_database()

db = DB |> dplyr::filter(scenario == "RCP45", year == "2055", interval == "mon")

rcp45_sst = read_brickman(db)

buoys = gom_buoys()

gom_buoys()

buoy_m01 = buoys |> slice(5)

buoy_m01

long_values = extract_brickman(rcp45_sst, buoy_m01)

long_values

data_rcp = long_values |> dplyr::filter(name == "SST")



plot(data_rcp$value)

data_rcp |>
  ggplot(mapping=aes(factor(month, month.abb), value)) +
  geom_point() +
  labs(x="Month", y = "SST (C)", title = "RCP4.5 2055 SST at buoy M01")