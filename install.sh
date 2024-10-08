

conda env create
conda activate pfe-dron
if [ -d "miniconda3" ]; then
    export CONDA_ENV_PATH=$HOME/miniconda3/envs/pfe-dron
else
    export CONDA_ENV_PATH=$HOME/.conda/envs/pfe-dron
fi
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$CONDA_ENV_PATH/lib/pkgconfig
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
git checkout ign-msgs8
mkdir python-proto
protoc -I=proto --python_out=python-proto proto/ignition/msgs/*
export PYTHONPATH=$PYTHONPATH:$PWD/python-proto
cd ..

source activate_env.sh