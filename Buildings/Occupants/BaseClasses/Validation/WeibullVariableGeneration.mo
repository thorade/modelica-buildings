within Buildings.Occupants.BaseClasses.Validation;
model WeibullVariableGeneration "Test model for real variable generation function"
  extends Modelica.Icons.Example;

  parameter Integer seed = 5 "Seed for the random number generator";
  parameter Real lambda=10 "Time step length";

  Real k "Time-varying real number as input";
  output Real y "Output";
initial equation
  y = 0;
equation
  k = (time+1);
  when sample(0, 0.1) then
    y = Buildings.Occupants.BaseClasses.weibullVariableGeneration(lambda,k,globalSeed=integer(seed*1E6*time));
  end when;

  annotation ( experiment(Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Occupants/BaseClasses/Validation/WeibullVariableGeneration.mos"
        "Simulate and plot"), Documentation(info="<html>
<p>
This model tests the implementation of
<a href=\"modelica://Buildings.Occupants.Baseclasses.weibullVariableGeneration\">
Buildings.Occupants.Baseclasses.weibullVariableGeneration</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
September 5, 2018 by Zhe Wang:<br/>
First implementation.
</li>
</ul>
</html>"));
end WeibullVariableGeneration;