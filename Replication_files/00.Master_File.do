*** Stata 17
*** Master file to replicate "Employment and Wages over the Business Cycle in Worker-Owned Firms: Evidence from Spain" by Jose Garcia-Louzao



clear all
capture log close
capture program drop _all
macro drop _all
set more 1
set seed 13
set cformat %5.4f

** Set main directory
global path "{Replication_files}" // main directory here but recall one needs to have the sub-folders within the diretory, i.e., do_files, dta_files, cohorts_2018, tables, figures
cd ${path}

** Installation of external programs required for estimation or saving results

* ftools (remove program if it existed previously)
ssc install ftools, replace
ssc install gtools, all replace

* reghdfe 
ssc install reghdfe, replace

* ivreghdfe 
ssc install ivreg2, replace // the core package ivreg2 is required
ssc install ivreghdfe, replace

* outreg 
ssc install outreg2, replace


** Routines to obtain the final results 
*  routines should be stored in ${path}\do_files\

* 1) Data extraction 

do read_MCVL_personal.do
do read_MCVL_laboral.do
do read_MCVL_base_employees.do
do read_MCVL_base_selfemp.do
do read_MCVL_hh.do
do read_MCVL_taxdata.do

* 2) Panel creation (order matters)
do code_empspells.do
do code_contempspells.do
do code_fpanel.do
do code_fpanel.do
do code_plantpanel.do
do code_plantpanel_final.do
do code_earnings.do 
do code_celltobit.do 
do code_taxrecords.do
do code_wpanel.do
do code_workerpanel.do 
do code_workerpanel_final.do 
do code_workerpanel_partners.do 
do code_durdata.do

* 3) Results 

* Employment results

do code_empreg_allp.do
do code_empreg_bench.do
do code_empreg_robust1.do
do code_empreg_subgr.do
do code_empreg_withbtw.do
do code_durestimation.do


*Income and working-time results
do code_regmargins.do
do code_regmargins_pFE.do
do code_worktimereg_sensdep.do
do code_wreg_senscens.do
do code_ncregs.do



