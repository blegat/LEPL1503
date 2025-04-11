### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ 678cc353-0b54-4b92-9f08-71556177a038
import Pkg

# ╔═╡ 90a4fe3c-02c7-46e6-b2fb-526e73508101
# ╠═╡ show_logs = false
Pkg.activate(".")

# ╔═╡ 124830e7-cafd-4385-81ce-7e3c7b40011a
using Luxor, PlutoUI, PlutoUI.ExperimentalLayout, MyUtils, PlutoTeachingTools, CommonMark

# ╔═╡ b150ab7f-d9b0-448b-920e-572e27c5b48b
header("LEPL1503/LSINC1503 - Cours 4", "O. Bonaventure, B. Legat, L. Metongnon")

# ╔═╡ 9c2a75a0-cfb4-4e06-ae51-a1228269fb08
section("Ordinateurs actuels")

# ╔═╡ 523984b7-91df-41fe-a2b0-bf90539bd53e
frametitle("Votre Raspberry pi 3B+")

# ╔═╡ c51e7692-5526-4396-b847-b240de1acb98
hbox([
	img("raspberry", :width => "600px"),
	md"""
	[Source](https://datasheets.raspberrypi.com/rpi3/raspberry-pi-3-b-plus-product-brief.pdf)
	"""
])

# ╔═╡ 4ea7323d-1f71-41ed-9da8-a974522168fe
frametitle("Caractéristiques de votre Raspberry pi 3B+")

# ╔═╡ ff9764dc-270a-42ec-a698-3d6ff1357cae
hbox([
	md"""
	### 1.4 GHz
	### 2300 MIPS @ 1Ghz
	### Mémoire cache
	- 16 KB de cache d’instruction L1 pour chaque cœur
	- 16 KB de cache de données L1 pour chaque cœur
	- 512KB de cache unifiée L2
	""",
img("raspberry_little", :width => "350px")
])

# ╔═╡ af7b9efc-ba32-4b03-add1-a8f190c8c288
frametitle("Complexité des processeurs")

# ╔═╡ 4516e783-9589-4ab6-a634-c1902551745f
hbox([
	md"""
	## Loi de Moore
	Le nombre de transistors dans un circuit intégré double quasiment tous les 2 ans
	""",
	img("nb_transistors_progress_graph", :width => "450px")

])

# ╔═╡ d6f888cc-582b-4b24-88a6-94e1ca2e9bd0
frametitle("Caractéristiques des processeurs")

# ╔═╡ 32d33645-25f9-4bd5-9ca4-7ba35965935f
hbox([
img("freq_horloge_cpu_graph", :width => "350px"),
img("nb_instructions_per_sec_graph", :width => "380px")
])

# ╔═╡ 65019147-232a-4162-b747-6ae08f8928fa
frametitle("L'accès à la mémoire")

# ╔═╡ 2131de3a-1f37-4e9b-8faf-22319384acee
img("memory_access_graph", :width => "650px")

# ╔═╡ cb70d153-f0a0-44eb-b315-36283d701163
frametitle("Les mémoires cache")

# ╔═╡ 19cb3ad3-962e-48d1-857d-b77f451031ac
hbox([
	img("Mem_hierarchy.svg", :width => "600px"),
	md"""
	[Source](https://fr.wikipedia.org/wiki/Mémoire_cache)
	"""
])

# ╔═╡ 4a3420e3-0de6-4015-a97b-f9fdc87eaa9c
frametitle("Exemple : multiplication de matrices")

# ╔═╡ 1c4fba05-2124-40d5-af13-8812e8369c01
hbox([
	c"""
	void multiply_matrices(int mat1[N][N], int mat2[N][N], int res[N][N])
	{
	int i, j, k;
	for (i = 0; i < N; i++)
		{
		for (j = 0; j < N; j++)
			{
			res[i][j] = 0;
			for (k = 0; k < N; k++)
				{
				res[i][j] += mat1[i][k] * mat2[k][j];
				}
			}
		}
	}
	""",
	c"""
	void multiply_matrices2(int mat1[N][N], int mat2[N][N], int res[N][N])
	{
	int i, j, k;
	for (j = 0; j < N; j++)
		{
		for (i = 0; i < N; i++)
			{
			res[i][j] = 0;
			for (k = 0; k < N; k++)
				{
				res[i][j] += mat1[i][k] * mat2[k][j];
				}
			}
		}
	}
	"""
])

# ╔═╡ d693a605-4ddb-4434-9040-45f0732fa76e
wooclap("QEAHMX")

# ╔═╡ 832a9a8a-5827-4c11-99bd-be7c648f70f3
qa(md"Un des codes est-il plus rapide ?",
	hbox([
		md"""
			- 6 secondes sans optimisation gcc
			- 2.3 avec optimisation gcc
		""",
		md"""
			- 4.2 secondes sans optimisation gcc
			- 1.63 avec optimisation gcc
		"""
	])
)

# ╔═╡ b5012813-42d2-40f3-a8af-96fc9c60be91
section("Fichiers")

# ╔═╡ cd7b42ef-10c0-41df-a434-ed25efa09d6e
frametitle("Les appels system")

# ╔═╡ c31eb3a1-2c0e-4360-86eb-de982ba45c03
c"""
		int open(const char *pathname, int flags, mode_t mode); // Ouvre le fichier et retourne un file descriptor, en cas d'erreur return -1
		// Toutes les fonctions suivantes utilisent le file descriptor retourné par open
		ssize_t read(int fd, void buf[.count], size_t count); // Permet de lire dans un fichier, en cas d'erreur return -1
	    ssize_t write(int fd, const void buf[.count], size_t count); // Permet d'écrire dans un fichier, en cas d'erreur return -1
	    off_t lseek(int fd, off_t offset, int whence); // Permet de se déplacer dans un fichier, en cas d'erreur return -1
	"""

