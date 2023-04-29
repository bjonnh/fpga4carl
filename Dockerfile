FROM ubuntu:22.04
RUN apt-get -y update && apt-get -y install git build-essential wget xz-utils
RUN git clone https://github.com/chipsalliance/f4pga-examples
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda_installer.sh
ENV F4PGA_INSTALL_DIR=/opt/f4pga
ENV FPGA_FAM=xc7
RUN chmod +x ./conda_installer.sh
RUN ./conda_installer.sh -u -b -p $FPG4A_INSTALL_DIR/$FPGA_FAM/conda
RUN bash -c "source $FPG4A_INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh ; conda env create -f /f4pga-examples/$FPGA_FAM/environment.yml"
RUN mkdir -p $FPG4A_INSTALL_DIR/xc7/install
ENV F4PGA_PACKAGES='install-xc7 xc7a50t_test xc7a100t_test xc7a200t_test xc7z010_test'
RUN mkdir -p $F4PGA_INSTALL_DIR/$FPGA_FAM
ENV F4PGA_TIMESTAMP='20220920-124259'
ENV F4PGA_HASH='007d1c1'
RUN for PKG in $F4PGA_PACKAGES; do wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/${F4PGA_TIMESTAMP}/symbiflow-arch-defs-${PKG}-${F4PGA_HASH}.tar.xz | tar -xJC $F4PGA_INSTALL_DIR/${FPGA_FAM} ; done
RUN echo "FPGA_FAM=\"xc7\"\n export FPG4A_INSTALL_DIR=/opt/f4pga\nexport PATH=\"$FPG4A_INSTALL_DIR/$FPGA_FAM/install/bin:$PATH\"\n source \"$FPG4A_INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh\"\n conda activate $FPGA_FAM" >> /root/.bashrc
WORKDIR f4pga-examples/xc7
