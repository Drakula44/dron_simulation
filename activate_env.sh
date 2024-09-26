conda activate pfe-dron
chmod +x ~/.conda/envs/pfe-dron/share/gazebo/setup.sh
export CONDA_ENV_PATH=~/miniconda/envs/pfe-dron
source $CONDA_ENV_PATH/share/gazebo/setup.sh
export PYTHONPATH="${PYTHONPATH}:$HOME/pfe-dron/gz-msgs/python-proto"
export GAZEBO_MODEL_PATH=~/pfe-dron/ardupilot_gazebo/models:${GAZEBO_MODEL_PATH}
export GAZEBO_MODEL_PATH=~/pfe-dron/ardupilot_gazebo/models_gazebo:${GAZEBO_MODEL_PATH}
export GAZEBO_RESOURCE_PATH=~/pfe-dron/ardupilot_gazebo/worlds:${GAZEBO_RESOURCE_PATH}
export GAZEBO_PLUGIN_PATH=~/pfe-dron/ardupilot_gazebo/build:${GAZEBO_PLUGIN_PATH}