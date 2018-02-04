import os
import subprocess
from fnmatch import fnmatch
import urllib
import tarfile


subprocess.call(['/bin/bash', '-c', 'echo "nameserver 8.8.8.8" >> /etc/resolv.conf'])
subprocess.call(['/bin/bash', '-c', 'chown agraph. /data/load.py && chmod u+x /data/load.py'])

