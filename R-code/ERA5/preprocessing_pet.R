library(terra)

# Load the original ERA5 dataset
era5 <- rast("era5_data/era5_tp_daily_quebec.nc")

# Load PET datasets for 1981 and 1982 and combine
pet <- lapply(1981:2023, function(x) {
  rast(paste0("pet_data/", x, "_daily_pet_quebec.nc"))})
pet_combined <- do.call("c", pet)
rm(pet)

# Resample PET to match the resolution and extent of ERA5 using bilinear interpolation
pet_resampled <- resample(pet_combined, era5, method = "bilinear")

era5
pet_combined
pet_resampled

# Save the resampled PET data to a new NetCDF file
writeCDF(pet_resampled, "pet_data/daily_pet_quebec_combined.nc", varname = "pet")
