# ╔═╡ 7a20ee7e-8a2b-4e32-bc7b-fcdbdc981bed
frametitle("Appel system Open")

# ╔═╡ dd7ffd0c-e2a1-4e37-bc49-3dd2c23aa0dd
md"""
	int open(const char *pathname, int flags, mode_t mode);
	Descriptions des arguments :
	1. Le chemin vers le fichier
	2. Le drapeau qui designe le mode d'accès du fichier
	   - O_RDONLY        open for reading only
	   - O_WRONLY        open for writing only
	   - O_RDWR          open for reading and writing
	   - O_APPEND        append on each write
	   - O_CREAT         create file if it does not exist
	   - O_TRUNC         truncate size to 0
	3. Le mode qui représente les permissions (uniquement pour la création de fichier)
	   - S_IRWXU  00700 user (file owner) has read, write, and execute permission
	   - S_IRUSR  00400 user has read permission
	   - S_IWUSR  00200 user has write permission
	   - S_IRWXG  00070 group has read, write, and execute permission
	   - S_IRGRP  00040 group has read permission
	   - S_IWOTH  00002 others have write permission

"""

# ╔═╡ 66c96c52-82d6-4317-afe4-83cc6f3cab80
wooclap("QEAHMX")

# ╔═╡ 4cf4d300-b057-40c0-a667-e737e0d0c2f6
qa(md"Quel 2ème argument pour ouvrir un fichier en écriture, le créer si il n'existe pas et se mettre à la fin pour rajouter du contenu ?",
md"""
  O\_WRONLY|O\_CREAT|0\_APPEND
"""
)

# ╔═╡ 18f5a167-87af-4c53-89b1-18bf7677c241
wooclap("QEAHMX")

# ╔═╡ e4fea1d9-cbbf-43ba-8942-17bdb90a7f93
qa(md"Quel 3ème argument pour donner les permissions rw-r--r-- à un fichier",
md"""
  S\_IRUSR|S\_IWUSR|S\_IRGRP|S\_IROTH
"""
)

# ╔═╡ f00ce4dc-7031-428d-a4ea-0c4138eee251
frametitle("Detection d'erreurs lors des appels system")

# ╔═╡ 7ad1992d-9cc0-4fbe-9b10-4b7d0c9bca47
md"""
  **Un appel système peut échouer pour diverses raisons, il faut donc vérifier le retour de la fonction appelée**
  - La variable globale *errno* mise à jour par **Unix** vous donne un code qui vous informe sur la nature de l'échec de l'appel de la fonction.
  - Cette variable se met à jour seulement en cas d'erreur et n'est pas re-initialisée
  - La fonction *void perror(const char *s)* permet d'interpreter l'erreur courante de errno
  - La fonction *char *strerror(int errnum)* permet d'nterpreter l'erreur courante de errno
"""

# ╔═╡ cfe36d4f-f80a-4ed9-9692-c283dfa15ccd
c"""
      int fd = open(filename, flags, mode);
	  if (fd == -1) {
		if (errno == ENOENT) {
		  // No such file or directory
		} else if (errno == EACCES) 
		  // Permission denied
		} else {
		  perror('open');
		}
	  }
	"""

# ╔═╡ 15cf3ef6-1026-4c18-928c-b2fe2618621e
frametitle("Les descripteurs de fichiers")

# ╔═╡ ec48c057-5561-4bff-953f-c9f3654855cb
md"""
	- Il s'agit d'un ID qui permet d'identifier les fichiers ouverts par un processus
	- La liste de ces descripteurs de fichiers sont maintenus par le Noyau pour chaque processus

	| File Descriptor | Flux       |
	|-----------------|------------|
	| 0               | Stdin      |
	| 1               | Stdout     |
	| 2               | Stderr     |
	| 3               | First File |
	- Le file descriptor est le premier entier disponible dans la liste sinon on en crée un nouveau
"""

# ╔═╡ b6e44edd-c618-408d-818c-bbc45e019c72
c"""
	#include <fcntl.h> // pour open
	#include <stdio.h>

	int main(int argc, char **argv) {
		int fd1,fd2,fd3,err;

		fd1=open("/dev/zero",O_RDONLY);
		printf("Filedescriptor : %d\n",fd1);
		fd2=open("/dev/zero",O_RDONLY);
		printf("Filedescriptor : %d\n",fd2);
		err=close(fd1);
		fd3=open("/dev/zero",O_RDONLY);
		printf("Filedescriptor : %d\n",fd3);
	}
"""

# ╔═╡ 9695ec17-accc-48e9-9ed6-d8884887eb55
frametitle("La gestion de la mémoire dans le passé")

# ╔═╡ 8912c828-f5f8-4b17-8dc3-66a23d2f9d2c
img("ram", :width => "650px")

# ╔═╡ ce754992-1197-4565-87f6-a69faa9c9e20
frametitle("La gestion de la mémoire de nos jours")

# ╔═╡ 011aded6-5b13-43b5-861f-c8c8d28ba218
img("mmu", :width => "650px")

# ╔═╡ 21e3e276-8d04-431d-892b-94f3df45e765
frametitle("Le mappage en mémoire")

# ╔═╡ 45438920-b6f1-4b3f-86f1-0b84f5e4f031
img("map", :width => "650px")

# ╔═╡ 0f1dbd64-a0a3-4410-b886-6849cf88b991
frametitle("Appel système mmap et munmap")

# ╔═╡ cdf8d4a6-4b07-48da-b4ee-0ed99b314450
md"""
	void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
	Descriptions des arguments :
    1. L'addresse où le le fichier a été mappé. Quand il est à NULL, le noyau choisit l'addresse
	2. La taille du fichier en octets
	3. La protection appliquée à l'emplacement en mémoire
	   - PROT_EXEC  Pages may be executed.
       - PROT_READ  Pages may be read.
       - PROT_WRITE Pages may be written.
       - PROT_NONE  Pages may not be accessed.
	4. Les drapeaux qui determine si les mise à jour du mapping seront exclusive ou non aux processus.
	   - MAP_SHARED  Share this mapping.
       - MAP_PRIVATE Create a private copy-on-write mapping.
	5. Le file descriptor obtenu avec open
	6. offset permet de spécifier où il faut commencer à lire
"""

