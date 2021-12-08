# Xorg

## Introduction

!!! note
    Available only for Karolina accelerated nodes acn[01-72] and vizualization servers viz[1-2]

Some applications (e.g. Paraview, Ensight, Blender, Ovito) require not only visualization but also computational resources such as multiple cores or multiple graphics accelerators. For the processing of demanding tasks, more operating memory and more memory on the graphics card are also required. These requirements are met by all ACN nodes on the Karolina cluster, which are equipped with eight graphics cards with 40GB GPU memory and 1TB CPU memory. To run properly, it is required to have the Xorg server running and the VirtualGL environment installed.

## Xorg

[Xorg][a] is a free and open source implementation of the X Window System imaging server maintained by the X.Org Foundation. Client-side implementations of the protocol are available, for example, in the form of Xlib and XCB. While Xorg usually supports 2D hardware acceleration, 3D hardware acceleration is often missing. With hardware 3D acceleration, 3D rendering uses the graphics processor on the graphics card instead of taking up valuable CPU resources when rendering 3D images. It is also referred to as hardware acceleration instead of software acceleration because without this 3D acceleration, the processor is forced to draw everything itself using the Mesa software rendering libraries, which takes up quite a bit of computing power. There is a VirtualGL package that solves these problems.

## VirtualGL

[VirtualGL][b] is an open source software package that redirects 3D rendering commands from Linux OpenGL applications to 3D accelerator hardware in a dedicated server and sends the rendered output to a client located elsewhere on the network. On the server side, VirtualGL consists of a library that handles the redirection and a wrapper that instructs applications to use the library. Clients can either connect to the server using a remote X11 connection, such as a VNC server. In the case of an X11 connection, some VirtualGL software is also required on the client side to receive the rendered graphical output separately from the X11 stream. In the case of VNC connections, no specific client-side software is needed other than the VNC client itself. VirtualGL works seamlessly with headless NVIDIA GPUs (Ampere, Tesla).

## Running Paraview With GUI and Interactive Job on Karolina

1. Run [VNC environment][1]

1. Run terminal in VNC session:

    ```console
    [loginX.karolina]$ gnome-terminal
    ```

1. Run interactive job in gnome terminal

    ```console
    [loginX.karolina]$ qsub -q qnvidia -l select=1 -IX -A OPEN-XX-XX -l xorg=True
    ```

1. Run Xorg server

    ```console
    [acnX.karolina]$ Xorg :0 &
    ```

1. Load VirtualGL:

    ```console
    [acnX.karolina]$ ml VirtualGL
    ```

1. Find number of DISPLAY:

    ```console
    [acnX.karolina]$ echo $DISPLAY
    localhost:XX.0 (for ex. localhost:50.0)
    ```

1. Load ParaView:

    ```console
    [acnX.karolina]$ ml ParaView
    ```

1. Run ParaView:

    ```console
    [acnX.karolina]$ DISPLAY=:XX vglrun paraview
    ```

!!! note
    It is not necessary to run Xorg from the command line on the visualization servers viz[1-2]. Xorg runs without interruption and is started when the visualization server boots.<br> Another option is to use [vglclient][2] for visualization server.

## Running Blender (Eevee) on the Background Without GUI and Without Interactive Job on Karolina

1. Download and extract Blender and Eevee scene:

    ```console
    [loginX.karolina]$ wget https://ftp.nluug.nl/pub/graphics/blender/release/Blender2.93/blender-2.93.6-linux-x64. tar.xz ; tar -xvf blender-2.93.6-linux-x64.tar.xz ; wget https://download.blender.org/demo/eevee/mr_elephant/mr_elephant.blend
    ```

1. Create a running script:

    ```console
    [loginX.karolina]$ echo 'Xorg :0 &' > run_eevee.sh ; echo 'cd' $PWD  >> run_eevee.sh  ; echo 'DISPLAY=:0  ./blender-2.93.6-linux-x64/blender --factory-startup --enable-autoexec -noaudio --background ./mr_elephant.blend --render-output ./#### --render-frame 0' >> run_eevee.sh ; chmod +x run_eevee.sh
    ```

1. Run job from terminal:

    ```console
    [loginX.karolina]$ qsub -q qnvidia -l select=1 -A OPEN-XX-XX -l xorg=True ./run_eevee.sh
    ```

[1]: ./vnc.md
[2]: ../../../software/viz/vgl.md

[a]: https://www.x.org/wiki/
[b]: https://virtualgl.org/
