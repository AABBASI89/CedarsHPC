# CedarsHPC
This repository is used for running the analysis on Cedars's High-Performance Cluster (HPC). https://riscc.csmc.edu/riscc/?_ga=2.152737466.2077473701.1600715593-822416260.1581018866#link-hpc
 - Access the cluster via MobaXterm SSH client using your credentials. 
 - Upload your functions, data and eeglab toolbox to the common folder of HPC. Any other toolboxes or function should go to this common folder.  
 - Upload the submit_ffc.sh file to your home folder on HPC. Any .sh file should go to the home folder.  
 - Type module load matlab in the HPC command line. Do this only once every time you log-in to HPC. 
 - To schedule a job use commands from Sun Grid Engine in the command line terminal of HPC. 
     - To submit a job use qsub submit_ffc.sh in the command line of HPC. 
     - To view the status of your job use qstat. If your job is not running this command will not return any output.
     - To view the number of cores available on HPC use qstat -f.
     - To view the details of your job use qstat -f -j yourjobnumber like qstat -f -j 65200
     - To view all the jobs running on the cluster use qstat -u \*
 - Once your job starts you can exit your MobaXterm session. HPC will send you an email when your job is over or if there is an error. 
 - The output of the matlab command line can be visualize by entering 
      - cat yourjobname.oYourjobnumber like FFC.o65200, to view the outputs.
      - cat yourjobname.eYourjobnumber like FFC.e65200, to view the errors.
