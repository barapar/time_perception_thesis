"""
This script runs transformation from IMA to BIDS with dcm2niix
"""

import os
from os.path import join as opj

# path to the raw data
data_path = '/media/lisz/HD710\ PRO/fmri_time'
# the path tp the data folder
out_dir = '/home/lisz/Desktop/Time_project/time_fmri/data'
# input subject number
sub = input("Plese enter subject number: ") # sub-05

def ima_to_bids(sub):
    """
    run dcm2niix for one subject
    """
    # create a new folfer for a new subject
    os.mkdir(opj(out_dir, sub)) 
    os.mkdir(opj(out_dir, sub, "anat")) # add there a folder "anat"
    os.mkdir(opj(out_dir, sub, "func"))
    print(opj(out_dir, sub))
    # run dcm2niix
    os.system(f'dcm2niix \
                -z y \
                -f %f_%p \
                -o {out_dir}/{sub} \
                {data_path}/{sub}')

ima_to_bids(sub)
