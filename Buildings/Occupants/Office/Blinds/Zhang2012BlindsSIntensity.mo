within Buildings.Occupants.Office.Blinds;
model Zhang2012BlindsSIntensity
    "A model to predict occupants' blinds behavior with Solar Intensity"
    extends Modelica.Blocks.Icons.DiscreteBlock;
    parameter Real Aup = 0.003 "Slope of Solar Intensity for blinds up";
    parameter Real Adown = 0.002 "Slope of Solar Intensity for blinds down";
    parameter Real Bup = -3.33 "Intercept for blinds up";
    parameter Real Bdown = -3.17 "Intercept for blinds down";
    parameter Integer seed = 10 "Seed for the random number generator";
    parameter Modelica.SIunits.Time samplePeriod = 120 "Sample period";

    Modelica.Blocks.Interfaces.RealInput H(
      unit="W/m2") "Solar Intensity" annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
    Modelica.Blocks.Interfaces.BooleanInput occ
      "Indoor occupancy, true for occupied"
      annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealOutput blindState
      "The State of Blinds, 1 being blinds deployed"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    Real pup(
      unit="1",
      min=0,
      max=1) "The probability of blinds up";
    Real pdown(
      unit="1",
      min=0,
      max=1) "The probability of blinds down";

protected
    parameter Modelica.SIunits.Time t0(fixed = false) "First sample time instant";
    output Boolean sampleTrigger "True, if sample time instant";

  initial equation
    t0 = time;
    blindState = 1 "Initial state of blinds is 100% on";

  equation
    sampleTrigger = sample(t0,samplePeriod);
    when sampleTrigger then


      if occ then
        if pre(blindState) == 1 then
          pup = 0;
          pdown = Modelica.Math.exp(Adown*H+Bdown)/(Modelica.Math.exp(Adown*H+Bdown)+1);
          if Buildings.Occupants.BaseClasses.binaryVariableGeneration(p=pdown,globalSeed=integer(seed*time)) then
            blindState = 0;
          else
            blindState = 1;
          end if;
        else
          pup = Modelica.Math.exp(Aup*H+Bup)/(Modelica.Math.exp(Aup*H+Bup)+1);
          pdown = 0;
          if Buildings.Occupants.BaseClasses.binaryVariableGeneration(p=pup,globalSeed=integer(seed*time)) then
            blindState = 1;
          else
            blindState = 0;
          end if;
        end if;
      else
        pup = 0;
        pdown = 0;
        blindState = 1;
      end if;
    end when;

    annotation (graphics={
              Rectangle(extent={{-60,40},{60,-40}}, lineColor={28,108,200}), Text(
              extent={{-40,20},{40,-20}},
              lineColor={28,108,200},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textStyle={TextStyle.Bold},
              textString="Blinds_SI")},
  defaultComponentName="bli",
  Documentation(info="<html>
<p>
Model predicting the state of the blinds with the solar intensity at the window 
and occupancy.
</p>
<h4>Dynamics</h4>
<p>
When the space is unoccupied, the blinds is always on. When the 
space is occupied, the lower the Solar Intensity is, the higher 
the chance that the blind is on.
</p>
<h4>References</h4>
<p>
The model is documented in the paper &quot;Zhang, Y. and Barrett, P., 2012. 
Factors influencing occupants’ blind-control behaviour in a naturally 
ventilated office building. Building and Environment, 54, pp.137-147.&quot;.
</p>
<p>
The model parameters are regressed from the field study in an office building
in Sheffield, England.
</p>
</html>",
  revisions="<html>
<ul>
<li>
July 23, 2018, by Zhe Wang:<br/>
First implementation.
</li>
<li>
August 31, 2018, by Zhe Wang:<br/>
First revision.
</li>
</ul>
</html>"),
    Icon(graphics={Text(
          extent={{-98,98},{94,-96}},
          lineColor={28,108,200},
          textString="ob.office
Blind")}));
end Zhang2012BlindsSIntensity;