ARG VERSION=1.0

FROM archlinux/base:latest
EXPOSE 3333
ARG VERSION
WORKDIR /usr/src/myapp
RUN pacman -Syu --noconfirm && pacman --noconfirm -S \
    arm-none-eabi-binutils \
    arm-none-eabi-newlib \
    arm-none-eabi-gcc \
    arm-none-eabi-gdb \
    make
ENV CC="arm-none-eabi-gcc"
ENV AS="arm-none-eabi-gcc -x assembler-with-cpp"
ENV CP="arm-none-eabi-objcopy"
ENV SZ="arm-none-eabi-size"
ENV HEX="$(CP) -O ihex"
ENV BIN="$(CP) -O binary -S"
