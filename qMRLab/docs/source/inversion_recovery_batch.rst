inversion_recovery: Compute a T1 map using Inversion Recovery data
==================================================================

.. image:: https://mybinder.org/badge_logo.svg
 :target: https://mybinder.org/v2/gh/qMRLab/doc_notebooks/master?filepath=inversion_recovery_notebook.ipynb
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
	</style><div class="content"><h2 >Contents</h2><div ><ul ><li ><a href="#2">I- DESCRIPTION</a></li><li ><a href="#3">II- MODEL PARAMETERS</a></li><li ><a href="#4">a- create object</a></li><li ><a href="#5">b- modify options</a></li><li ><a href="#6">III- FIT EXPERIMENTAL DATASET</a></li><li ><a href="#7">a- load experimental data</a></li><li ><a href="#8">b- fit dataset</a></li><li ><a href="#9">c- show fitting results</a></li><li ><a href="#10">d- Save results</a></li><li ><a href="#11">V- SIMULATIONS</a></li><li ><a href="#12">a- Single Voxel Curve</a></li><li ><a href="#13">b- Sensitivity Analysis</a></li></ul></div><pre class="codeinput"><span class="comment">% This m-file has been automatically generated using qMRgenBatch(inversion_recovery)</span>
	<span class="comment">% Command Line Interface (CLI) is well-suited for automatization</span>
	<span class="comment">% purposes and Octave.</span>
	<span class="comment">%</span>
	<span class="comment">% Please execute this m-file section by section to get familiar with batch</span>
	<span class="comment">% processing for inversion_recovery on CLI.</span>
	<span class="comment">%</span>
	<span class="comment">% Demo files are downloaded into inversion_recovery_data folder.</span>
	<span class="comment">%</span>
	<span class="comment">% Written by: Agah Karakuzu, 2017</span>
	<span class="comment">% =========================================================================</span>
	</pre><h2 id="2">I- DESCRIPTION</h2><pre class="codeinput">qMRinfo(<span class="string">'inversion_recovery'</span>); <span class="comment">% Describe the model</span>
	</pre><pre class="codeoutput"> inversion_recovery: Compute a T1 map using Inversion Recovery data
	
	Assumptions:
	(1) Gold standard for T1 mapping
	(2) Infinite TR
	
	Inputs:
	IRData      Inversion Recovery data (4D)
	(Mask)      Binary mask to accelerate the fitting (OPTIONAL)
	
	Outputs:
	T1          transverse relaxation time [ms]
	b           arbitrary fit parameter (S=a + b*exp(-TI/T1))
	a           arbitrary fit parameter (S=a + b*exp(-TI/T1))
	idx         index of last polarity restored datapoint (only used for magnitude data)
	res         Fitting residual
	
	
	Protocol:
	IRData  [TI1 TI2...TIn] inversion times [ms]
	
	Options:
	Method          Method to use in order to fit the data, based on whether complex or only magnitude data acquired.
	'complex'         RD-NLS (Reduced-Dimension Non-Linear Least Squares)
	S=a + b*exp(-TI/T1)
	'magnitude'      RD-NLS-PR (Reduced-Dimension Non-Linear Least Squares with Polarity Restoration)
	S=|a + b*exp(-TI/T1)|
	
	Example of command line usage (see also a href="matlab: showdemo inversion_recovery_batch"showdemo inversion_recovery_batch/a):
	Model = inversion_recovery;  % Create class from model
	Model.Prot.IRData.Mat=[350.0000; 500.0000; 650.0000; 800.0000; 950.0000; 1100.0000; 1250.0000; 1400.0000; 1700.0000];
	data = struct;  % Create data structure
	data.MET2data ='IRData.mat';  % Load data
	data.Mask = 'Mask.mat';
	FitResults = FitData(data,Model); %fit data
	FitResultsSave_mat(FitResults);
	
	For more examples: a href="matlab: qMRusage(minversion_recovery);"qMRusage(inversion_recovery)/a
	
	Author: Ilana Leppert, 2017
	
	References:
	Please cite the following if you use this module:
	A robust methodology for in vivo T1 mapping. Barral JK, Gudmundson E, Stikov N, Etezadi-Amoli M, Stoica P, Nishimura DG. Magn Reson Med. 2010 Oct;64(4):1057-67. doi: 10.1002/mrm.22497.
	In addition to citing the package:
	Cabana J-F, Gu Y, Boudreau M, Levesque IR, Atchia Y, Sled JG, Narayanan S, Arnold DL, Pike GB, Cohen-Adad J, Duval T, Vuong M-T and Stikov N. (2016), Quantitative magnetization transfer imaging made easy with qMTLab: Software for data simulation, analysis, and visualization. Concepts Magn. Reson.. doi: 10.1002/cmr.a.21357
	
	
	Reference page in Doc Center
	doc inversion_recovery
	
	
	</pre><h2 id="3">II- MODEL PARAMETERS</h2><h2 id="4">a- create object</h2><pre class="codeinput">Model = inversion_recovery;
	</pre><h2 id="5">b- modify options</h2><pre >         |- This section will pop-up the options GUI. Close window to continue.
	|- Octave is not GUI compatible. Modify Model.options directly.</pre><pre class="codeinput">Model = Custom_OptionsGUI(Model); <span class="comment">% You need to close GUI to move on.</span>
	</pre><img src="_static/inversion_recovery_batch_01.png" vspace="5" hspace="5" alt=""> <h2 id="6">III- FIT EXPERIMENTAL DATASET</h2><h2 id="7">a- load experimental data</h2><pre >         |- inversion_recovery object needs 2 data input(s) to be assigned:
	|-   IRData
	|-   Mask</pre><pre class="codeinput">data = struct();
	
	<span class="comment">% IRData.mat contains [128  128    1    9] data.</span>
	load(<span class="string">'inversion_recovery_data/IRData.mat'</span>);
	<span class="comment">% Mask.mat contains [128  128] data.</span>
	load(<span class="string">'inversion_recovery_data/Mask.mat'</span>);
	data.IRData= double(IRData);
	data.Mask= double(Mask);
	</pre><h2 id="8">b- fit dataset</h2><pre >           |- This section will fit data.</pre><pre class="codeinput">FitResults = FitData(data,Model,0);
	</pre><pre class="codeoutput">=============== qMRLab::Fit ======================
	Operation has been started: inversion_recovery
	Elapsed time is 0.026846 seconds.
	Operation has been completed: inversion_recovery
	==================================================
	</pre><h2 id="9">c- show fitting results</h2><pre >         |- Output map will be displayed.
	|- If available, a graph will be displayed to show fitting in a voxel.
	|- To make documentation generation and our CI tests faster for this model,
	we used a subportion of the data (40X40X40) in our testing environment.
	|- Therefore, this example will use FitResults that comes with OSF data for display purposes.
	|- Users will get the whole dataset (384X336X224) and the script that uses it for demo
	via qMRgenBatch(qsm_sb) command.</pre><pre class="codeinput">FitResults_old = load(<span class="string">'FitResults/FitResults.mat'</span>);
	qMRshowOutput(FitResults_old,data,Model);
	</pre><img src="_static/inversion_recovery_batch_02.png" vspace="5" hspace="5" alt=""> <img src="_static/inversion_recovery_batch_03.png" vspace="5" hspace="5" alt=""> <h2 id="10">d- Save results</h2><pre >         |-  qMR maps are saved in NIFTI and in a structure FitResults.mat
	that can be loaded in qMRLab graphical user interface
	|-  Model object stores all the options and protocol.
	It can be easily shared with collaborators to fit their
	own data or can be used for simulation.</pre><pre class="codeinput">FitResultsSave_nii(FitResults);
	Model.saveObj(<span class="string">'inversion_recovery_Demo.qmrlab.mat'</span>);
	</pre><pre class="codeoutput">Warning: Directory already exists. 
	</pre><h2 id="11">V- SIMULATIONS</h2><pre >   |- This section can be executed to run simulations for inversion_recovery.</pre><h2 id="12">a- Single Voxel Curve</h2><pre >         |- Simulates Single Voxel curves:
	(1) use equation to generate synthetic MRI data
	(2) add rician noise
	(3) fit and plot curve</pre><pre class="codeinput">      x = struct;
	x.T1 = 600;
	x.rb = -1000;
	x.ra = 500;
	<span class="comment">% Set simulation options</span>
	Opt.SNR = 50;
	Opt.T1 = 600;
	Opt.M0 = 1000;
	Opt.TR = 3000;
	Opt.FAinv = 180;
	Opt.FAexcite = 90;
	Opt.Updateinputvariables = false;
	<span class="comment">% run simulation</span>
	figure(<span class="string">'Name'</span>,<span class="string">'Single Voxel Curve Simulation'</span>);
	FitResult = Model.Sim_Single_Voxel_Curve(x,Opt);
	</pre><img src="_static/inversion_recovery_batch_04.png" vspace="5" hspace="5" alt=""> <h2 id="13">b- Sensitivity Analysis</h2><pre >         |-    Simulates sensitivity to fitted parameters:
	(1) vary fitting parameters from lower (lb) to upper (ub) bound.
	(2) run Sim_Single_Voxel_Curve Nofruns times
	(3) Compute mean and std across runs</pre><pre class="codeinput">      <span class="comment">%              T1            rb            ra</span>
	OptTable.st = [6e+02         -1e+03        5e+02]; <span class="comment">% nominal values</span>
	OptTable.fx = [0             1             1]; <span class="comment">%vary T1...</span>
	OptTable.lb = [0.0001        -1e+04        0.0001]; <span class="comment">%...from 0.0001</span>
	OptTable.ub = [5e+03         0             1e+04]; <span class="comment">%...to 5000</span>
	Opt.SNR = 50;
	Opt.Nofrun = 5;
	<span class="comment">% run simulation</span>
	SimResults = Model.Sim_Sensitivity_Analysis(OptTable,Opt);
	figure(<span class="string">'Name'</span>,<span class="string">'Sensitivity Analysis'</span>);
	SimVaryPlot(SimResults, <span class="string">'T1'</span> ,<span class="string">'T1'</span> );
	</pre><img src="_static/inversion_recovery_batch_05.png" vspace="5" hspace="5" alt=""> <p class="footer"><br ><a href="https://www.mathworks.com/products/matlab/">Published with MATLAB R2018a</a><br ></p></div>
