# Asynchronous-FIFO

Design and Verification of Asynchronous FIFO using System Verilog/UVM
FIFOs are often used to safely pass data from one clock domain to another asynchronous clock domain. Using a
FIFO to pass data from one clock domain to another clock domain requires multi-asynchronous clock design
techniques. There are many ways to design a FIFO wrong. There are many ways to design a FIFO right but still
make it difficult to properly synthesize and analyze the design.
This paper will detail one method that is used to design, synthesize and analyze a safe FIFO between different clock
domains using Gray code pointers that are synchronized into a different clock domain before testing for "FIFO full"
or "FIFO empty" conditions.

An asynchronous FIFO refers to a FIFO design where data values are written to a FIFO buffer from one clock
domain and the data values are read from the same FIFO buffer from another clock domain, where the two clock
domains are asynchronous to each other.
Asynchronous FIFOs are used to safely pass data from one clock domain to another clock domain.
There are many ways to do asynchronous FIFO design, including many wrong ways. Most incorrectly implemented
FIFO designs still function properly 90% of the time. Most almost-correct FIFO designs function properly 99%+ of
the time. Unfortunately, FIFOs that work properly 99%+ of the time have design flaws that are usually the most
difficult to detect and debug (if you are lucky enough to notice the bug before shipping the product), or the most
costly to diagnose and recall (if the bug is not discovered until the product is in the hands of a dissatisfied
customer).


The design has been referenced from the paper titled "Simulation and Synthesis Techniques for Asynchronous
FIFO Design" Clifford E. Cummings, Sunburst Design, Inc.
http://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO1.pdf
