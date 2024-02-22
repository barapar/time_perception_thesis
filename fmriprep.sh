"""
This script runs fmriprep through docker
"""

for sub in sub-02
do
	echo Preprocessing $sub
	fmriprep-docker /home/lisz/Desktop/Time_project/time_fmri/data \
									/home/lisz/Desktop/Time_project/time_fmri/data/derivatives/preprocess \
									participant \
									--------participant-label ${sub} \
									--fs-license-file /home/lisz/Desktop/Time_project/time_fmri/license.txt
done
