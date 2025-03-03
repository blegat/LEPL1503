### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 3467ae64-1162-40c3-ae82-fa605e1325df
import Pkg

# ╔═╡ 76aa8111-1ecd-44c8-8ee2-6d74d82d38c5
Pkg.activate(".")

# ╔═╡ 62ea7632-cfe1-4d0a-90db-d7d3eee27763
using PlutoUI, PlutoUI.ExperimentalLayout, MyUtils, PlutoTeachingTools

# ╔═╡ d9b5ce6e-f80d-11ef-26cd-f5e2c18c51bb
header("LEPL1503/LSINC1503 - Cours 3", "O. Bonaventure, B. Legat, L. Metongnon")

# ╔═╡ cbab5d55-63e2-46a4-b86f-d00eb0f1c507
frametitle("Rappel organisation du cours")

# ╔═╡ 28ad2f17-89d5-44b4-87c3-d385d874ed87
md"""
Rappel slides du premier cours

> Permanence le vendredi de 13h à 15h les semaines où il n’y a pas de cours théorique

Le tuteur n'a pas le temps de résoudre les problèmes d'installation en séance
"""

# ╔═╡ 226a5f51-738e-4abf-9cbe-f131dae2ea55
section("Git")

# ╔═╡ 88674bd2-66b1-4c49-a7dd-071b93188d1f
frametitle("Contexte")

# ╔═╡ fe8b1e1b-8a8b-4d44-8045-0fbc205e7814
md"""
* Linus Torvalds crée $(image_from_url("https://upload.wikimedia.org/wikipedia/commons/e/e0/Git-logo.svg", :height => "15pt")) en 2005
* [A maintenant 87 % du market share les logiciels de gestion de versions](https://6sense.com/tech/version-control)
* Serveur open source $(image_from_url("https://upload.wikimedia.org/wikipedia/commons/c/c8/GitLab_logo_%282%29.svg", :height => "15pt")) (utilisé par [la forge](https://forge.uclouvain.be))
  - GitLab CI permet de run les tests et build la documentation de façon **automatisé** et **reproductible** à *chaque nouveau commit*
* En 2014, Satya Nadella remplace Steve Ballmer en tant que CEO de $(image_from_url("https://upload.wikimedia.org/wikipedia/commons/9/96/Microsoft_logo_%282012%29.svg", :height => "15pt"))
  - 2016: Release du logicel open source VS Code $(image_from_url("https://upload.wikimedia.org/wikipedia/commons/9/9a/Visual_Studio_Code_1.35_icon.svg", :height => "15pt"))
  - 2016: Release de Windows Subsystem for Linux (WSL) → *Virtually* all OS are $(image_from_url("https://static.wikia.nocookie.net/logopedia/images/0/0e/Unix.svg", :height => "12pt")) now!
  - En 2018,  acquisition de $(image_from_url("https://static.wikia.nocookie.net/windows/images/0/01/GitHub_logo_2013.png/revision/latest?cb=20231201024220", name = "GitHub_logo_2013.png", :height => "20pt"))
    * Lancement de GitHub Actions (imitant GitLab CI) gratuit pour dépôts open source
"""

# ╔═╡ 0a31d929-9d65-417b-b6b2-e432a1f01ffe
aside(md"""[Tutoriel $(image_from_url("https://upload.wikimedia.org/wikipedia/commons/e/e0/Git-logo.svg", :height => "15pt")) disponible dans le syllabus](https://lepl1503.info.ucl.ac.be/syllabus/outils/git.html)""", v_offset = -150)

# ╔═╡ 2f255c13-f975-40b6-9ca4-e3ca08960126
frametitle("Typical workflow")

# ╔═╡ 41830ab8-ad81-4116-972d-9e36a5ee89a1
md"""
Dans le projet, on vous demande d'utiliser le workflow Git classique (voir par exemple [$(image_from_url("https://jump.dev/JuMP.jl/dev/assets/logo-with-text-background.svg", :width => 45px))](https://github.com/jump-dev/JuMP.jl/)):

* **Invariant** La branche `main` la dernière version
  - Elle doit passer tous les tests sans erreurs
  - Les changements incorporés dans `main` ne sont plus sujets à discussion
* Une branch correspond à **un changement**
  - Eviter de mettre plusieurs changements qui ne sont pas liés dans la même branch
  - Une branche n'est **pas** la dernière version du code d'un dévelopeur
    * Un dévelopeur qui veut essayer un autre changement doit repartir de `main` et créer une nouvelle branche
    * Un dévelopeur qui veut aider au même changement peut commit sur la même branch.
"""