# ╔═╡ 2d31195c-d525-4b75-b448-eb3ba58486fd
md"""
	int munmap(void addr, size_t length);
	Il supprime le mapping de la mémoire
"""

# ╔═╡ 9b9560e8-7b4b-43c1-9be7-079e1928567c
section("Threads")

# ╔═╡ 6d232c36-68cc-42e4-b24f-3f8e28bbc21d
frametitle("Les pointeurs vers les fonctions")

# ╔═╡ dd5a283e-d1c3-42f2-a961-4b078fa0b2af
tutor(c"""
#include <stdio.h>
int mul(int a, int b)
{
  return a*b;
}

int sum(int a, int b)
{
  return a+b;
}

int main(int argc, char **argv){
  int (*f) (int, int);
  f = &sum;
  printf("%d, %p\\n", f(4, 5), f);
  f = &mul;
  printf("%d, %p\\n", f(4, 5), f);

  return 0;
}
""")

# ╔═╡ ed08082d-0e3c-4919-b563-4e6b92cb1e01
md"""
#include <stdlib.h>

void qsort(void *base, size_t nmemb, size_t size,
           int(*compar)(const void *, const void *));

DESCRIPTION
The qsort() function sorts an array with nmemb elements of size size. The base argument points to the start of the array.
The contents of the array are sorted in ascending order according to a comparison function pointed to by compar, which is called with two arguments that point to the objects being compared.
The comparison function must return an integer less than, equal to, or greater than zero if the first argument is considered to be respectively less than, equal to, or greater than the second. If two members compare as equal, their order in the sorted array is undefined.
"""

# ╔═╡ d3ace570-38c6-47a3-a456-70c051373289
c"""
qsort(array,SIZE,sizeof(double),cmp);
int cmp(const void *ptr1, const void *ptr2) {
  const double *a=ptr1;
  const double *b=ptr2;
  if(*a==*b)
    return 0;
  else
    if(*a<*b)
      return -1;
    else
      return +1;
}
"""

# ╔═╡ 698ebf5d-2319-43be-bef2-138e64e0467b
frametitle("Partage du CPU")

# ╔═╡ cda42027-df22-436f-b1bd-6c854334008e
hbox([
	md"""
		- Plusieurs processus tournent en même temps sur un ordinateur
		- Exécution OS
		- Hardware génère une interruption toutes t millisecondes, horloge appel système
		- Un processus peut être interrompu à tout instant par le kernel !
	""",
	img("partage_cpu", :width => "350px")
])

# ╔═╡ 57b0ebb3-5fe4-498b-96e5-b870f23f5823
frametitle("Threads")

# ╔═╡ 470620b4-d817-43bb-ad13-24979b2cfc43
md"""
	- De nombreuses applications font plusieurs actions simultannées
	- un outil graphique avec fenêtres ouvertes
	- un make compilant plusieurs fichiers C
	- Il est naturel de séparer ces activités, mais créer un processus pour chacune est coûteux et complique les interactions entre sous-processus
"""

# ╔═╡ b0049332-4936-4175-8095-ce4f17885b1a
frametitle("Les appels system Threads")

# ╔═╡ 266e2b4b-2c31-4684-abff-18441b2906c8
c"""
	int pthread_create(pthread_t *restrict thread,
                          const pthread_attr_t *restrict attr,
                          typeof(void *(void *)) *start_routine,
                          void *restrict arg); // Cette fonction permet de créer le thread
	void pthread_exit(void *retval); // Cette fonction permet de terminer le thread et de retourner une valeur
	int pthread_join(pthread_t thread, void **retval); // Cette fonction demande d'attendre que le thread se finisse
"""

# ╔═╡ bf3106b8-337c-4b7e-98fd-1468ae5efeb1
frametitle("Appel system pthread_create")

# ╔═╡ ade1bc91-d0e8-470f-ab87-9d876b0c46cb
md"""
	int pthread_create(pthread_t *restrict thread,
                          const pthread_attr_t *restrict attr,
                          typeof(void *(void *)) *start_routine,
                          void *restrict arg);
	Descriptions des arguments :
	1. L'ID du thread
	2. Les attributs du thread, il peut être NULL
	3. Le foncteur qui va être exécuté
	4. L'argument du foncteur
"""

# ╔═╡ 23f5128b-3f6e-42a1-b807-25aad7a442ee
md"""
	void *f1(void *param) { }
	void f2(void *param) { }
	void *f3(void param) { }
	void f4() { }
"""

# ╔═╡ 86362358-a98f-485d-9783-9825cecf742b
wooclap("QEAHMX")

# ╔═╡ d5f119b9-63a2-4c6f-9b3b-a3f9f33f6ec5
qa(md"Laquelle des fonctions suivantes",md"""
	void *f1(void *param) { }
""")

# ╔═╡ e30651f2-2eed-49c8-8f8b-3823ca349f15
	c"""
	#include <pthread.h>
	#include <stdio.h>
	int global = 0;
	void *thread_first(void * param) {
  		global++;
  		return(NULL); // Une facon de terminer un thread
	}
	void *thread_second(void * param) {
  		global++;
  		pthread_exit(NULL); // Une autre facon de terminer un thread
	}

	int main (int argc, char *argv[])  {
		pthread_t first, second;
		int err;

		err=pthread_create(&first,NULL,&thread_first,NULL); 
		if(err!=0)
			perror("pthread_create");

		err=pthread_create(&second,NULL,&thread_second,NULL); 

		for(int i=0; i<1000000000;i++) { /*...*/ }

		err=pthread_join(first,NULL);
			if(err!=0)
				perror("pthread_join");
		err=pthread_join(second ,NULL);
			if(err!=0)
				perror("pthread_join");
	}
	"""

