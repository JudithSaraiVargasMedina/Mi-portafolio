
cd "Mi ruta"

use "enaho01a-2024-400.dta", clear

gen       tuvo_ps=.
replace   tuvo_ps=1 if p4025==0
label var tuvo_ps "Algún problema de salud"

gen double gto01=0
gen double gto02=0
gen double gto03=0
gen double gto04=0
gen double gto05=0
gen double gto06=0
gen double gto07=0
gen double gto08=0
gen double gto09=0
gen double gto10=0
gen double gto11=0
gen double gto12=0
gen double gto13=0
gen double gto14=0
gen double gto15=0
gen double gto16=0
replace gto01=i41601 if p4151_01==1 
replace gto02=i41602 if p4151_02==1 
replace gto03=i41603 if p4151_03==1 
replace gto04=i41604 if p4151_04==1 
replace gto05=i41605 if p4151_05==1 
replace gto06=i41606 if p4151_06==1 
replace gto07=i41607 if p4151_07==1 
replace gto08=i41608 if p4151_08==1 
replace gto09=i41609 if p4151_09==1 
replace gto10=i41610 if p4151_10==1 
replace gto11=i41611 if p4151_11==1 
replace gto12=i41612 if p4151_12==1 
replace gto13=i41613 if p4151_13==1 
replace gto14=i41614 if p4151_14==1 
replace gto15=i41615 if p4151_15==1 
replace gto16=i41616 if p4151_16==1 


egen    gto_usu=rowtotal(gto01 gto02 gto03 gto04 gto05 gto06 gto07 gto08 gto09 gto10 gto11 gto12 gto13 gto14 gto15 gto16)
egen    gto_consulta=rowtotal(gto01)



gen dpto= real(substr(ubigeo,1,2))

label define dpto 1"Amazonas" 2"Ancash" 3"Apurimac" 4"Arequipa" 5"Ayacucho" 6"Cajamarca" 7"Callao" 8"Cusco" 9"Huancavelica" 10"Huanuco" 11"Ica" /*
*/12"Junin" 13"La Libertad" 14"Lambayeque" 15"Lima*" 26"Lima provincias" 16"Loreto" 17"Madre de Dios" 18"Moquegua" 19"Pasco" 20"Piura" 21"Puno" 22"San Martin" /*
*/23"Tacna" 24"Tumbes" 25"Ucayali" 

label values dpto dpto

*******************************************************************
*************Denominador: total de la población********************
table dpto  [iw=factor07] , c(mean gto_usu) format(%12.6f) row
table dpto  [iw=factor07],  c(mean gto_consulta) format(%12.6f) row
********************************************************************
************Denominador: personas que gastaron en salud*************
********************************************************************
table dpto  [iw=factor07] if gto_usu>0 , c(mean gto_usu) format(%12.6f) row
table dpto  [iw=factor07] if gto_consulta>0 , c(mean gto_consulta) format(%12.6f) row









