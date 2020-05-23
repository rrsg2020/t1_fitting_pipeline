qmt_spgr:  quantitative Magnetizatoion Transfer (qMT) using Spoiled Gradient Echo (or FLASH)
============================================================================================

.. image:: https://mybinder.org/badge_logo.svg
 :target: https://mybinder.org/v2/gh/qMRLab/doc_notebooks/master?filepath=qmt_spgr_notebook.ipynb
.. raw:: html
	
	
	<style type="text/css">
	.content { font-size:1.0em; line-height:140%; padding: 20px; }
	.content p { padding:0px; margin:0px 0px 20px; }
	.content img { padding:0px; margin:0px 0px 20px; border:none; }
	.content p img, pre img, tt img, li img, h1 img, h2 img { margin-bottom:0px; }
	.content ul { padding:0px; margin:0px 0px 20px 23px; list-style:square; }
	.content ul li { padding:0px; margin:0px 0px 7px 0px; }
	.content ul li ul { padding:5px 0px 0px; margin:0px 0px 7px 23px; }
	.content ul li ol li { list-style:decimal; }
	.content ol { padding:0px; margin:0px 0px 20px 0px; list-style:decimal; }
	.content ol li { padding:0px; margin:0px 0px 7px 23px; list-style-type:decimal; }
	.content ol li ol { padding:5px 0px 0px; margin:0px 0px 7px 0px; }
	.content ol li ol li { list-style-type:lower-alpha; }
	.content ol li ul { padding-top:7px; }
	.content ol li ul li { list-style:square; }
	.content pre, code { font-size:11px; }
	.content tt { font-size: 1.0em; }
	.content pre { margin:0px 0px 20px; }
	.content pre.codeinput { padding:10px; border:1px solid #d3d3d3; background:#f7f7f7; overflow-x:scroll}
	.content pre.codeoutput { padding:10px 11px; margin:0px 0px 20px; color:#4c4c4c; white-space: pre-wrap; white-space: -moz-pre-wrap; white-space: -pre-wrap; white-space: -o-pre-wrap; word -wrap: break-word;}
	.content pre.error { color:red; }
	.content @media print { pre.codeinput, pre.codeoutput { word-wrap:break-word; width:100%; } }
	.content span.keyword { color:#0000FF }
	.content span.comment { color:#228B22 }
	.content span.string { color:#A020F0 }
	.content span.untermstring { color:#B20000 }
	.content span.syscmd { color:#B28C00 }
	.content .footer { width:auto; padding:10px 0px; margin:25px 0px 0px; border-top:1px dotted #878787; font-size:0.8em; line-height:140%; font-style:italic; color:#878787; text-align:left; float:none; }
	.content .footer p { margin:0px; }
	.content .footer a { color:#878787; }
	.content .footer a:hover { color:#878787; text-decoration:underline; }
	.content .footer a:visited { color:#878787; }
	.content table th { padding:7px 5px; text-align:left; vertical-align:middle; border: 1px solid #d6d4d4; font-weight:bold; }
	.content table td { padding:7px 5px; text-align:left; vertical-align:top; border:1px solid #d6d4d4; }
	::-webkit-scrollbar {
	-webkit-appearance: none;
	width: 4px;
	height: 5px;
	}
	
	::-webkit-scrollbar-thumb {
	border-radius: 5px;
	background-color: rgba(0,0,0,.5);
	-webkit-box-shadow: 0 0 1px rgba(255,255,255,.5);
	}
	</style><div class="content"><h2 >Contents</h2><div ><ul ><li ><a href="#2">I- DESCRIPTION</a></li><li ><a href="#3">II- MODEL PARAMETERS</a></li><li ><a href="#4">a- create object</a></li><li ><a href="#5">b- modify options</a></li><li ><a href="#6">III- FIT EXPERIMENTAL DATASET</a></li><li ><a href="#7">a- load experimental data</a></li><li ><a href="#8">b- fit dataset</a></li><li ><a href="#9">c- show fitting results</a></li><li ><a href="#10">d- Save results</a></li><li ><a href="#11">V- SIMULATIONS</a></li><li ><a href="#12">a- Single Voxel Curve</a></li><li ><a href="#13">b- Sensitivity Analysis</a></li></ul></div><pre class="codeinput"><span class="comment">% This m-file has been automatically generated using qMRgenBatch(qmt_spgr)</span>
	<span class="comment">% Command Line Interface (CLI) is well-suited for automatization</span>
	<span class="comment">% purposes and Octave.</span>
	<span class="comment">%</span>
	<span class="comment">% Please execute this m-file section by section to get familiar with batch</span>
	<span class="comment">% processing for qmt_spgr on CLI.</span>
	<span class="comment">%</span>
	<span class="comment">% Demo files are downloaded into qmt_spgr_data folder.</span>
	<span class="comment">%</span>
	<span class="comment">% Written by: Agah Karakuzu, 2017</span>
	<span class="comment">% =========================================================================</span>
	</pre><h2 id="2">I- DESCRIPTION</h2><pre class="codeinput">qMRinfo(<span class="string">'qmt_spgr'</span>); <span class="comment">% Describe the model</span>
	</pre><pre class="codeoutput"> qmt_spgr:  quantitative Magnetizatoion Transfer (qMT) using Spoiled Gradient Echo (or FLASH)
	a href="matlab: figure, imshow qmt_spgr.png ;"Pulse Sequence Diagram/a
	
	Assumptions:
	FILL
	
	Inputs:
	MTdata              Magnetization Transfert data
	(R1map)             1/T1map (VFA RECOMMENDED Boudreau 2017 MRM)
	(B1map)             B1 field map, used for flip angle correction (=1 if not provided)
	(B0map)             B0 field map, used for offset correction (=0Hz if not provided)
	(Mask)              Binary mask to accelerate the fitting
	
	Outputs:
	F                   Ratio of number of restricted pool to free pool, defined
	as F = M0r/M0f = kf/kr.
	kr                  Exchange rate from the free to the restricted pool
	(note that kf and kr are related to one another via the
	definition of F. Changing the value of kf will change kr
	accordingly, and vice versa).
	R1f                 Longitudinal relaxation rate of the free pool
	(R1f = 1/T1f).
	R1r                 Longitudinal relaxation rate of the restricted pool
	(R1r = 1/T1r).
	T2f                 Tranverse relaxation time of the free pool (T2f = 1/R2f).
	T2r                 Tranverse relaxation time of the restricted pool (T2r = 1/R2r).
	(kf)                Exchange rate from the restricted to the free pool.
	(resnorm)           Fitting residual.
	
	Protocol:
	MTdata              Array [Nb of volumes x 2]
	Angle             MT pulses angles (degree)
	Offset            Offset frequencies (Hz)
	
	TimingTable         Vector [5x1]
	Tmt               Duration of the MT pulses (s)
	Ts                Free precession delay between the MT and excitation pulses (s)
	Tp                Duration of the excitation pulse (s)
	Tr                Free precession delay after the excitation pulse, before
	the next MT pulse (s)
	TR                Repetition time of the whole sequence (TR = Tmt + Ts + Tp + Tr)
	
	
	Options:
	MT Pulse
	Shape                 Shape of the MT pulse.
	Available shapes are:
	- hard
	- gaussian
	- gausshann (gaussian pulse with Hanning window)
	- sinc
	- sinchann (sinc pulse with Hanning window)
	- singauss (sinc pulse with gaussian window)
	- fermi
	Sinc TBW              Time-bandwidth product for the sinc MT pulses
	(applicable to sinc, sincgauss, sinchann MT
	pulses).
	Bandwidth             Bandwidth of the gaussian MT pulse (applicable
	to gaussian, gausshann and sincgauss MT pulses).
	Fermi transition (a)  slope 'a' (related to the transition width)
	of the Fermi pulse (applicable to fermi MT
	pulse).
	Assuming pulse duration at 60 dB (from the Bernstein handbook)
	and t0 = 10a,
	slope = Tmt/33.81;
	# of MT pulses        Number of pulses used to achieve steady-state
	before a readout is made.
	Fitting constraints
	Use R1map to         By checking this box, you tell the fitting
	constrain R1f          algorithm to check for an observed R1map and use
	its value to constrain R1f. Checking this box
	will automatically set the R1f fix box to true
	in the Fit parameters table.
	Fix R1r = R1f        By checking this box, you tell the fitting
	algorithm to fix R1r equal to R1f. Checking this
	box will automatically set the R1r fix box to
	true in the Fit parameters table.
	Fix R1f*T2f          By checking this box, you tell the fitting
	algorithm to compute T2f from R1f value. R1f*T2f
	value is set in the next box.
	R1f*T2f =            Value of R1f*T2f (no units)
	
	Model                  Model you want to use for fitting.
	Available models are:
	- SledPikeRP (Sled  Pike rectangular pulse),
	- SledPikeCW (Sled  Pike continuous wave),
	- Yarkykh (Yarnykh  Yuan)
	- Ramani
	Note: Sled  Pike models will show different
	options than Yarnykh or Ramani.
	Lineshape              The absorption lineshape of the restricted pool.
	Available lineshapes are:
	- Gaussian
	- Lorentzian
	- SuperLorentzian
	Read pulse alpha       Flip angle of the excitation pulse.
	Compute SfTable        By checking this box, you compute a new SfTable
	
	Command line usage:
	a href="matlab: qMRusage(qmt_spgr);"qMRusage(qmt_spgr/a
	
	Author: Ian Gagnon, 2017
	
	References:
	Please cite the following if you use this module:
	Sled, J.G., Pike, G.B., 2000. Quantitative interpretation of magnetization transfer in spoiled gradient echo MRI sequences. J. Magn. Reson. 145, 24?36.
	In addition to citing the package:
	Cabana J-F, Gu Y, Boudreau M, Levesque IR, Atchia Y, Sled JG, Narayanan S, Arnold DL, Pike GB, Cohen-Adad J, Duval T, Vuong M-T and Stikov N. (2016), Quantitative magnetization transfer imaging made easy with qMTLab: Software for data simulation, analysis, and visualization. Concepts Magn. Reson.. doi: 10.1002/cmr.a.21357
	
	Reference page in Doc Center
	doc qmt_spgr
	
	
	</pre><h2 id="3">II- MODEL PARAMETERS</h2><h2 id="4">a- create object</h2><pre class="codeinput">Model = qmt_spgr;
	</pre><h2 id="5">b- modify options</h2><pre >         |- This section will pop-up the options GUI. Close window to continue.
	|- Octave is not GUI compatible. Modify Model.options directly.</pre><pre class="codeinput">Model = Custom_OptionsGUI(Model); <span class="comment">% You need to close GUI to move on.</span>
	</pre><img src="_static/qmt_spgr_batch_01.png" vspace="5" hspace="5" alt=""> <h2 id="6">III- FIT EXPERIMENTAL DATASET</h2><h2 id="7">a- load experimental data</h2><pre >         |- qmt_spgr object needs 5 data input(s) to be assigned:
	|-   MTdata
	|-   R1map
	|-   B1map
	|-   B0map
	|-   Mask</pre><pre class="codeinput">data = struct();
	
	<span class="comment">% MTdata.mat contains [88  128    1   10] data.</span>
	load(<span class="string">'qmt_spgr_data/MTdata.mat'</span>);
	<span class="comment">% R1map.mat contains [88  128] data.</span>
	load(<span class="string">'qmt_spgr_data/R1map.mat'</span>);
	<span class="comment">% B1map.mat contains [88  128] data.</span>
	load(<span class="string">'qmt_spgr_data/B1map.mat'</span>);
	<span class="comment">% B0map.mat contains [88  128] data.</span>
	load(<span class="string">'qmt_spgr_data/B0map.mat'</span>);
	<span class="comment">% Mask.mat contains [88  128] data.</span>
	load(<span class="string">'qmt_spgr_data/Mask.mat'</span>);
	data.MTdata= double(MTdata);
	data.R1map= double(R1map);
	data.B1map= double(B1map);
	data.B0map= double(B0map);
	data.Mask= double(Mask);
	</pre><h2 id="8">b- fit dataset</h2><pre >           |- This section will fit data.</pre><pre class="codeinput">FitResults = FitData(data,Model,0);
	</pre><pre class="codeoutput">=============== qMRLab::Fit ======================
	Operation has been started: qmt_spgr
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Elapsed time is 2.358713 seconds.
	Operation has been completed: qmt_spgr
	==================================================
	</pre><h2 id="9">c- show fitting results</h2><pre >         |- Output map will be displayed.
	|- If available, a graph will be displayed to show fitting in a voxel.
	|- To make documentation generation and our CI tests faster for this model,
	we used a subportion of the data (40X40X40) in our testing environment.
	|- Therefore, this example will use FitResults that comes with OSF data for display purposes.
	|- Users will get the whole dataset (384X336X224) and the script that uses it for demo
	via qMRgenBatch(qsm_sb) command.</pre><pre class="codeinput">FitResults_old = load(<span class="string">'FitResults/FitResults.mat'</span>);
	qMRshowOutput(FitResults_old,data,Model);
	</pre><pre class="codeoutput">Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	</pre><img src="_static/qmt_spgr_batch_02.png" vspace="5" hspace="5" alt=""> <img src="_static/qmt_spgr_batch_03.png" vspace="5" hspace="5" alt=""> <h2 id="10">d- Save results</h2><pre >         |-  qMR maps are saved in NIFTI and in a structure FitResults.mat
	that can be loaded in qMRLab graphical user interface
	|-  Model object stores all the options and protocol.
	It can be easily shared with collaborators to fit their
	own data or can be used for simulation.</pre><pre class="codeinput">FitResultsSave_nii(FitResults);
	Model.saveObj(<span class="string">'qmt_spgr_Demo.qmrlab.mat'</span>);
	</pre><pre class="codeoutput">Warning: Directory already exists. 
	</pre><h2 id="11">V- SIMULATIONS</h2><pre >   |- This section can be executed to run simulations for qmt_spgr.</pre><h2 id="12">a- Single Voxel Curve</h2><pre >         |- Simulates Single Voxel curves:
	(1) use equation to generate synthetic MRI data
	(2) add rician noise
	(3) fit and plot curve</pre><pre class="codeinput">      x = struct;
	x.F = 0.16;
	x.kr = 30;
	x.R1f = 1;
	x.R1r = 1;
	x.T2f = 0.03;
	x.T2r = 1.3e-05;
	<span class="comment">% Set simulation options</span>
	Opt.SNR = 50;
	Opt.Method = <span class="string">'Analytical equation'</span>;
	Opt.ResetMz = false;
	<span class="comment">% run simulation</span>
	figure(<span class="string">'Name'</span>,<span class="string">'Single Voxel Curve Simulation'</span>);
	FitResult = Model.Sim_Single_Voxel_Curve(x,Opt);
	</pre><pre class="codeoutput">Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	</pre><img src="_static/qmt_spgr_batch_04.png" vspace="5" hspace="5" alt=""> <h2 id="13">b- Sensitivity Analysis</h2><pre >         |-    Simulates sensitivity to fitted parameters:
	(1) vary fitting parameters from lower (lb) to upper (ub) bound.
	(2) run Sim_Single_Voxel_Curve Nofruns times
	(3) Compute mean and std across runs</pre><pre class="codeinput">      <span class="comment">%              F             kr            R1f           R1r           T2f           T2r</span>
	OptTable.st = [0.16          30            1             1             0.03          1.3e-05]; <span class="comment">% nominal values</span>
	OptTable.fx = [0             1             1             1             1             1]; <span class="comment">%vary F...</span>
	OptTable.lb = [0.0001        0.0001        0.05          0.05          0.003         3e-06]; <span class="comment">%...from 0.0001</span>
	OptTable.ub = [0.5           1e+02         5             5             0.5           5e-05]; <span class="comment">%...to 0.5</span>
	<span class="comment">% Set simulation options</span>
	Opt.SNR = 50;
	Opt.Method = <span class="string">'Analytical equation'</span>;
	Opt.ResetMz = false;
	Opt.Nofrun = 5;
	<span class="comment">% run simulation</span>
	SimResults = Model.Sim_Sensitivity_Analysis(OptTable,Opt);
	figure(<span class="string">'Name'</span>,<span class="string">'Sensitivity Analysis'</span>);
	SimVaryPlot(SimResults, <span class="string">'F'</span> ,<span class="string">'F'</span> );
	</pre><pre class="codeoutput">Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	Warning: No MToff (i.e. no volumes acquired with Angles=0) -- Fitting assumes
	that MTData are already normalized. 
	</pre><img src="_static/qmt_spgr_batch_05.png" vspace="5" hspace="5" alt=""> <p class="footer"><br ><a href="https://www.mathworks.com/products/matlab/">Published with MATLAB R2018a</a><br ></p></div>