# ╔═╡ 26a1ee91-1710-4940-a66d-825dd892bcba
frametitle("")

# ╔═╡ c6d9420b-8ba9-40df-b649-1a78653acf3e
c"""
	pthread_t threads[NTHREADS];
  	int arg[NTHREADS];
	void *neg (void * param) {
		int *l;
		l=(int *) param;
		int r=-*l;
		return ((void *) &r);
	}
	int main (int argc, char *argv[])  {
		int err;
		for(long i=0;i<NTHREADS;i++) {
			arg[i]=i;
			err=pthread_create(&(threads[i]),NULL,&neg,(void *) &(arg[i])); 
			if(err!=0)
			error(err,"pthread_create");
			int *r;
			err=pthread_join(threads[i],(void **)&r);
			printf("Resultat[%d]=%d\n",i,*r);
			if(err!=0)
			error(err,"pthread_join");
		}
	}
	"""

# ╔═╡ f9d5f5b7-a23b-46c8-bb03-a3d6d89e966a
wooclap("QEAHMX")

# ╔═╡ 4b2b6b79-21f1-4a2c-be2d-cf02467b6a13
qa(md"Le code est-il correct ?",
c""" int arg[NTHREADS];
		pthread_t threads[NTHREADS];
		void *neg (void * param) {
		int *l;
		l=(int *) param;
		int *r=(int *)malloc(sizeof(int));
		*r=-*l;
		return ((void *) r);
		}
		int main (int argc, char *argv[])  {
		int err;
		for(long i=0;i<NTHREADS;i++) {
		arg[i]=i;
		err=pthread_create(&(threads[i]),NULL,&neg,(void *) &(arg[i]));
		if(err!=0)
			error(err,"pthread_create");
			
			int *r;
			err=pthread_join(threads[i],(void **)&r);
			printf("Resultat[%d]=%d\n",i,*r);
			free(r);
			if(err!=0)
			error(err,"pthread_join");
		}
	 """
)

# ╔═╡ 72986e7d-37c8-4d0c-9624-24336a08fc20
c"""
	pthread_t t1;

	void *f(void *param) { }
	void launch(void ){
	pthread_t t2;
	pthread_t * t3=(pthread_t *) malloc(sizeof(pthread_t));

	int err=pthread_create(&t1,NULL,&f, v);
	err=pthread_create(t1,NULL,&f, v);
	err=pthread_create(&t2,NULL,&f, v);
	err=pthread_create(t3,NULL,&f, v);
	}
"""

# ╔═╡ 7ad4d3f3-ba5c-4e2a-a013-a671c0183de6
wooclap("QEAHMX")

# ╔═╡ d5965023-ff2f-4147-8441-f9ef1b14528c
qa(md"Lequel ou lesquels des appels a pthread_create est correct",
c"""
	pthread_create(&t1,NULL,&f, v);
	pthread_create(t3,NULL,&f, v);
	"""
)

# ╔═╡ de619cdb-e82c-4899-931e-bd79e4a115a3
c"""
int fd1;

void *f1(void *param) {
  char buf;
  int err=read(fd1,&buf,sizeof(char));
}
int main(…) {

 fd1=open("t1.dat",O_RDWR);
 int err=pthread_create(&(t1),NULL,&f1,NULL);
"""

# ╔═╡ 82274b7c-b373-4ac5-81c8-f9c8ebc09c40
wooclap("QEAHMX")

# ╔═╡ 1f8f5bc3-94e9-4a2a-949f-50470c3801c9
qa(md"Que se passe t-il dans le thread principal et dans le thread créé",
md"Les deux threads ont accès au fichier, mais chacun avec le même pointeur de lecture")

# ╔═╡ 3b4da661-112b-4c07-b1fa-9b48f8b88c55
frametitle("Passer plusieurs réels à un thread")

# ╔═╡ f69608cd-b72b-4de7-b723-f3a3c195efed
c"""
	pthread_t pt;
	double tab[2]={2.0,3.0}; //Utiliser un tableau

	void *f3(void *param) {
	printf("f3\n");
	double *p=(double *) param;
	printf("%f %f\n",*p,*p+1);
	return NULL;
	}
	int main( int argc, char **argv) {
	int err=pthread_create(&pt,NULL,&f3,(void *)tab)
"""

# ╔═╡ 3d63c085-d739-4553-9e8d-fdc21a529954
c"""
pthread_t pt;
struct pair { // Utiliser une structure
  double x;
  double y;
}; 
void *f2(void *param) {
  struct pair *p=(struct pair *) param;
  printf("%f %f\n",p->x,p->y);
  return NULL;
}
int main( int argc, char **argv) {
struct pair * a =(struct pair *) malloc(sizeof(struct pair));
a->x=2.3; a->y=4.5;
int err=pthread_create(&pt,NULL,&f2,(void *)a);
"""

# ╔═╡ 37eb768e-d085-4dc6-87f5-8ad91227acb6
frametitle("Attention à printf")

# ╔═╡ a594301e-c385-4cf6-b80f-af3b6c8f2ffb
md"""
	Méfiez-vous !
		- Tous les threads partagent stdout, mais printf utilise un buffer qui n'envoie 
		- des données sur stdout que lorsqu'il y en a suffisamment
		- man fflush
"""

# ╔═╡ 89e02c70-2a4f-4b99-b82d-9cfda85267b4
frametitle("Les états d'un thread")

# ╔═╡ 040ed39b-e547-4bdd-9c1c-0cc83dc9010d
img("thread_state", :width => "650px")

# ╔═╡ f8cb54d2-2b46-4839-8f4f-cff9dffe5972
section("Mutex et sémaphores")

# ╔═╡ 104ce982-0363-4e52-9663-9df6e9f7c83d
frametitle("Communication entre threads")

