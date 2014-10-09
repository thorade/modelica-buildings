within Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources;
model PVsimpleOriented
  "Simple PV source with orientation and without neutral cable"
  extends
    Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.BaseClasses.UnbalancedPV(
    redeclare Buildings.Electrical.AC.OnePhase.Sources.PVSimple pv_phase1,
    redeclare Buildings.Electrical.AC.OnePhase.Sources.PVSimple pv_phase2,
    redeclare Buildings.Electrical.AC.OnePhase.Sources.PVSimple pv_phase3);
  parameter Modelica.SIunits.Angle til "Surface tilt" annotation(Dialog(group="Orientation"));
  parameter Modelica.SIunits.Angle lat "Latitude" annotation(Dialog(group="Orientation"));
  parameter Modelica.SIunits.Angle azi "Surface Azimith" annotation(Dialog(group="Orientation"));
  BoundaryConditions.SolarIrradiation.DiffusePerez           HDifTil(
    til=til,
    lat=lat,
    azi=azi) "Diffuse irradiation on tilted surface"
    annotation (Placement(transformation(extent={{20,-80},{0,-60}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface           HDirTil(
    til=til,
    lat=lat,
    azi=azi) "Direct irradiation on tilted surface"
    annotation (Placement(transformation(extent={{60,-99},{40,-79}})));
  Modelica.Blocks.Math.Add G "Total irradiation on tilted surface"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-76,-70})));
  BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data" annotation (
     Placement(transformation(extent={{76,-62},{96,-42}}), iconTransformation(
          extent={{-10,80},{10,100}})));
equation
  connect(HDifTil.weaBus,weaBus)  annotation (Line(
      points={{20,-70},{72,-70},{72,-52},{86,-52}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus,HDirTil. weaBus) annotation (Line(
      points={{86,-52},{72,-52},{72,-89},{60,-89}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDifTil.H, G.u2) annotation (Line(
      points={{-1,-70},{-52,-70},{-52,-64},{-64,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(G.y, G_int) annotation (Line(
      points={{-87,-70},{-94,-70},{-94,20},{-80,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil.H, G.u1) annotation (Line(
      points={{39,-89},{-60,-89},{-60,-76},{-64,-76}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
  defaultComponentName="pv",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
    Documentation(revisions="<html>
<ul>
<li>
August 27, 2014, by Marco Bonvini:<br/>
Revised documentation.
</li>
</ul>
</html>", info="<html>
<p>
Simple PV model with orientation for three phases unbalanced systems
without neutral cable connection.
</p>
<p>
For more information see 
<a href=\"modelica://Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented\">
Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented</a>, and
<a href=\"modelica://Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.BaseClasses.UnbalancedPV\">
Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.BaseClasses.UnbalancedPV</a>.
</p>
</html>"));
end PVsimpleOriented;