# ╔═╡ 6ea1cef3-384c-40a1-a09b-edf604888c3d
diff_version = Foldable(
  md"Si l'invariant est respecté, tout nouveau commit dans `main` pourrait faire l'objet d'une nouvelle release **mais**",
md"""
* Chaque nouvelle release va engendré une update pour les utilisateurs donc évite de le faire ça chaque commit
* Il faut respecter le [semantic versioning](https://semver.org/) donc
  - Si `main` possède une nouvelle feature par rapport à la dernière release, il faut passer par exemple de `1.3.8` à `1.4.0`.
  - Si `main` possède un breaking change par rapport à la dernière release, il faut passer par exemple de `0.3.8` à `0.4.0` ou `1.3.8` à `2.0.0`
""");

# ╔═╡ d6db0b27-cec7-4696-a56b-ced00bf2c843
aside(warning_box(md"""
Il faut faire la différence entre un l*ogiciel de gestion de versions* comme Git et les *versions de releases*.
$diff_version
"""), v_offset = -300)

# ╔═╡ 1c39a7f2-cd5e-456a-bf16-76493e29adeb
frametitle("Le cycle de vie d'une branch")

# ╔═╡ 34da9f3f-4bde-45da-b27b-d6b4445bbe8b
md"""
* Avant tout changement, on part de la dernière version de main:
  - `git checkout main`
  - `git pull origin main`
* Après tout changement, on crée une branche et on la push
  - `git checkout -b new_branch`
  - `git commit -am "Courte description"` ce message deviendra le titre du MR
  - `git push origin new_branch`
* Sur GitLab, on crée un merge request (MR) et on attend
  1) le résultat de GitLab CI
  2) les peer reviewing de nos pairs
* Pour résoudre les problèmes de CI ou les reviews, on ajoute des commits sur la branche
  - `git checkout new_branch` (plus besoin de `-b` car la branche existe déjà)
  - `git pull origin new_branch` au cas où d'autres l'ont changé
  - `git commit -am "Address review"` ce message a moins d'importance
  - `git push origin new_branch`
* Une fois que le CI est vert et que nos pairs on accepté, on merge le MR
"""

# ╔═╡ e6b0b664-bf8e-419a-8c10-ac59fc1ae647
Pkg.instantiate()

# ╔═╡ Cell order:
# ╟─d9b5ce6e-f80d-11ef-26cd-f5e2c18c51bb
# ╟─cbab5d55-63e2-46a4-b86f-d00eb0f1c507
# ╟─28ad2f17-89d5-44b4-87c3-d385d874ed87
# ╟─226a5f51-738e-4abf-9cbe-f131dae2ea55
# ╟─88674bd2-66b1-4c49-a7dd-071b93188d1f
# ╟─fe8b1e1b-8a8b-4d44-8045-0fbc205e7814
# ╟─0a31d929-9d65-417b-b6b2-e432a1f01ffe
# ╟─2f255c13-f975-40b6-9ca4-e3ca08960126
# ╟─41830ab8-ad81-4116-972d-9e36a5ee89a1
# ╟─d6db0b27-cec7-4696-a56b-ced00bf2c843
# ╟─6ea1cef3-384c-40a1-a09b-edf604888c3d
# ╟─1c39a7f2-cd5e-456a-bf16-76493e29adeb
# ╟─34da9f3f-4bde-45da-b27b-d6b4445bbe8b
# ╟─3467ae64-1162-40c3-ae82-fa605e1325df
# ╟─76aa8111-1ecd-44c8-8ee2-6d74d82d38c5
# ╟─e6b0b664-bf8e-419a-8c10-ac59fc1ae647
# ╟─62ea7632-cfe1-4d0a-90db-d7d3eee27763
