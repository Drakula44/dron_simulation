conda activate pfe-dron
export CONDA_ENV_PATH=~/miniconda3/envs/pfe-dron
chmod +x $CONDA_ENV_PATH/share/gazebo/setup.sh
source $CONDA_ENV_PATH/share/gazebo/setup.sh
export PYTHONPATH="${PYTHONPATH}:$HOME/pfe-dron/gz-msgs/python-proto"
export GAZEBO_MODEL_PATH=~/pfe-dron/ardupilot_gazebo/models:${GAZEBO_MODEL_PATH}
export GAZEBO_MODEL_PATH=~/pfe-dron/ardupilot_gazebo/models_gazebo:${GAZEBO_MODEL_PATH}
export GAZEBO_RESOURCE_PATH=~/pfe-dron/ardupilot_gazebo/worlds:${GAZEBO_RESOURCE_PATH}
export GAZEBO_PLUGIN_PATH=~/pfe-dron/ardupilot_gazebo/build:${GAZEBO_PLUGIN_PATH}