# Spike2_Burst_Analysis
Get bursts from .abf (pClamp) files using Spike2 scripts. Do further analysis in Matlab
Some of the scripts were written by Dirk Bucher. Other relevant Spike2 scripts can be found at his website:
http://stg.rutgers.edu/Resources.html

Here is the work throughput for these scripts:

Make folder of .abf files for analysis
Make sure that .abf files are of type ABF1 (Integer). This is not the default for all versions of pClamp
If this is not the case take the following steps below, otherwise skip the next section

Convert .abf files to: type ABF1 (Integer)
---------------------------------------------------------------------------
Install:

Digidata 1550/1550A and 1440A users:
Download pCLAMP software version 10.5.2.6
from:

http://mdc.custhelp.com/app/answers/detail/a_id/18779/~/axon%E2%84%A2-pclamp%E2%84%A2-10-electrophysiology-data-acquisition-%26-analysis-software

if you don't already have it.

In Clampfit:

File
-New Data File Index
   Under look in specify a folder with the files that you wish to analyse then select ok

Select all files that are opened then:

File
-Export File
  Designate where files should be exported to. Make sure that

Inline image 1 is selected, then press ok. 

Files should now be of a form that Spike2 can use.
---------------------------------------------------------------------------

In Spike2:
>Script>Run Script>Load and Run
-Select batchImp.s2s
-Select folder of .abf files

>Script>Run Script>Load and Run
-Select newsuperscript.s2s

Choose start time (0, unless you have already run newsuperscript.s2s on other files in this directory)
Choose Experiment Name (Keep consisten if you have already run newsuperscript.s2s on other files in this directory)
-Select .smr file created by batchImp.s2s
Choose which neurons to analyze

Drag thresholds and cutoffs to appropriate channel
click ok (top right)
Can subtract spikes from one channel which appear around another in Spike Subtractions within a specified window
-click 'Do Subtractions'
-If unsatisfied click  'Start File Over' (This option can also be selected after 'Done. Ready for Bursts' as 'Restart File')
-If satisfied click 'Done. Ready for Bursts'
-To change spike interval or number pulled from click 'Revise Bursts
-When completely satisfied click 'Log Data'

After newsuperscript.s2s has run through all files bursts should be ready for analysis in Matlab
-------------------------------------------------------------------------------------------------

get_bursts.m - Can be used to pull information about all bursts by neuron

spike2_to_mat.m - Used to separate bursts by file and collect several burst parameters. Uses get_bursts.m

scatter_plotter.m - Plot relevant burst parameters by file (Used after spike2_to_mat.m)

herrorbar.m - Used with T_phases.m below to plot phase error bars.

T_phases.m - Used to plot phase plots. Will require reformatting based on number of files to plot for. Uses herrorbar.m
