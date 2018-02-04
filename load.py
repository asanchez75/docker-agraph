import os
import subprocess
from fnmatch import fnmatch
import urllib
import tarfile

filename = 'rdf_output'

print "downloading file..."
print "http://lprapp14.fao.org/agris_data/LOD/" + filename + ".tar.gz"


urllib.urlretrieve("http://lprapp14.fao.org/agris_data/LOD/" + filename + ".tar.gz", "/data/" + filename + ".tar.gz")
tar = tarfile.open("/data/" + filename + ".tar.gz")
tar.extractall(path="/data")
tar.close()


print "loading data..."

root = '/data/RDF_Output'
pattern = '*'
for dirpath, dirnames, filenames in os.walk(root):
    for filename in [f for f in filenames if f.endswith(".rdf")]:
        filepath =  os.path.join(dirpath, filename)
        filename, file_extension = os.path.splitext(filepath)
        subprocess.call(['/app/agraph/bin/agload', 'agris', filepath])



