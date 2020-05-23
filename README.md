# RRSG/qMRSG 2020 ISMRM Challenge - T1 mapping processing pipeline

## Processed T1 maps

The processed T1 maps have been uploaded in the [RRSG/qMRSG 2020 ISMRM Challenge OSF.io repository](https://osf.io/ywc9g/), under the folder `challenge_t1_maps`. The folders are organised in the same structure as the `challenge_submissions` folder, which contain the raw data. Each T1 map zip file contains 1) T1 maps, 2) YAML/JSON configuration files that contain the challenge submissions details, 3) T1 maps saved as PNG images for quality assurance purposes, and 4) a text file with the link to the raw data used to fit the accompanying T1 map.

## Running this pipeline with CodeOcean

Coming soon.

## Environment setup instructions to run notebook

These instructions were tested on a Macbook, and will likely be identical for Linux. The syntax for Windows might be different, depending on the shell you're using to install the Python packages. The shell that comes with [Anaconda](https://www.anaconda.com/products/individual) would likely work well.

* Clone or download this GitHub repository

**(Recommended) Create a [conda](https://docs.conda.io/en/latest/) virtual environment.**
* `conda create -n sos_matlab python=3.6`
* `conda activate sos_matlab`
* `conda install ipython=7.2.0`

**Setup the MATLAB Engine API for Python**
* `cd /Applications/MATLAB_R2018b.app/extern/engines/python/`
  * Replace `MATLAB_R2018b.app` with whatever version of MATLAB you have.
* `python setup.py install`

**Install neessary Python packages**

* `pip install sos==0.21.6 sos-bash==0.12.3 sos-javascript==0.9.12.2 sos-julia==0.9.12.1 sos-matlab==0.18.4 sos-notebook==0.21.9 sos-python==0.9.12.1 sos-r==0.9.12.2 sos-ruby==0.9.15.0 sos-sas==0.9.12.3 scipy numpy imatlab;`

**Install the MATLAB and SOS Jupyter kernels**
* `python -mimatlab install`
* `python -m sos_notebook.install`

**Start a Jupyter session**
* `jupyter notebook RRSG_T1_fitting.ipynb`
* Choose the configuration file you want to use in the first cell
* Run all cells

## GIFs of T1 maps for datasets

### 3T - Human

![](./gifs/3T_human.gif)

### 3T - NIST

![](./gifs/3T_NIST.gif)
