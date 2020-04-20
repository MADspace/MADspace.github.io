---
layout: project
title: MADspace Door
---

# MADspace Door

### Status

This project has been abandoned, as it was related to the fysical entrance door of the building, but we have moved to a different location.

### Project Description

We managed to get the magnetic lock on the front door operational again.

There are 2 8-wire cables (red, blue, green, yellow, 4x white) running from the reception desk to the front door. They are probably ordinary UTP cables. One of the cables runs though the mailbox to the door bell/intercom unit. The other cable goes to the magnetic lock.

The doorbell is wired as:

  * 9V net adapter (at reception desk)
  * UTP cable (2 wires)
  * Door bell (just wired to the button switch, nothing else is connected)
  * UTP cable (2 wires)
  * Bell (intercom unit, only has 2 wires, don't know if there are more connectors insode)
  * Back to net adapter

The magnetic lock is wired as:
  * 24V net adapter (at reception desk)
  * UTP cable (2 pairs, each pair wired together to allow for larger current)
  * Magnetic lock
  * UTP cable (2 pairs, each pair wired together to allow for larger current)
  * Back to net adapter

Obviously without having the adapter plugged in. There is no switch included in this circuit. There is a switch at the reception desk, but it is currently not connected to anything.

The magnetic lock itself has two coils (electromagnets), currently wired in parallel. But by adjusting jumpers, they can be set in series. There are also 2 capacitors on the pcb, probably for reducing current spikes when switching on/off power.

I actually expect that coils in series is for 24V and coils in parallel for 12V. So we should use a 12V supply, or adjust the jumpers for 24V. This indeed [seemed likely](https://en.wikipedia.org/wiki/Magnetic_lock#Electrical_Requirements). However, with 24V and the coils in series, the holding force of the magnet was very weak, so we kept the parallel configuration.

There are 2 unused twisted pairs running to the door lock, which allows to easily extend the setup (e.g. door sensor + status led + button; or power + RS485 to a microcontroller).

### Control the door with the magnetic lock

Now that we have a working magnetic lock, we still have to solve some issues before we can use this lock:

* Safety: there must always be a clear way to open the door from the inside. Also when the software (if any) or power fails.
* The regular (mechanical) lock must be somehow disabled while the maglock is in use (otherwise people still cannot get in…)
* Other inhabitants should still be able to get in while the maglock is used (they probably don't like having to ring our bell and wait for us to open the door to get to their own office).

The first item can easily be solved with an emergency and/or request-to-exit button that simply cuts the power to the maglock.

The second one is also not difficult: block the latch in open position by sticking something into the door, or by covering the matching hole in the frame with something.

The last one is tricky. We could of course try to contact all others that need contact and give them login codes/rfid-tokens/pin-codes/whatever to be able to open the lock. But this will likely annoy them (since the maglock-system will only occasionally replace the regular mechanical lock system – when the space is open – as the maglock is not suitable to provide 24/7 security).

Fortunately, we came up with a nice hack that solves all three issues in one go. The idea is to have a cover plate to cover the hole the latch would normally fall into. The spring-loaded latch will be pushing against this plate, but it won't lock the door mechanically. Now we make sure that this cover plate is of a non-conductive material and we place two conductive contacts on it. When the door is closed, the latch, which is made of conductive metal, will short circuit these two contacts. Now we have a switch that we include in the circuit.

Now, with the door closed, the circuit is also closed, so the maglock is keeping the door shut. Now, if someone operates the door handle at the inside, he/she will retract the latch, which breaks the circuit, so the lock will open. This provides a very natural interface to unlock the door, no need for any buttons at all. Also, when other inhabitants want to enter from the outside and use their key, they will also retract the latch and the door will unlock. They'll hardly notice that the maglock is in use. As a nice bonus, when closing the door, the maglock becomes only active at the very last moment, when the latch shorts the contacts on the cover plate. This makes the door lock itself with a simple click in stead of a loud bang (the door and frame are made of metal).

This idea has been successfully implemented with a prototype made of wood and some copper wire. (Pictures will follow).

What's still left to do:

* Run proper cabling and add a some socket + plug, such that the cover plate can be easily installed and removed.
* Insert a relay switch in the circuit, such that we can also unlock the door via software.

*Note: Beware that this design is not very secure (although it's good enough for our situation).*

### Key sharing

For the key management issue, I believe an electronic key safe is a good option (sturdy box that, after proper auth, can give you the key to open the door in the normal way. When leaving, you put the key back into the box). The mailbox slot seems a suitable interface for this (already gives basic vandalism/burglar-resistance).

### Authorization

In this area, only some wild initial ideas:

* presence of WLAN/bluetooth MAC near the door
* RFID tags
* pin-code on keypad
* login on webpage (using mobile internet, or WLAN of our space)
* fingerprint reader
* …

Can be used for both the maglock and the key safe. Maglock can initially be just controlled using a switch inside the space.

### Online Space Status

We want to announce when the space is open on the internet. Most easy is to install a physical switch for this (but with the risk that people forget to toggle it). We can create more advanced setups later (e.g. connect to door lock system).

Announcement of open/close status should be on our own website, on IRC, and on hackerspaces.nl (via [SpaceAPI](http://hackerspaces.nl/spaceapi/)).



