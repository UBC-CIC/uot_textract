#
# lambda.sh
# For Linux Environment 

# Clean up before starting
rm -rf env/
rm -rf package/
rm function.zip

# Build poppler
rm -rf poppler_binaries/
./build_poppler.sh

# Make a virtualenv
python3.8 -m venv env/
source env/bin/activate

# Creating the package
mkdir -p package
pip3.8 install pdf2image --target package/
pip3.8 install pypdf4 --target package/

# Moving the poppler libraries in the package
cp -r poppler_binaries/ package/

# Moving the function in the package 
cp index.py package/

# Zipping the package
cd package
zip -r9 ../function.zip *
cd ..

# Deleting package artifacts
rm -rf package/

# Updating lambda function
aws lambda update-function --function-name $LAMBDANAME --zip-file fileb://function.zip
