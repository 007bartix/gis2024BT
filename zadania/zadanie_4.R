library("terra")
#granice_powiatow = vect("D:/Studia_xD/Rok4/ZAP/03Wektor/06_GraniceAdministracyjne/A02_Granice_powiatow.shp")
granice_powiatow = vect("D:/Studia_xD/Rok4/ZAP/03Wektor/granice/powiaty.shp")
dataframe=as.data.frame(granice_powiatow)
plot(granice_powiatow)

centroidy <- centroids(granice_powiatow)
plot(centroidy, add=TRUE)
#points(centroidy, col = "red", pch = 19, cex = 0.6)

#Sposob 1
odleglosci <- distance(centroidy)
odleglosci
macierz_odleglosci = as.matrix(odleglosci)
macierz_odleglosci[1:5, 1:5]
#Sposob 2
odleglosci <- distance(centroidy,centroidy)

#Przekątna macierzy
diag(odleglosci) = NA
diag(macierz_odleglosci)=NA

najblizszy_index <- which(odleglosci == min(odleglosci,na.rm=TRUE), arr.ind = TRUE)
najdalszy_index <- which(odleglosci == max(odleglosci, na.rm=TRUE), arr.ind = TRUE)

# Wydrukuj wyniki
najblizszy_powiat <- najblizszy_index[, "row"]
najdalszy_powiat <- najdalszy_index[, "row"]

colnames(macierz_odleglosci) = rownames(macierz_odleglosci) = centroidy$JPT_NAZWA_
#View(macierz_odleglosci) # wyświetl

cat("Najbliższy powiat:", rownames(macierz_odleglosci)[najblizszy_index[1,]], "\n")
cat("Najdalszy powiat:", rownames(macierz_odleglosci)[najdalszy_index[1,]], "\n")
points(centroidy[najdalszy_index], col = "red", pch = 20, cex = 1)
points(centroidy[najblizszy_index], col = "green", pch = 20, cex = 0.8)