# ╔═╡ d5e2e2ad-d2d7-432c-98a9-bcb71922804b
hbox([
	img("stack_threads", :width => "450px"),
	md"""
		En utilisant les zones mémoires accessibles aux deux threads
			- variables globales
			- heap
	"""
])

# ╔═╡ 29933156-5532-43cf-8577-ecbac51b0bd3
frametitle("Les dangers avec les threads")

# ╔═╡ 638df949-1488-456a-a91d-afc2e34c2549
md"""
Violation d’exclusion mutuelle
- Deux threads modifient la même zone mémoire sans coordination
"""

# ╔═╡ 0c0106db-8117-4d18-82e2-effde1379a6b
hbox([
	c"""long global=0;
int increment(int i) {
  return i+1;
}
void *func(void * param) {
  for(int j=0;j<1000000;j++) {
    global=increment(global);
 }
  return(NULL);
} """,
	md"""
		for i in {1..5}; do ./pthread-test;  done
			global: 3408577
			global: 3175353
			global: 1994419
			global: 3051040
			global: 2118713
	"""
])

# ╔═╡ 2e5622a7-5fe7-4c2e-b33b-a986dba643f6
hbox([
md"""
## Deadlock

L’ensemble du programme est bloqué 
en attente sur des mutex ou des sémaphore
""",
img("hellgrind", :width => "350px")
])

# ╔═╡ 3b08b786-abb9-404d-8c76-4db9e6c10915
frametitle("Problème de l'exclusion mutuelle: les sections critiques")

# ╔═╡ 85b929fa-848d-47d5-9a9f-e458753f7e2d
img("section_critique", :width => "650px")

# ╔═╡ 464190c6-a826-4c61-ab4f-0b936816d0c2
md"""
	Conditions à remplir par une solution 
		- Deux threads ne peuvent y être en même temps
		- Un thread se trouvant hors de sa section critique ne peut pas bloquer un autre thread
		- Un thread ne doit pas attendre indéfiniment le droit d'entrer dans sa section critique
		- Aucune hypothèse n'est faite sur la vitesse des threads ou le nombre de CPUs
"""

# ╔═╡ 0b42d8e7-adcf-43ed-bb5f-5f6ffa92a70a
frametitle("Mutex posix")

# ╔═╡ d246b6fe-977b-4c68-b8b3-807898da6936
md"""
	Structure de données spéciale de la librairie threads POSIX associée à une ressource
		- libre (unlocked en anglais)
		- réservée (locked en anglais)
"""

# ╔═╡ 4faa992d-20d1-4913-b2b9-b23c55044bcf
img("mutex", :width => "650px")

# ╔═╡ 788ec052-987d-4328-9e53-c030bd3def87
frametitle("Les opérations sur les mutex")

# ╔═╡ f42ade01-d9b5-4832-b280-f310b89d773c
md"""
	3 opérations possibles sur un mutex
		1. Initialisation à unlocked
		2. lock(m)
		3. unlock(m)
"""

# ╔═╡ f700dd17-a1e1-4cf2-a03b-58dbadf6dcb2
md"""
	pthread_mutex_lock(…)
	pthread_mutex_unlock(…)
	pthread_mutex_init(…)
"""

# ╔═╡ 44c17290-1df2-455d-b792-d8db8f975ed5
wooclap("QEAHMX")

# ╔═╡ 6efa874a-a030-4475-882a-c25b232ca06b
qa(md"""Lesquelles de ces fonctions pourraient bloquer le thread qui les exécute ?""",
md"""
	pthread_mutex_lock(…)
""" )

# ╔═╡ f77751d5-065b-48ee-8646-d3e27f642ec7
frametitle("Le diner des philosophes")

# ╔═╡ 254eb375-41e0-40b2-8fc6-f99491fac0b2
hbox([
md"""
	N philosophes doivent se partager un repas dans une salle de méditation
		- La table contient N fourchettes et N assiettes
		- Chaque philosophe a une place réservée et a besoin pour manger de
			- La fourchette à sa gauche
			- La fourchette à sa droite
""",
img("diner_philosophes", :width => "400px")
])

# ╔═╡ 2e673875-f180-4efd-8f63-7496c6e6e22a
frametitle("Problème avec deux philosophes")

# ╔═╡ c9ee0134-5bb1-48b4-80c4-41d40731a4fc
img("2_philosophers_with_deadlock", :width => "650px")

# ╔═╡ 248d6a2b-2f98-494a-818b-cec54d05f004
wooclap("QEAHMX")

# ╔═╡ 05467069-852c-4548-9a36-352111723ea5
qa(md"""Y a-t-il un deadlock dans le code de ces 2 philosophes ?""",
	md"""
	Oui
	"""
)

# ╔═╡ b592b2c4-af2b-41a7-8ec4-52b0afd6ff69
frametitle("Problème avec deux philosophes sans deadlock")

# ╔═╡ da2931d1-42fa-44b6-982b-c70b17fb6b34
img("2_philosophers_without_deadlock", :width => "650px")

# ╔═╡ 4b482044-dd71-4a22-84d4-9de77d6933b9
frametitle("Problème avec trois philosophes")

# ╔═╡ 11c610ad-7f0c-49ed-b3ed-4c14e9ac57ef
img("3_philosophers_with_deadlock", :width => "650px")

# ╔═╡ 6bdd938f-3071-4f3a-94f7-a8920aeebff2
wooclap("QEAHMX")

# ╔═╡ 5e0b8a1e-1ae9-4ce7-96e0-723e675e228c
qa(md"""Y a-t-il un deadlock dans le code de ces 3 philosophes ?""",
md"""
Oui
"""
)

# ╔═╡ e1ff9f23-3480-4bc5-87cc-48e9e5feafa0
frametitle("Problème avec N philosophes sans deadlock")

# ╔═╡ 5d876109-50c6-4d48-b602-e9eb7279c3b9
img("n_philosophers_without_deadlock", :width => "650px")

