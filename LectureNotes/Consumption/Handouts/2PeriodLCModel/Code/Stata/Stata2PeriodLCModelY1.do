* For detailed explanations, please see the Mathematica code

clear
set memory 10m

* PARAMETER DEFINITION
***********************************************************
global Y1 = 1
global RLo = 1
global RHi = 2
global rho = 2
global beta = 0.96

global ObsNumber=1000


* FUNCTIONAL FORMS
***********************************************************

global C1RLo=$Y1*$RLo/($RLo+($RLo*$beta)^(1/$rho))
global C2RLo=$C1RLo*($RLo*$beta)^(1/$rho)
global VRLo=($C1RLo^(1-$rho)+$beta*$C2RLo^(1-$rho))/(1-$rho)
global C1RHi=$Y1*$RHi/($RHi+($RHi*$beta)^(1/$rho))
global C2RHi=$C1RHi*($RHi*$beta)^(1/$rho)
global VRHi=($C1RHi^(1-$rho)+$beta*$C2RHi^(1-$rho))/(1-$rho)

global C1Subs=($VRHi*(1-$rho)/(1+$beta*($RLo*$beta)^((1-$rho)/$rho)))^(1/(1-$rho))
global C2Subs=$C1Subs*($RLo*$beta)^(1/$rho)
global Y1Equiv=$C1Subs+$C2Subs/$RLo

range C1 0 $Y1 $ObsNumber

gen IBC_RLo=($Y1-C1)*$RLo
gen IBC_RHi=($Y1-C1)*$RHi
gen IBC_Subs=($Y1Equiv-C1)*$RLo

gen IndCurveRLo=(($VRLo*(1-$rho)-C1^(1-$rho))/$beta)^(1/(1-$rho))
gen IndCurveRHi=(($VRHi*(1-$rho)-C1^(1-$rho))/$beta)^(1/(1-$rho))
replace IndCurveRLo=. if IndCurveRLo<0 | IndCurveRLo>$Y1*$RHi
replace IndCurveRHi=. if IndCurveRHi<0 | IndCurveRHi>$Y1*$RHi


* PLOT
***********************************************************

line IBC_RLo IBC_RHi  IBC_Subs IndCurveRLo IndCurveRHi C1, legend(off) ytitle(C2) ///
color(black black black black black) name(FlexiblePlot,replace)

replace IBC_Subs=. if C1<0.5
replace IndCurveRLo=. if IndCurveRLo>1 | C1>.65
replace IndCurveRHi=. if IndCurveRHi>1.3 | C1>.85
line IBC_RLo IBC_RHi  IBC_Subs IndCurveRLo IndCurveRHi C1 if C1>0.2, legend(off) ytitle(C2) ///
color(black black black black black) xlabel(,noticks nolabels) ylabel(,noticks nolabels) scheme(s1color) 
