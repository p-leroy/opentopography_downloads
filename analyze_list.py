import os

from joblib import Parallel, delayed

import pandas as pd

from lidar_platform import misc

import time


# This one will only work if you installed AWS tools and if they are available from a terminal
def download(path, odir, verbose=False, debug=False):
    """ Download one file from OpenTopography

    :param path: OpenTopography path
    :param odir: The directory where the fil will be stored
    :param verbose:
    :param debug:
    :return:
    """
    
    if not os.path.exists(odir):  # Create odir if needed
        print(f"Create odir as it does not exist {odir}")
        os.makedirs(odir, exist_ok=True)

    cmd = [  # Build the command for later execution
        "aws",
        "s3",
        "cp",
        "s3://pc-bulk/" + path,
        odir,
        "--endpoint-url",
        "https://opentopography.s3.sdsc.edu",
        "--no-sign-request"
    ]

    misc.run(cmd, advanced=True, verbose=verbose)

# it is possible to download the list of available files following bulk download CLI samples provided by OpenTopography
# aws s3 ls s3://pc-bulk/NZ20_Hawkes/ --recursive --endpoint-url https://opentopography.s3.sdsc.edu --no-sign-request  | Out-File NZ20_Hawkes.txt
list_of_all_files = r".\NZ24_Whanganui.txt"
odir = r"C:\DATA\000_Sophie_Rothman\Downloads"


#%% Open the result of the 'List all files example:' of OpenTopography
data = pd.read_csv(list_of_all_files,
                   sep='\s+',
                   encoding='utf-16',
                   names=["date", "time", "size", "path"])

#%% Compute the total size, for all the files (374 GB!)
total = data['size'][:].sum()
total_MB = total / 1e6
total_GB = total / 1e9

#%%
download(data['path'][0], odir, verbose=True)

#%% 336 seconds for 200 (100 laz + 100 lax)
start = time.time()
Parallel(n_jobs=10)(delayed(download)(path, odir, verbose=True) for path in data['path'][0:200])
end = time.time()
print(f"Execution time: {end - start:.6f} seconds")
