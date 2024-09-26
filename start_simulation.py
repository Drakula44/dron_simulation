import subprocess
import os


def enable_tmux_mouse_support():
    # Path to the user's home directory and tmux config file
    tmux_conf_path = os.path.expanduser("~/.tmux.conf")

    # Configuration to enable mouse support
    mouse_support_config = "\nset -g mouse on\n"

    # Append the mouse configuration to the tmux.conf file
    with open(tmux_conf_path, "a") as tmux_conf_file:
        tmux_conf_file.write(mouse_support_config)

    # Reload tmux config
    os.system("tmux source-file ~/.tmux.conf")


# Function to run a command in tmux
def run_in_tmux(pane_id, command):
    subprocess.run(f'tmux send-keys -t {pane_id} "{command}" C-m', shell=True)


run_gazebo = "source activate_env.sh && gazebo --verbose ~/pfe-dron/ardupilot_gazebo/worlds/iris_ardupilot.world"
run_ardupilot = "source activate_env.sh && cd ~/pfe-dron/ardupilot/Tools/autotest && ./sim_vehicle.py -v ArduCopter -f gazebo-iris --console -I0"
run_camera = "source activate_env.sh && cd ~/pfe-dron/ && python camera.py"
run_drone_control = (
    'source activate_env.sh && cd ~/pfe-dron/ && echo "run: python drone_control.py"'
)


def main():
    enable_tmux_mouse_support()

    # chekc if there is already a tmux session running
    subprocess.run("tmux kill-session -t mysession", shell=True)

    # Start a new tmux session
    subprocess.run("tmux new-session -d -s mysession", shell=True)

    # Create a 2x2 grid
    subprocess.run(
        "tmux split-window -h", shell=True
    )  # Split horizontally to create two panes side by side
    subprocess.run(
        "tmux split-window -v", shell=True
    )  # Split vertically on the left pane to create two panes
    subprocess.run("tmux select-pane -t 0", shell=True)  # Focus on the first pane
    subprocess.run(
        "tmux split-window -v", shell=True
    )  # Split vertically on the right pane to create four panes

    # Run different commands in each pane
    run_in_tmux("mysession:0.0", run_gazebo)
    run_in_tmux("mysession:0.1", run_ardupilot)
    run_in_tmux("mysession:0.2", run_camera)
    run_in_tmux("mysession:0.3", run_drone_control)
    # Attach to the tmux session to view the output
    subprocess.run("tmux attach-session -t mysession", shell=True)


if __name__ == "__main__":
    main()
