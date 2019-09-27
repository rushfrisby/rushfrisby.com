At DEFCON this year there was a talk on CAN-BUS "Deep Learning" by Jun Li from Qihoo360 (a Chinese company). Jun is using data modeling to determine thresholds in the rate of change between CAN-BUS message values, and relationships between types of messages, in order to detect if a car is being hacked. Here is the same [talk from another conference on YouTube](https://www.youtube.com/watch?v=XBg8xhK7L0w) if you want to watch. His English isn't great but you can make out the points he is hitting on. His method, although well thought out, is flawed. There are too many scenarios in which his model cannot predict values for: weather conditions, wear & tear on parts, malfunctioning parts, and other external factors that affect vehicle performance.

After the talk a co-worker and I conferred on an idea we both came up with while Jun was presenting his. To illustrate the idea lets go over a vehicle thread model.

![Vehicle Threat Model: External Hacks](/img/post/threat_model_external.png)

The threat model above originated from the [Car Hacker's Handbook](http://opengarages.org/handbook/). I've highlighted in orange the two areas that are most concerning.

Connection A between the Infotainment system and the CAN-BUS network can be the most threatening if hacked. A hacker would be able to control things like RPM, speed, brakes, and steering. Your life is in great danger if you're in a moving car at the time it is hacked. Connection B between the KeyFob and the Immobilizer (keyless entry and remote start) means someone could easily steal your car if hacked. Both cases are pretty bad.

The idea I am thinking of only covers Connection A. Because an infotainment system should not be putting messages on the CAN-BUS about the engine or brakes we can introduce a filter on this connection. It would be a physical device that checks outgoing Infotainment messages before forwarding them on to the CAN-BUS network. All CAN-BUS messages have, as part of their header information, an identifier from which the message originated. The device will have a list of identifiers it will filter out. The reason why I think it should be a physical device, and not as part of the infotainment system, is so that it cannot be compromised in the same way an infotainment system can be compromised... you'd need psychical access to the vehicle in order to remove it. Here is a diagram illustrating the example:

![Vehicle Threat Message Sequence](/img/post/threat_msg_seq.png)

Connection B is a little bit tricky because it's hard to detect bad immobilizer messages. I'll have to think on it some more but it would be nice to protect that vulnerability as well.

Hacks originating from the ODBII port and TPMS will be so less common that it's not worth coming up with a solution for right now - although the ODBII port could use the same type of filter.

Please leave a comment if you think this should work differently!