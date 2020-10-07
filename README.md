# CedarsHPC
This repository is used for running the analysis on Cedars-Sinai's High-Performance Cluster (HPC). https://riscc.csmc.edu/riscc/?_ga=2.152737466.2077473701.1600715593-822416260.1581018866#link-hpc
 - Access the cluster via MobaXterm SSH client using your credentials. To start a new session go to the sessions tab and start a new session. A session settings window will appear, in this window choose SSH, the Basic SSH settings next to the field Remote host enter csclprd3-s001v.csmc.edu, check Specify username checkbox and in the adjacent field enter your user id which is same as your Cedars universal login id. Once this is done press ok. Now in the MobaXterm terminal a tab will appear where your have to enter your password to start your session.     
 - Upload your functions, data and eeglab toolbox to the common folder of HPC. Any other toolboxes or functions should also go to the common folder.  
 - Upload the submit_ffc.sh file to your home folder on HPC. Any other .sh file should also go to the home folder.  
 - Type module load matlab in the HPC command line. Do this only once at the begining of your HPC session. 
 - To schedule a job use commands from Sun Grid Engine in the command line terminal of HPC. 
     - To submit a job type qsub submit_ffc.sh in the command line of HPC. 
     - To view the status of your job type qstat. If your job is not running this command will not return any outputs.
     - To view the number of cores available on HPC type qstat -f.
     - To view the details of your job type qstat -f -j yourjobnumber like qstat -f -j 65200
     - To view all the jobs running on the cluster type qstat -u \*
     - To delete a job enter qdel -j yourjobnumber like qdel -j 65200
 - Once your job starts you can exit your MobaXterm session. HPC will send you an email when your job is over or if there is any error. 
 - The output of the matlab command line can be visualize by typing, 
      - cat yourjobname.oYourjobnumber like FFC.o65200, to view the outputs.
      - cat yourjobname.eYourjobnumber like FFC.e65200, to view the errors.
