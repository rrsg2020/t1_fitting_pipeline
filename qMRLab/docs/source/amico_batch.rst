amico:   Accelerated Microstructure Imaging via Convex Optimization
===================================================================

.. image:: https://mybinder.org/badge_logo.svg
 :target: https://mybinder.org/v2/gh/qMRLab/doc_notebooks/master?filepath=amico_notebook.ipynb
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
	</style><div class="content"><h2 >Contents</h2><div ><ul ><li ><a href="#2">I- DESCRIPTION</a></li><li ><a href="#3">II- MODEL PARAMETERS</a></li><li ><a href="#4">a- create object</a></li><li ><a href="#5">b- modify options</a></li><li ><a href="#6">III- FIT EXPERIMENTAL DATASET</a></li><li ><a href="#7">a- load experimental data</a></li><li ><a href="#8">b- fit dataset</a></li><li ><a href="#9">c- show fitting results</a></li><li ><a href="#10">d- Save results</a></li><li ><a href="#11">V- SIMULATIONS</a></li><li ><a href="#12">a- Single Voxel Curve</a></li><li ><a href="#13">b- Sensitivity Analysis</a></li></ul></div><pre class="codeinput"><span class="comment">% This m-file has been automatically generated using qMRgenBatch(amico)</span>
	<span class="comment">% Command Line Interface (CLI) is well-suited for automatization</span>
	<span class="comment">% purposes and Octave.</span>
	<span class="comment">%</span>
	<span class="comment">% Please execute this m-file section by section to get familiar with batch</span>
	<span class="comment">% processing for amico on CLI.</span>
	<span class="comment">%</span>
	<span class="comment">% Demo files are downloaded into amico_data folder.</span>
	<span class="comment">%</span>
	<span class="comment">% Written by: Agah Karakuzu, 2017</span>
	<span class="comment">% =========================================================================</span>
	</pre><h2 id="2">I- DESCRIPTION</h2><pre class="codeinput">qMRinfo(<span class="string">'amico'</span>); <span class="comment">% Describe the model</span>
	</pre><pre class="codeoutput">  amico:   Accelerated Microstructure Imaging via Convex Optimization
	Sub-module of noddi
	a href="matlab: figure, imshow Diffusion.png ;"Pulse Sequence Diagram/a
	
	ASSUMPTIONS:
	Neuronal fibers model:
	geometry                          sticks (Dperp = 0)
	Orientation dispersion            YES (Watson distribution). Note that NODDI is more robust to
	crossing fibers that DTI  (Campbell, NIMG 2017)
	
	Permeability                      NO
	Diffusion properties:
	intra-axonal                      totally restricted
	diffusion coefficient (Dr)      fixed by default.
	extra-axonal                      Tortuosity model. Parallel diffusivity is equal to
	intra-diffusivity.Perpendicular diffusivity is
	proportional to fiber density
	diffusion coefficient (Dh)      Constant
	
	Inputs:
	DiffusionData       4D diffusion weighted dataset
	(Mask)               Binary mask to accelerate the fitting (OPTIONAL)
	
	Outputs:
	di                  Diffusion coefficient in the restricted compartment.
	ficvf               Fraction of water in the restricted compartment.
	fiso                Fraction of water in the isotropic compartment (e.g. CSF/Veins)
	fr                  Fraction of restricted water in the entire voxel (e.g. intra-cellular volume fraction)
	fr = ficvf*(1-fiso)
	irfrac              Fraction of isotropically restricted compartment (Dot for ex vivo model)
	diso (fixed)        diffusion coefficient of the isotropic compartment (CSF)
	kappa               Orientation dispersion index
	b0                  Signal at b=0
	theta               angle of the fibers
	phi                 angle of the fibers
	
	Protocol:
	Multi-shell diffusion-weighted acquisition
	at least 2 non-zeros bvalues
	at least 5 b=0 (used to compute noise standard deviation
	
	DiffusionData       Array [NbVol x 7]
	Gx                Diffusion Gradient x
	Gy                Diffusion Gradient y
	Gz                Diffusion Gradient z
	Gnorm (T/m)         Diffusion gradient magnitude
	Delta (s)         Diffusion separation
	delta (s)         Diffusion duration
	TE (s)            Echo time
	
	Options:
	Model               Model part of NODDI.
	Available models are:
	-WatsonSHStickTortIsoVIsoDot_B0 is a four model compartment used for ex-vivo datasets
	
	Example of command line usage
	For more examples: a href="matlab: qMRusage(noddi);"qMRusage(noddi)/a
	
	Author: Tanguy Duval
	
	References:
	Please cite the following if you use this module:
	Alessandro Daducci, Erick Canales-Rodriguez, Hui Zhang, Tim Dyrby, Daniel Alexander, Jean-Philippe Thiran, 2015. Accelerated Microstructure Imaging via Convex Optimization (AMICO) from diffusion MRI data. NeuroImage 105, pp. 32-44
	Zhang, H., Schneider, T., Wheeler-Kingshott, C.A., Alexander, D.C., 2012. NODDI: practical in vivo neurite orientation dispersion and density imaging of the human brain. Neuroimage 61, 1000?1016.
	In addition to citing the package:
	Cabana J-F, Gu Y, Boudreau M, Levesque IR, Atchia Y, Sled JG, Narayanan S, Arnold DL, Pike GB, Cohen-Adad J, Duval T, Vuong M-T and Stikov N. (2016), Quantitative magnetization transfer imaging made easy with qMTLab: Software for data simulation, analysis, and visualization. Concepts Magn. Reson.. doi: 10.1002/cmr.a.21357
	
	Reference page in Doc Center
	doc amico
	
	
	</pre><h2 id="3">II- MODEL PARAMETERS</h2><h2 id="4">a- create object</h2><pre class="codeinput">Model = amico;
	</pre><h2 id="5">b- modify options</h2><pre >         |- This section will pop-up the options GUI. Close window to continue.
	|- Octave is not GUI compatible. Modify Model.options directly.</pre><pre class="codeinput">Model = Custom_OptionsGUI(Model); <span class="comment">% You need to close GUI to move on.</span>
	</pre><img src="_static/amico_batch_01.png" vspace="5" hspace="5" alt=""> <h2 id="6">III- FIT EXPERIMENTAL DATASET</h2><h2 id="7">a- load experimental data</h2><pre >         |- amico object needs 2 data input(s) to be assigned:
	|-   DiffusionData
	|-   Mask</pre><pre class="codeinput">data = struct();
	<span class="comment">% DiffusionData.nii.gz contains [74   87   50  109] data.</span>
	data.DiffusionData=double(load_nii_data(<span class="string">'amico_data/DiffusionData.nii.gz'</span>));
	<span class="comment">% Mask.nii.gz contains [74  87  50] data.</span>
	data.Mask=double(load_nii_data(<span class="string">'amico_data/Mask.nii.gz'</span>));
	</pre><h2 id="8">b- fit dataset</h2><pre >           |- This section will fit data.</pre><pre class="codeinput">FitResults = FitData(data,Model,0);
	</pre><pre class="codeoutput">
	- Precomputing rotation matrices for l_max=12:
	[ already computed ]
	
	- Generating kernels with model "NODDI" for protocol "example":
	[ Kernels already computed. Set "doRegenerate=true" to force regeneration ]
	
	- Resampling rotated kernels:
	[========                 ] </pre><pre class="codeoutput error">Error using load
	Unable to read file '/Users/Agah/Desktop/neuropoly/qMRLab/External/AMICO/AMICO_matlab/exports/example/kernels/NODDI/A_054.mat'. No such file or directory.
	
	Error in AMICO_NODDI/ResampleKernels (line 118)
	load( fullfile( ATOMS_path, sprintf('A_%03d.mat',progress.i) ), 'lm' );
	
	Error in AMICO_ResampleKernels (line 48)
	CONFIG.model.ResampleKernels( fullfile(AMICO_data_path,CONFIG.protocol,'kernels',CONFIG.model.id), idx_OUT, Ylm_OUT );
	
	Error in amico/Precompute (line 140)
	AMICO_ResampleKernels();
	
	Error in FitData (line 49)
	if ismethod(Model,'Precompute'), Model = Model.Precompute; end
	
	Error in amico_batch (line 44)
	FitResults = FitData(data,Model,0);
	</pre><h2 id="9">c- show fitting results</h2><pre >         |- Output map will be displayed.
	|- If available, a graph will be displayed to show fitting in a voxel.
	|- To make documentation generation and our CI tests faster for this model,
	we used a subportion of the data (40X40X40) in our testing environment.
	|- Therefore, this example will use FitResults that comes with OSF data for display purposes.
	|- Users will get the whole dataset (384X336X224) and the script that uses it for demo
	via qMRgenBatch(qsm_sb) command.</pre><pre class="codeinput">FitResults_old = load(<span class="string">'FitResults/FitResults.mat'</span>);
	qMRshowOutput(FitResults_old,data,Model);
	</pre><h2 id="10">d- Save results</h2><pre >         |-  qMR maps are saved in NIFTI and in a structure FitResults.mat
	that can be loaded in qMRLab graphical user interface
	|-  Model object stores all the options and protocol.
	It can be easily shared with collaborators to fit their
	own data or can be used for simulation.</pre><pre class="codeinput">FitResultsSave_nii(FitResults, <span class="string">'amico_data/DiffusionData.nii.gz'</span>);
	Model.saveObj(<span class="string">'amico_Demo.qmrlab.mat'</span>);
	</pre><h2 id="11">V- SIMULATIONS</h2><pre >   |- This section can be executed to run simulations for amico.</pre><h2 id="12">a- Single Voxel Curve</h2><pre >         |- Simulates Single Voxel curves:
	(1) use equation to generate synthetic MRI data
	(2) add rician noise
	(3) fit and plot curve</pre><pre class="codeinput">      x = struct;
	x.ficvf = 0.5;
	x.di = 1.7;
	x.kappa = 0.05;
	x.fiso = 0;
	x.diso = 3;
	x.b0 = 1;
	x.theta = 0.2;
	x.phi = 0;
	Opt.SNR = 50;
	<span class="comment">% run simulation</span>
	figure(<span class="string">'Name'</span>,<span class="string">'Single Voxel Curve Simulation'</span>);
	FitResult = Model.Sim_Single_Voxel_Curve(x,Opt);
	</pre><h2 id="13">b- Sensitivity Analysis</h2><pre >         |-    Simulates sensitivity to fitted parameters:
	(1) vary fitting parameters from lower (lb) to upper (ub) bound.
	(2) run Sim_Single_Voxel_Curve Nofruns times
	(3) Compute mean and std across runs</pre><pre class="codeinput">      <span class="comment">%              ficvf         di            kappa         fiso          diso          b0            theta         phi</span>
	OptTable.st = [0.5           1.7           0.05          0             3             1             0.2           0]; <span class="comment">% nominal values</span>
	OptTable.fx = [0             1             1             1             1             1             1             1]; <span class="comment">%vary ficvf...</span>
	OptTable.lb = [0             1.3           0.05          0             1             0             0             0]; <span class="comment">%...from 0</span>
	OptTable.ub = [1             2.1           0.8           1             5             1e+03         3.1           3.1]; <span class="comment">%...to 1</span>
	Opt.SNR = 50;
	Opt.Nofrun = 5;
	<span class="comment">% run simulation</span>
	SimResults = Model.Sim_Sensitivity_Analysis(OptTable,Opt);
	figure(<span class="string">'Name'</span>,<span class="string">'Sensitivity Analysis'</span>);
	SimVaryPlot(SimResults, <span class="string">'ficvf'</span> ,<span class="string">'ficvf'</span> );
	</pre><p class="footer"><br ><a href="https://www.mathworks.com/products/matlab/">Published with MATLAB R2018a</a><br ></p></div>
