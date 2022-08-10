neigh_ccc
neigh_sna
neigh_cchmc

neighs <- mapview::mapview(neigh_ccc, col.regions = "red", legend = FALSE) +
  mapview::mapview(neigh_sna, col.regions = "blue", legend = FALSE) +
  mapview::mapview(neigh_cchmc, col.regions = "green", legend = FALSE)

# do we expect users to convert neighborhood data to other neighborhoods? These are all
# different, but usually only slightly... would end up with very small weights in a
# lot of cases
