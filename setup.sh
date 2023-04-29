#!/usr/bin/env bash

echo "Installing in $INSTALL_DIR for $FPGA_FAM"
bash -c "source $INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh ; conda env create -f /f4pga-examples/$FPGA_FAM/environment.yml"
