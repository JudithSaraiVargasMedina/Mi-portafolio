* Subgrupo: hogares con TV de paga y respondieron 3,4,5 en x30
gen tv_paga_y_no_dejan_contenido = (x1 == 1 & inlist(x30, 3, 4, 5)) if !missing(x1, x30, x30a)
// 1. Diseño muestral (si ya lo hiciste antes, sáltalo)
svyset [pw=fact_exp], psu(conglomerado) strata(estrato)

// 2. Crear variables
gen tiene_tv_paga = x1 == 1
gen respondio_x30a = inrange(x30a,1,5)  // considerar válidas las 5 opciones
gen dispuesto_cambiar = inlist(x30a,1,2) if respondio_x30a

// 3. Crear subgrupo de interés
gen universo_osiptel = tiene_tv_paga & respondio_x30a

// 4. Estimar proporción de dispuestos a cambiar
svy, subpop(universo_osiptel): proportion dispuesto_cambiar



*Hogares con acceso a OTT empleando Internet fijo como soporte (en%)*
svyset [pweight=fact_exp], strata(estrato) psu(cong)
gen internet_fijo = inlist(t1, 1, 3) if !missing(t1)
*Restringir análisis solo a los hogares con IF*
gen ott_sobre_fijo = (t11 == 1) if internet_fijo == 1 & !missing(t11)
svy, subpop(internetw_fijo): proportion ott_sobre_fijo

* S7.11. ¿En su hogar usan algún servicio especializado de Internet tipo Netflix,*
tab t11 [iw= fact_exp]
*DISPOSICION DE DEJAR TV DE PAGA POR OTT*
* Configurar encuesta
svyset [pweight=fact_exp], strata(estrato) psu(cong)

* Hogares con TV de paga
gen tvpaga = (x1 == 1) if inlist(x1, 1, 2)

* Dispuestos a cambiar por OTT (1 o 2 en x30)
gen dispuestos_x30 = inlist(x30, 1, 2) if inlist(x30, 1, 2, 3, 4, 5)

* Proporción entre quienes tienen TV paga
svy, subpop(tvpaga): proportion dispuestos_x30
 
 
 
* Disposición de dejar la TV de Paga por OTT (sobre la base de la pregunta: ¿Dejaría el servicio de Televisión de Paga, si todas las empresas operadoras suben en 10% el precio de este 33 servicio,………...? ---->S9.30a. Si todas las empresas de televisión de paga suben en 10% el precio de es desde 2021*
tab x30a [iw= fact_exp]


*TV PAGA Y OTT*

* 1. Configurar el diseño muestral
svyset [pweight=fact_exp], strata(estrato) psu(cong)

* 2. Crear variable auxiliar: hogares con OTT e internet fijo (t1 = 1 o 3)
gen tiene_ott_fijo = (t11 == 1 & inlist(t1, 1, 3)) if inlist(t11, 1, 2) & inlist(t1, 1, 2, 3)

* 3. Crear variable de interés: tienen TV paga, entre los que tienen OTT e internet fijo
gen tv_sobre_ott_fijo = (x1 == 1) if tiene_ott_fijo == 1 & inlist(x1, 1, 2)

* 4. Estimar proporción de hogares con OTT + internet fijo que también tienen TV paga
svy, subpop(tiene_ott_fijo): proportion tv_sobre_ott_fijo