# ╔═╡ 3af1f5ab-d7f9-45f8-acce-ab412f72a825
frametitle("Les sémaphores")

# ╔═╡ aa81dd8f-99ea-47bb-a1dd-cbfb5f466f37
md"""
	3 opérations possibles sur un mutex
		1. Init(s) A une valeur entière non-négative
		2. Down(s) parfois appelé wait(s) ou P(s)
		3. Up(s) parfois appelé signal(s)/post(s) ou V(s)
"""

# ╔═╡ 83f6565e-1cf2-403d-989d-7d814b6919c6
img("disktra_semaphore", :width => "650px")

# ╔═╡ d717a3c4-6113-46ed-90a8-9bc9f97eaa1b
frametitle("Appel system pour les semaphores")

# ╔═╡ 413c8ec4-4c87-43b8-9577-2316e8eda546
c"""
	int sem_init(sem_t *sem, int pshared, unsigned int value); // Initialise le nombre de lock
	int sem_wait(sem_t *sem);  // Decrémente le nombre de lock
	int sem_trywait(sem_t *sem); // Decrémente le nombre de lock
	int sem_post(sem_t *sem); // Incrémente le nombre de lock
	}
"""

# ╔═╡ 41f23129-cabe-469d-88cc-793f5108fc6f
frametitle("Le problème du producteur-consommateur")

# ╔═╡ 41af2ddc-9c63-4ebb-bc91-5729fb936fe3
img("producteur_consommateur_with_deadlock", :width => "650px")

# ╔═╡ 3e5a7c82-cab0-45d1-a726-29a1df84f387
wooclap("QEAHMX")

# ╔═╡ f6a80bd6-77b7-4bac-a317-b49d7238e7e2
qa(md"""Y a-t-il un deadlock dans le code du producteur-consommateurs ?""",
md"""
Oui
"""
)

# ╔═╡ 00f9a1b9-c649-459c-a6d1-0f0954868f0b
frametitle("Le problème du producteur-consommateur sans deadlock")

# ╔═╡ f123391a-4ebc-4994-9f60-da6ddd7772a2
img("producteur_consommateur_without_deadlock.png", :width => "650px")

# ╔═╡ b01b54e8-bb01-4998-9542-78a993d41e9d
frametitle("Le problème du producteur-consommateur")

# ╔═╡ 991ff3ca-5741-42d6-85e0-7f35a2a2479a
img("producteur_consommateur_with_mutex_changed", :width => "650px")

# ╔═╡ f71d5323-9389-4110-b904-64ab4bc2b875
wooclap("QEAHMX")

# ╔═╡ 8161f0c4-726d-416c-be5e-1c16aeaf18af
qa(md"""Y a-t-il un deadlock dans le code du producteur-consommateurs ?""",
md"""
Non
"""
)

# ╔═╡ 3aad0ff2-f363-4369-a2f8-4863bdcd2b58
section("Seconde phase du projet")

# ╔═╡ 331a4763-62b3-4498-a16c-8e726f5ad5e4
frametitle("Réduire le temps de calcul")

# ╔═╡ 81c6f074-d947-49f7-97aa-85a2ffdc649d
md""" 
	1. Activer les optimisations du compilateur
		- Multiplication de matrices (1000x1000):
		- gcc mat.c -> exécution en 6.3 secondes
		- gcc –Ofast mat.c -> exécution en 1.6 secondes
	2. Utiliser le plus efficacement les quatre cœurs
		- Réduire les lock/wait au strict nécessaire, sans risquer de violation de section critique
		- Vos threads doivent être les plus indépendants possibles pour être efficaces
		- Vous avez quatre cœurs, ce n’est probablement pas utile de lancer 32 threads, mais peut-être que 6 ou 8 pourraient vous donner de bons résultats
	3. Utiliser le plus efficacement la mémoire cache
		- Un code est plus efficace si il utilise travaille sur des zones de mémoire proches
		- Les éléments d’une structure sont stockés à des adresses proches en mémoire
"""

# ╔═╡ 40025646-a342-4573-995e-8192e853f686
frametitle("Consommation du raspberry pi 3B+")

# ╔═╡ d015b48a-391e-40d0-aa84-a3abdc7de99a
hbox([
img("consommation_raspberry_all", :width => "600px"), 
md"""
[source](https://www.raspberrypi-spy.co.uk/2018/11/raspberry-pi-power-consumption-data/)
"""
])

# ╔═╡ c77d9d17-ee6b-4d72-bd56-5a3951439030
hbox([
img("consommation_raspberry_3B_plus", :width => "600px"), 
md"""
[source](https://www.pidramble.com/wiki/benchmarks/power-consumption
)
"""
])

# ╔═╡ 4a0d76a4-9655-4ec0-930b-3e8776c45c14
frametitle("Optimisations possibles")

# ╔═╡ 8610572e-e21d-4e24-ada3-8634dcf40d85
md"""
	1. Désactiver ce qui est inutile
		- HDMI
		- Réseau ?
		- USB  ?
		- Gardez l’accès à la machine!
	2. Ajuster la fréquence du CPU
		- Un CPU moins rapide peut consommer moins d’énergie qu’un CPU rapide
	3.Désactiver un ou plusieurs coeurs
[source](https://forums.raspberrypi.com/viewtopic.php?f=29&t=99372)
"""

# ╔═╡ 68da5624-1bc8-4527-b4d2-081e33171e0c
hbox([
img("forum_optimizing_raspberry_consumption", :width => "600px"), 
md"""
[source](https://dev.blues.io/blog/tips-tricks-optimizing-raspberry-pi-power/)
"""
])

# ╔═╡ e7d69964-de82-4883-a39c-66f0d606a3e6
frametitle("Réduire la consommation de mémoire")

