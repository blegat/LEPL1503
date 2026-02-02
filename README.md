# LEPL1503 Projet 3

[<img src="https://plutojl.org/assets/favicon.svg" height="20"/>![](https://img.shields.io/badge/Notebooks-View-blue.svg)<img src="https://plutojl.org/assets/favicon.svg" height="20"/>](https://blegat.github.io/LEPL1503/)
[<img src="https://upload.wikimedia.org/wikipedia/commons/7/72/UCLouvain_logo.svg" height="20"/>](https://uclouvain.be/en-cours-2024-lepl1503)
[<img src="https://upload.wikimedia.org/wikipedia/commons/c/c6/Moodle-logo.svg" height="16"/>](https://moodle.uclouvain.be/course/view.php?id=3842)

This repository contains the sources of the [slides](https://blegat.github.io/LEPL1503/) of some of the classes of the LEPL1503 course given at UCLouvain.
You can visualize the slide through [this link](https://blegat.github.io/LEPL1503/). In order to turn on the presentation mode, enter `present()` in the JavaScript console of your browser (e.g. open it with <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>I</kbd> on Firefox).

## Schedule

Semaine | Lundi | Objectif | Deadlines
------- | ------- | ------- | ---------
S1      | 02/02   | TP1 |
S2      | 09/02   | TP2 |
S3      | 16/02   | TP3 |
S4      | 23/02   | TP4 |
S5      | 02/03   | Détection des mots incorrects |
S6      | 09/03   | Correction mots incorrects |
S7      | 16/03   | Détection de la langue | Vendredi 18h: Projet (partie 1)
S8      | 23/03   | TP5 Lecture/Écriture des fichiers | Vendredi 18h: Peer Reviews + Evaluation de la dynamique de groupe (Dynamo)
S9      | 30/03   | TP6 Parallélisation |
S10     | 06/04   | Parallélisation |
S11     | 13/04   | Optimisations |
🥚      | 🥚      | 🐰 |
🥚      | 🥚      | 🐰 |
S12     | 04/05   | Dernières modifications | Vendredi 18h: Projet (code et README)
S13     | 11/05   | Rendu pour le **11/05/2026 à 23h59** | Présentation orale

## Run the slides locally

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
