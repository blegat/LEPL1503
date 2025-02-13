# LEPL1503 Projet 3

[<img src="https://plutojl.org/assets/favicon.svg" height="20"/>![](https://img.shields.io/badge/Notebooks-View-blue.svg)<img src="https://plutojl.org/assets/favicon.svg" height="20"/>](https://blegat.github.io/LEPL1503/)
[<img src="https://upload.wikimedia.org/wikipedia/commons/7/72/UCLouvain_logo.svg" height="20"/>](https://uclouvain.be/en-cours-2024-lepl1503)
[<img src="https://upload.wikimedia.org/wikipedia/commons/c/c6/Moodle-logo.svg" height="16"/>](https://moodle.uclouvain.be/course/view.php?id=3842)

This repository contains the sources of the [slides](https://blegat.github.io/LEPL1503/) of some of the classes of the LEPL1503 course given at UCLouvain.

In order to run the notebooks locally, launch Julia an do
```julia
julia> import Pkg

julia> Pkg.activate(".") # Change "." by the path to the folder where this repository was cloned if it's not the current working directory

julia> Pkg.instantiate()

julia> using Pluto
┌ Info: 
│   Welcome to Pluto v0.20.4 🎈
│   Start a notebook server using:
│ 
│ julia> Pluto.run()
│ 
│   Have a look at the FAQ:
│   https://github.com/fonsp/Pluto.jl/wiki
└ 

julia> Pluto.run()
[ Info: Loading...
┌ Info: 
└ Opening http://localhost:1236/?secret=nUTZH3vG in your default browser... ~ have fun!
┌ Info: 
│ Press Ctrl+C in this terminal to stop Pluto
└ 
```