# ╔═╡ 836deb6f-e1f3-4766-b5e7-6c5bf788e0f9
md"""
	1. Compacter les structures de données utilisées
	2. Stocker intelligemment les matrices creuses
		- Si une matrice a 90% de zéros, inutile de stocker tous ces zéros en mémoire
		- Vous devez avoir le même résultat numérique !
	3. Réduire la taille du programme
		- Différentes stratégies possibles, optimisation du compilateur, retirer une partie des librairies
		- https://interrupt.memfault.com/blog/code-size-optimization-gcc-flags
	4. Allouer la mémoire par blocs plutôt que globalement au début du programme
"""

# ╔═╡ 03c7ea2b-dc5a-4f98-a7e1-e46512376ff2
TableOfContents(depth=1)

# ╔═╡ Cell order:
# ╟─678cc353-0b54-4b92-9f08-71556177a038
# ╟─90a4fe3c-02c7-46e6-b2fb-526e73508101
# ╟─124830e7-cafd-4385-81ce-7e3c7b40011a
# ╟─b150ab7f-d9b0-448b-920e-572e27c5b48b
# ╟─9c2a75a0-cfb4-4e06-ae51-a1228269fb08
# ╟─523984b7-91df-41fe-a2b0-bf90539bd53e
# ╟─c51e7692-5526-4396-b847-b240de1acb98
# ╟─4ea7323d-1f71-41ed-9da8-a974522168fe
# ╟─ff9764dc-270a-42ec-a698-3d6ff1357cae
# ╟─af7b9efc-ba32-4b03-add1-a8f190c8c288
# ╟─4516e783-9589-4ab6-a634-c1902551745f
# ╟─d6f888cc-582b-4b24-88a6-94e1ca2e9bd0
# ╟─32d33645-25f9-4bd5-9ca4-7ba35965935f
# ╟─65019147-232a-4162-b747-6ae08f8928fa
# ╟─2131de3a-1f37-4e9b-8faf-22319384acee
# ╟─cb70d153-f0a0-44eb-b315-36283d701163
# ╟─19cb3ad3-962e-48d1-857d-b77f451031ac
# ╟─4a3420e3-0de6-4015-a97b-f9fdc87eaa9c
# ╟─1c4fba05-2124-40d5-af13-8812e8369c01
# ╟─d693a605-4ddb-4434-9040-45f0732fa76e
# ╟─832a9a8a-5827-4c11-99bd-be7c648f70f3
# ╟─b5012813-42d2-40f3-a8af-96fc9c60be91
# ╟─cd7b42ef-10c0-41df-a434-ed25efa09d6e
# ╟─c31eb3a1-2c0e-4360-86eb-de982ba45c03
# ╟─7a20ee7e-8a2b-4e32-bc7b-fcdbdc981bed
# ╟─dd7ffd0c-e2a1-4e37-bc49-3dd2c23aa0dd
# ╟─66c96c52-82d6-4317-afe4-83cc6f3cab80
# ╟─4cf4d300-b057-40c0-a667-e737e0d0c2f6
# ╟─18f5a167-87af-4c53-89b1-18bf7677c241
# ╟─e4fea1d9-cbbf-43ba-8942-17bdb90a7f93
# ╟─f00ce4dc-7031-428d-a4ea-0c4138eee251
# ╟─7ad1992d-9cc0-4fbe-9b10-4b7d0c9bca47
# ╟─cfe36d4f-f80a-4ed9-9692-c283dfa15ccd
# ╟─15cf3ef6-1026-4c18-928c-b2fe2618621e
# ╟─ec48c057-5561-4bff-953f-c9f3654855cb
# ╟─b6e44edd-c618-408d-818c-bbc45e019c72
# ╟─9695ec17-accc-48e9-9ed6-d8884887eb55
# ╟─8912c828-f5f8-4b17-8dc3-66a23d2f9d2c
# ╟─ce754992-1197-4565-87f6-a69faa9c9e20
# ╟─011aded6-5b13-43b5-861f-c8c8d28ba218
# ╟─21e3e276-8d04-431d-892b-94f3df45e765
# ╟─45438920-b6f1-4b3f-86f1-0b84f5e4f031
# ╟─0f1dbd64-a0a3-4410-b886-6849cf88b991
# ╟─cdf8d4a6-4b07-48da-b4ee-0ed99b314450
# ╟─2d31195c-d525-4b75-b448-eb3ba58486fd
# ╟─9b9560e8-7b4b-43c1-9be7-079e1928567c
# ╟─6d232c36-68cc-42e4-b24f-3f8e28bbc21d
# ╟─dd5a283e-d1c3-42f2-a961-4b078fa0b2af
# ╟─ed08082d-0e3c-4919-b563-4e6b92cb1e01
# ╟─d3ace570-38c6-47a3-a456-70c051373289
# ╟─698ebf5d-2319-43be-bef2-138e64e0467b
# ╟─cda42027-df22-436f-b1bd-6c854334008e
# ╟─57b0ebb3-5fe4-498b-96e5-b870f23f5823
# ╟─470620b4-d817-43bb-ad13-24979b2cfc43
# ╟─b0049332-4936-4175-8095-ce4f17885b1a
# ╟─266e2b4b-2c31-4684-abff-18441b2906c8
# ╟─bf3106b8-337c-4b7e-98fd-1468ae5efeb1
# ╟─ade1bc91-d0e8-470f-ab87-9d876b0c46cb
# ╟─23f5128b-3f6e-42a1-b807-25aad7a442ee
# ╟─86362358-a98f-485d-9783-9825cecf742b
# ╟─d5f119b9-63a2-4c6f-9b3b-a3f9f33f6ec5
# ╟─e30651f2-2eed-49c8-8f8b-3823ca349f15
# ╟─26a1ee91-1710-4940-a66d-825dd892bcba
# ╟─c6d9420b-8ba9-40df-b649-1a78653acf3e
# ╟─f9d5f5b7-a23b-46c8-bb03-a3d6d89e966a
# ╟─4b2b6b79-21f1-4a2c-be2d-cf02467b6a13
# ╟─72986e7d-37c8-4d0c-9624-24336a08fc20
# ╟─7ad4d3f3-ba5c-4e2a-a013-a671c0183de6
# ╟─d5965023-ff2f-4147-8441-f9ef1b14528c
# ╟─de619cdb-e82c-4899-931e-bd79e4a115a3
# ╟─82274b7c-b373-4ac5-81c8-f9c8ebc09c40
# ╟─1f8f5bc3-94e9-4a2a-949f-50470c3801c9
# ╟─3b4da661-112b-4c07-b1fa-9b48f8b88c55
# ╟─f69608cd-b72b-4de7-b723-f3a3c195efed
# ╟─3d63c085-d739-4553-9e8d-fdc21a529954
# ╟─37eb768e-d085-4dc6-87f5-8ad91227acb6
# ╟─a594301e-c385-4cf6-b80f-af3b6c8f2ffb
# ╟─89e02c70-2a4f-4b99-b82d-9cfda85267b4
# ╟─040ed39b-e547-4bdd-9c1c-0cc83dc9010d
# ╟─f8cb54d2-2b46-4839-8f4f-cff9dffe5972
# ╟─104ce982-0363-4e52-9663-9df6e9f7c83d
# ╟─d5e2e2ad-d2d7-432c-98a9-bcb71922804b
# ╟─29933156-5532-43cf-8577-ecbac51b0bd3
# ╟─638df949-1488-456a-a91d-afc2e34c2549
# ╟─0c0106db-8117-4d18-82e2-effde1379a6b
# ╟─2e5622a7-5fe7-4c2e-b33b-a986dba643f6
# ╟─3b08b786-abb9-404d-8c76-4db9e6c10915
# ╟─85b929fa-848d-47d5-9a9f-e458753f7e2d
# ╟─464190c6-a826-4c61-ab4f-0b936816d0c2
# ╟─0b42d8e7-adcf-43ed-bb5f-5f6ffa92a70a
# ╟─d246b6fe-977b-4c68-b8b3-807898da6936
# ╟─4faa992d-20d1-4913-b2b9-b23c55044bcf
# ╟─788ec052-987d-4328-9e53-c030bd3def87
# ╟─f42ade01-d9b5-4832-b280-f310b89d773c
# ╟─f700dd17-a1e1-4cf2-a03b-58dbadf6dcb2
# ╟─44c17290-1df2-455d-b792-d8db8f975ed5
# ╟─6efa874a-a030-4475-882a-c25b232ca06b
# ╟─f77751d5-065b-48ee-8646-d3e27f642ec7
# ╟─254eb375-41e0-40b2-8fc6-f99491fac0b2
# ╟─2e673875-f180-4efd-8f63-7496c6e6e22a
# ╟─c9ee0134-5bb1-48b4-80c4-41d40731a4fc
# ╟─248d6a2b-2f98-494a-818b-cec54d05f004
# ╟─05467069-852c-4548-9a36-352111723ea5
# ╟─b592b2c4-af2b-41a7-8ec4-52b0afd6ff69
# ╟─da2931d1-42fa-44b6-982b-c70b17fb6b34
# ╟─4b482044-dd71-4a22-84d4-9de77d6933b9
# ╟─11c610ad-7f0c-49ed-b3ed-4c14e9ac57ef
# ╟─6bdd938f-3071-4f3a-94f7-a8920aeebff2
# ╟─5e0b8a1e-1ae9-4ce7-96e0-723e675e228c
# ╟─e1ff9f23-3480-4bc5-87cc-48e9e5feafa0
# ╟─5d876109-50c6-4d48-b602-e9eb7279c3b9
# ╟─3af1f5ab-d7f9-45f8-acce-ab412f72a825
# ╟─aa81dd8f-99ea-47bb-a1dd-cbfb5f466f37
# ╟─83f6565e-1cf2-403d-989d-7d814b6919c6
# ╟─d717a3c4-6113-46ed-90a8-9bc9f97eaa1b
# ╟─413c8ec4-4c87-43b8-9577-2316e8eda546
# ╟─41f23129-cabe-469d-88cc-793f5108fc6f
# ╟─41af2ddc-9c63-4ebb-bc91-5729fb936fe3
# ╟─3e5a7c82-cab0-45d1-a726-29a1df84f387
# ╟─f6a80bd6-77b7-4bac-a317-b49d7238e7e2
# ╟─00f9a1b9-c649-459c-a6d1-0f0954868f0b
# ╟─f123391a-4ebc-4994-9f60-da6ddd7772a2
# ╟─b01b54e8-bb01-4998-9542-78a993d41e9d
# ╟─991ff3ca-5741-42d6-85e0-7f35a2a2479a
# ╟─f71d5323-9389-4110-b904-64ab4bc2b875
# ╟─8161f0c4-726d-416c-be5e-1c16aeaf18af
# ╟─3aad0ff2-f363-4369-a2f8-4863bdcd2b58
# ╟─331a4763-62b3-4498-a16c-8e726f5ad5e4
# ╟─81c6f074-d947-49f7-97aa-85a2ffdc649d
# ╟─40025646-a342-4573-995e-8192e853f686
# ╟─d015b48a-391e-40d0-aa84-a3abdc7de99a
# ╟─c77d9d17-ee6b-4d72-bd56-5a3951439030
# ╟─4a0d76a4-9655-4ec0-930b-3e8776c45c14
# ╟─8610572e-e21d-4e24-ada3-8634dcf40d85
# ╟─68da5624-1bc8-4527-b4d2-081e33171e0c
# ╟─e7d69964-de82-4883-a39c-66f0d606a3e6
# ╟─836deb6f-e1f3-4766-b5e7-6c5bf788e0f9
# ╟─03c7ea2b-dc5a-4f98-a7e1-e46512376ff2
