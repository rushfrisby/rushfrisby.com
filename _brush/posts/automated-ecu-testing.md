At [Derive Systems](https://derivesystems.com/) we make devices for re-calibrating [Engine Control Units](https://en.wikipedia.org/wiki/Engine_control_unit" target="_blank) (ECUs). You may be familiar with our two brands: [SCT](https://www.sctflash.com) and [BullyDog](https://www.bullydog.com). There is a lot that goes into making devices. We design the hardware, write firmware and software, and do all of our own testing. Calibrating and reverse engineering ECUs is also a part of the process. Believe it or not the car tuning business is cut-throat so we do all of this in-house to prevent others from stealing our technology.

Recently I have moved away from the Software Team to start a Rapid Prototyping Team. The first project I have been tasked with is automating our testing process. Currently when a new version of our firmware is up for release, our Quality Assurance department bench tests a device on as many ECUs as possible. This process is slow, mundane, and prone to error. Luckily a co-worker, [Thomas Carter](https://www.linkedin.com/in/maverickideas), already had a prototype in the works for automating the testing process. I needed an electrical engineer for my team so I snatched him up. I was hesitant to write about what we've been doing until we made some progress, which we have, so I feel like I can share bits and pieces now. It's still far from complete so I will write a few more times about the project. On another note, this needs to work *better* than a prototype would, paradoxically, but it's not a project any other team is equipped to handle.

Primarily our devices support three main manufacturers: Ford, GM, and Dodge/Chrysler. For this reason we are separating tests by manufacturer. Each manufacturer will be on their own network ([CANBUS](https://en.wikipedia.org/wiki/CAN_bus)), have devices dedicated to them, and have the ability to be tested in parallel to other manufactures. We will launch initially on two devices: the [X4](https://www.youtube.com/watch?v=5qe2pDUoIDA) and the [BDX](https://www.youtube.com/watch?v=WNNUWgMIuOU), and add support for the [GTX](https://www.youtube.com/watch?v=LHPYipPfKG0) later in the year. Over 150 ECUs will be connected initially. Support for additional manufacturers and an increased number of ECUs will come later in the year as well.

**Our goal is to run tests on all ECUs within a few hours.** Here is a rough diagram of how I've designed the system. It can take up to 15 minutes to update an ECU so we will be bumping up our hardware count to reduce the overall testing time to meet our goal.

![Automated ECU Design Diagram](/img/ecu/Automated-ECU-Design-Diagram.png)

The Server consists of a self-hosted SignalR service and a WCF service. This allows us to push commands to our control units (Raspberry Pis) and Web UI. It also allows us to pull data when we need. We will manage the server through a web interface and store everything in SQL Azure. The Server and Web UI are also running in Azure.

The Raspberry Pis are running the latest build of Windows 10 IoT. They startup with a UI app that simply displays the video feed from a camera mounted over our device. A SignalR client runs in the background ready to accept commands from the server. Connected to the Raspberry Pi over USB is a camera, micro controller which activates solenoids (does the button presses on our device), and to an I2C power relay controller (for powering ECUs) because we can't power over 150 ECUs at one time. Not all of this is shown in the diagram. For the device, camera, and selenoids, Thomas created a holder which he 3D printed. Here is what everything looks like put together.

![Device holder and solenoids](/img/ecu/Automated-ECU-Device-Holder.jpg)

And here is the Raspberry Pi. There is a 7" touch panel display facing down and our solenoid controller hat on top.

![Raspberry Pi controller](/img/ecu/Automated-ECU-Rpi.jpg)

Both of these will get mounted to a wall in a room dedicated to ECU testing. The room is 20x10. All of the power and devices will be mounted on the back wall. The side walls will have floor to ceiling shelving for holding the ECUs. The fourth wall is glass. It will be somewhat of a showpiece when it's finished. It's currently under construction...

![Room construction](/img/ecu/Automated-ECU-Room-Construction.jpg)

The walls will be painted dark grey and a thin band of LED lights will encircle the room. The main lights will almost never be on because it won't get any foot traffic. Tomorrow the glass wall is supposed to be installed. The floor will be covered with leftover carpet we have in storage.

This is where we currently keep the ECUs. Some are checked-out or missing but in total there is just over 150. We will be adding another 50 or so this year.

![Current storage closet](/img/ecu/Automated-ECU-Storage-Closet.jpg)

More to come over the next few weeks... stay tuned!

See also: [Part 2](/automated-ecu-testing-part-2) | [Part 3](/automated-ecu-testing-part-3/)
