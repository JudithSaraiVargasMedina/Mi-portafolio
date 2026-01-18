*****************************************************************************************
           *1. Hogares con acceso a TV de PAGA (en%)*
*****************************************************************************************
*TV de paga*
tab x1 [iw=fact_exp]
*Internet Fijo- Suma (1,3)*
tab t1 [iw=fact_exp]
*****************************************************************************************
           *2. Hogares con acceso a OTT empleando Internet fijo como soporte (en%)*
*****************************************************************************************
svyset [pweight=fact_exp], strata(estrato) psu(cong)
* Crear variable: hogares con OTT e internet fijo (t1 = 1 o 3)*
gen internet_fijo = inlist(t1, 1, 3) if !missing(t1)
*Restringir análisis solo a los hogares con IF*
gen ott_sobre_fijo = (t11 == 1) if internet_fijo == 1 & !missing(t11)
svy, subpop(internet_fijo): proportion ott_sobre_fijo
tab t11 if internet_fijo == 1 [iw=fact_exp]
*****************************************************************************************
     *3. Hogares con acceso a OTT de paga empleando Internet fijo como soporte (en%)*
*****************************************************************************************
svyset [pweight=fact_exp], strata(estrato) psu(cong)
gen ottpaga_sobre_fijo = (t11b == 1) if internet_fijo == 1 & !missing(t11)
svy, subpop(internet_fijo): proportion ottpaga_sobre_fijo
tab ottpaga_sobre_fijo if internet_fijo ==1 [iw=fact_exp]
*****************************************************************************************
           *4. Hogares con servicio de OTT y TV de Paga (en%)*
*****************************************************************************************
svyset [pweight=fact_exp], strata(estrato) psu(cong)
* Crear variable: hogares con OTT e internet fijo (t1 = 1 o 3)*
gen tiene_ott_fijo = (t11 == 1 & inlist(t1, 1, 3)) if inlist(t11, 1, 2) & inlist(t1, 1, 2, 3)
* Crear variable: tienen TV paga, entre los que tienen OTT e internet fijo*
gen tv_sobre_ott_fijo = (x1 == 1) if tiene_ott_fijo == 1 & inlist(x1, 1, 2)
svy, subpop(tiene_ott_fijo): proportion tv_sobre_ott_fijo

*****************************************************************************************
           *5. Dejar TV de Paga por OTT*
*****************************************************************************************
tab x30a [iw= fact_exp]
tab x30 if dominio == 11 [iw=fact_exp]

*NOTA: 2021, es:* tab x30 if dep_est ==26 [iw=fact_exp]
svyset [pweight=fact_exp], strata(estrato) psu(cong)

// Crear variable de convivencia
gen convivencia = .
replace convivencia = 1 if (x1 == 1 & ottpaga_sobre_fijo ==1) // TV paga y streaming (fija)
replace convivencia = 2 if (x1 == 2 & ottpaga_sobre_fijo ==1)// Solo streaming (fija)
replace convivencia = 3 if (x1 == 1 & t11 ==2) // Solo TV paga
replace convivencia = 4 if (x1 == 2 & t11 ==2) // Ninguno

// Etiquetas
label define convivencia ///
    1 "Televisión de paga y streaming (por conexión fija)" ///
    2 "Solo streaming (por conexión fija)" ///
    3 "Solo televisión de paga" ///
    4 "Ninguno"

tab convivencia [iw=fact_exp]


