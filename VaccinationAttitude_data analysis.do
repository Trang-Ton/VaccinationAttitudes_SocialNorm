 *                          Social Norm Seminar
 *                            Winter 2021/22
 *                      Suppevior: Matthias Mayer 
 *                     Group 2: Vaccination Attitude
					
clear
clear matrix
capture log close

//cd "/Users/tonnunhatrang/Desktop/Seminar_Social norms/Submitted files" // change working directory if required

log using "Socialnormseminar.log", replace

*****************************************

use "Combine 3 treatments.dta"

*** Data description
asdoc sum scale_5c c1 c2 c3 c4 c5 Age ibn.Gender ibn.Marriage ibn.Children

*** T-test results of Null-Hypothesis: “No difference in [variable] be between control and peer treatment groups”

asdoc ttest c1 if (TreatmentGroup!="Anchor"), by(TreatmentGroup), replace title(Result1)
asdoc ttest c2 if (TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend
asdoc ttest c3 if (TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend
asdoc ttest c4 if (TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend
asdoc ttest c5 if (TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend

*** T-test results of Null-Hypothesis: “No difference in [variable] between control and an-choring treatment groups”

asdoc ttest c1 if (TreatmentGroup!="Peer"), by(TreatmentGroup), replace title(Result2)
asdoc ttest c2 if (TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend
asdoc ttest c3 if (TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend
asdoc ttest c4 if (TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend
asdoc ttest c5 if (TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend

*** T-test results of Null-Hypothesis: “No difference in [variable] between peer and anchor-ing treatment groups”

asdoc ttest c1 if (TreatmentGroup!="Control"), by(TreatmentGroup), replace title(ResultAP)
asdoc ttest c2 if (TreatmentGroup!="Control"), by(TreatmentGroup), rowappend
asdoc ttest c3 if (TreatmentGroup!="Control"), by(TreatmentGroup), rowappend
asdoc ttest c4 if (TreatmentGroup!="Control"), by(TreatmentGroup), rowappend
asdoc ttest c5 if (TreatmentGroup!="Control"), by(TreatmentGroup), rowappend


*** T-test results of Null-Hypothesis: “No difference in [variable] between control and peer(anchor) treatment groups” when controlling for Gender=female 

asdoc ttest c1 if (Gender==2 & TreatmentGroup!="Anchor"), by(TreatmentGroup), replace title(Result3)
asdoc ttest c2 if (Gender==2 &TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend
asdoc ttest c3 if (Gender==2 & TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend
asdoc ttest c4 if (Gender==2 & TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend
asdoc ttest c5 if (Gender==2 & TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend

asdoc ttest c1 if (Gender==2 & TreatmentGroup!="Peer"), by(TreatmentGroup), replace title(Result4)
asdoc ttest c2 if (Gender==2 & TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend
asdoc ttest c3 if (Gender==2 & TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend
asdoc ttest c4 if (Gender==2 & TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend
asdoc ttest c5 if (Gender==2 & TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend

*** T-test results of Null-Hypothesis: “No difference in [variable] between control and peer(anchor) treatment groups” when controlling for Gender=Male

asdoc ttest c1 if (Gender==3 & TreatmentGroup!="Anchor"), by(TreatmentGroup), replace title(Result5)
asdoc ttest c2 if (Gender==3 &TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend
asdoc ttest c3 if (Gender==3 & TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend
asdoc ttest c4 if (Gender==3 & TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend
asdoc ttest c5 if (Gender==3 & TreatmentGroup!="Anchor"), by(TreatmentGroup), rowappend

asdoc ttest c1 if (Gender==3 & TreatmentGroup!="Peer"), by(TreatmentGroup), replace title(Result6)
asdoc ttest c2 if (Gender==3 & TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend
asdoc ttest c3 if (Gender==3 & TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend
asdoc ttest c4 if (Gender==3 & TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend
asdoc ttest c5 if (Gender==3 & TreatmentGroup!="Peer"), by(TreatmentGroup), rowappend

*** Interval Plots of 5C Scale against Treatment Groups - Graphing on 95% confident interval
*   Without factor variable Gender
 graph drop _all
 set graphics off
 ciplot c1, by(TreatmentGroup) title("(a)") ytitle(Confidence) xtitle("") name(c1) note("")
 ciplot c2, by(TreatmentGroup) title("(b)") ytitle(Complacency) xtitle("") name(c2) note("")
 ciplot c3, by(TreatmentGroup) title("(c)") ytitle(Constraints) xtitle("") name(c3) note("")
 ciplot c4, by(TreatmentGroup) title("(d)") ytitle(Calculation) xtitle("") name(c4) note("")
 ciplot c5, by(TreatmentGroup) title("(e)") ytitle(Collective Responsibility) xtitle("") name(c5) note("")
 set graphics on
 graph combine c1 c2 c3 c4 c5, note("95% Confidence Interval") name(Graph1)
 
 graph export Graph1, as(png) 
 

*** Linear Regression


*   With treatment Control vs Peer (Control =0, Peer = 1)

reg c1 Peer Age Marriage Children if TreatmentGroup!= "Anchor", robust
///outreg2 using Myfile.doc, replace ctitle(Confidence)
reg c2 Peer Age Marriage Children if TreatmentGroup!= "Anchor", robust
///outreg2 using Myfile.doc, append ctitle(Complacency)
reg c3 Peer Age Marriage Children if TreatmentGroup!= "Anchor", robust
///outreg2 using Myfile.doc, append ctitle(Constraints)
reg c4 Peer Age Marriage Children if TreatmentGroup!= "Anchor", robust
///outreg2 using Myfile.doc, append ctitle(Calculation)
reg c5 Peer Age Marriage Children if TreatmentGroup!= "Anchor", robust
///outreg2 using Myfile.doc, append ctitle(Collective Responsibility)

*   With treatment Control vs Anchor (Control =0, Anchor = 1)

reg c1 Anchor Age Marriage Children if TreatmentGroup!= "Peer", robust
///outreg2 using Myfile.doc, replace ctitle(Confidence)
reg c2 Anchor Age Marriage Children if TreatmentGroup!= "Peer", robust
///outreg2 using Myfile.doc, append ctitle(Complacency)
reg c3 Anchor Age Marriage Children if TreatmentGroup!= "Peer", robust
///outreg2 using Myfile.doc, append ctitle(Constraints)
reg c4 Anchor Age Marriage Children if TreatmentGroup!= "Peer", robust
///outreg2 using Myfile.doc, append ctitle(Calculation)
reg c5 Anchor Age Marriage Children if TreatmentGroup!= "Peer", robust
///outreg2 using Myfile.doc, append ctitle(Collective Responsibility)

