

conda env create
conda activate pfe-dron
# check if ardupilot is cloned
if [ -d "ardupilot" ]; then
    echo "ardupilot is already cloned"
else
    git clone https://github.com/ArduPilot/ardupilot.git
fi

cd ardupilot
git submodule update --init --recursive
alias waf="$PWD/modules/waf/waf-light"
waf configure --board=sitl
waf all
cd ..

if [ -d "ardupilot_gazebo" ]; then
    echo "ardupilot_gazebo is already cloned"
else
    git clone https://github.com/SwiftGust/ardupilot_gazebo
fi
cd ardupilot_gazebo
# check if build folder exists
if [ -d "build" ]; then
    rm -rf build
fi
mkdir build
cd build
cmake ..
make -j2
sudo make install

cd ../../
if [ -d "gz-msgs" ]; then
    echo "gz-msgs is already cloned"
else
    git clone https://github.com/gazebosim/gz-msgs
fi

cd gz-msgs
if [ -d "python-proto" ]; then
    rm -rf python-proto
fi
mkdir python-proto
protoc -I=proto --python_out=python-proto proto/ignition/msgs/*.proto
export PYTHONPATH=$PYTHONPATH:$PWD/python-proto
cd ..

source activate_env.sh