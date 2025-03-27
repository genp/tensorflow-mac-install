#!/usr/bin/env zsh
# Install TensorFlow with Metal support on macOS
# This script installs the required dependencies and sets up a virtual environment for TensorFlow with Metal support.
# Check if the script is run as root
if [ "$EUID" -eq 0 ]; then
    echo "Please do not run this script as root."
    exit 1
fi
# Set venv name as variable
venv_name="tf-metal"
# Check if the virtual environment already exists
if [ -d "$HOME/.venv/$venv_name" ]; then
    echo "Virtual environment '$venv_name' already exists. Please remove it before running this script."
    exit 1
fi
python3 -m venv "$HOME/.venv/$venv_name"
source "$HOME/.venv/$venv_name"/bin/activate
"$HOME/.venv/$venv_name"/bin/python -m pip install -U pip
# install tensorflow
"$HOME/.venv/$venv_name"/bin/pip install tensorflow
# install tensorflow-metal for GPU support
"$HOME/.venv/$venv_name"/bin/pip install tensorflow-metal

# Add the virtual environment to the available kernels
"$HOME/.venv/$venv_name"/bin/pip install ipykernel
"$HOME/$venv_name"/bin/ipython kernel install --name "$venv_name" --user
"$HOME/.venv/$venv_name"/bin/python3 -m ipykernel install --user --name="$venv_name" --display-name="Python ($venv_name)"

# run a test script
echo "Running a test script to verify the installation..."
chmod +x test_tf.py
test_tf.py




