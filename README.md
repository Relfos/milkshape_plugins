Milkshape Plugins For Delphi
============

This project shows how to implement a Milkshape3D plugin written in Delphi/Object Pascal (and without needing any wrappers).  

The main trick here is to emulate a C++ class in memory, by writing a custom VMT and some method interceptors that catch any calls to the "fake" C++ class, decode a 'thiscall' convention and dispatch the methods from the Delphi class.  

Written mostly as proof of concept, I also added some custom Milkshape plugins I've written.  

This technique could be adapted for other situations that require executing Object Pascal code called from C++.

* Author: [Sérgio Flores](https://github.com/relfos)
* License: [APACHE](http://opensource.org/licenses/Apache-2.0)

