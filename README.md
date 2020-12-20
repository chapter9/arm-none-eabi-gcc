# arm-none-eabi-gcc
A Docker container to work with STM32

## Build Image
You can build the docker image using:

    docker build --build-arg VERSION=1.1 -t chapter9/arm-none-eabi-gcc:latest .


## Build Code
You can make a project using gcc using:

    docker run --rm -v $PWD:/usr/src/myapp -w /usr/src/myapp chapter9/arm-none-eabi-gcc:latest make -j 12


## Remote debugging:
You can remote debug a project using:

    docker run -i --rm -v $PWD:/usr/src/myapp -w /usr/src/myapp -p 3333:3333 --cap-add=SYS_PTRACE --security-opt seccomp=unconfined chapter9/arm-none-eabi-gcc:latest sh -c arm-none-eabi-gdb

Using the following commands to expose the debugger:

    target extended-remote host.docker.internal:3333
    monitor reset halt
    monitor adapter speed 4000
    load build/F303K8Tx_SPI.elf
    monitor adapter speed 4000

## Visual Studio Code remove debugging:

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Docker - OpenOCD Debug",
            "type": "cppdbg",
            "request": "launch",
            "program": "build/F303K8Tx_SPI.elf",
            "args": [],
            "stopAtEntry": true,
            "cwd": "/usr/src/myapp",
            "environment": [],
            "externalConsole": true,
            "sourceFileMap": { 
                "/usr/src/myapp": "${workspaceFolder}" 
            },
            "pipeTransport": {
                "pipeCwd": "${workspaceFolder}",
                "pipeProgram": "docker",
                "pipeArgs": [
                    "run",
                    "-i",
                    "--rm",
                    "-v","${workspaceFolder}:/usr/src/myapp",
                    "-w","/usr/src/myapp",
                    "-p","3333:3333",
                    "--cap-add=SYS_PTRACE",
                    "--security-opt","seccomp=unconfined",
                    "chapter9/arm-none-eabi-gcc:latest",
                    "sh","-c"
                ],
                "debuggerPath": "arm-none-eabi-gdb"
            },
            "MIMode": "gdb",
            "setupCommands": [
                { "text": "target extended-remote host.docker.internal:3333" },
                { "text": "monitor reset halt" },
                { "text": "monitor adapter speed 4000" },
                { "text": "load build/F303K8Tx_SPI.elf" },
                { "text": "monitor adapter speed 4000" },
            ],
        },
   ]
}
```