# **VoteApp - Application de Vote Distribuée**  

## 📌 **Description**  
VoteApp est une application distribuée permettant à une audience de voter entre deux propositions.  
Elle est composée de plusieurs modules conteneurisés avec **Docker** et déployée sur un **cluster Docker Swarm**.

**Remarque** : Avant d'exécuter la commande "**vagrant up**", veuillez consulter la section "**Structure du projet**", notamment la partie concernant le **Vagrantfile**, afin de vous assurer d'utiliser la version appropriée pour votre environnement (*VirtualBox* ou *VMware*).

## 🏗 **Architecture**  

L'application repose sur plusieurs services :  
- **vote** : Une application web en **Python (Flask)** permettant aux utilisateurs de voter  
- **worker** : Un service en **.NET** qui récupère les votes depuis **Redis** et les enregistre dans **PostgreSQL**  
- **result** : Une application web en **Node.js** affichant les résultats en temps réel  
- **redis** : Utilisé comme file d'attente pour stocker temporairement les votes  
- **postgres** : Base de données stockant les votes  

### 📊 **Schéma de l'architecture**  
```
[Vote (Python)] --> [Redis] --> [Worker (.NET)] --> [PostgreSQL] --> [Result (Node.js)]
```

## 🚀 **Technologies Utilisées**  
- **Python 3.11-alpine** + Flask  
- **Node.js node:18-alpine** + npm  
- **.NET Core 7**  
- **Redis**  
- **PostgreSQL 14.5**  
- **Docker & Docker Compose**  
- **Docker Swarm**  

## 🛠 **Installation et Lancement**  

### 1️⃣ **Prérequis**  
- **Docker** et **Docker Compose** installés  
- **VirtualBox** OU **VMware** et **Vagrant** pour le cluster Swarm  

### 2️⃣ **Cloner le projet**  
```sh
git clone https://github.com/claude-boulay/VoteApp.git
cd VoteApp
``` 

### 3️⃣ **Déploiement sur Docker Swarm**  

#### 🔹 **1. Démarrer le cluster Swarm**  
```sh
vagrant up
```
Cela démarre **3 machines** :  
- **manager1** (Nœud principal)  
- **worker1** & **worker2** (Nœuds travailleurs)  

#### 🔹 **2. Initialiser Swarm sur le manager**  
```sh
vagrant shh manager1
vagrant@manager1:~$ docker swarm init --advertise-addr <IP_MANAGER>
```

#### 🔹 **3. Ajouter les workers**  
Sur chaque worker (`worker1` et `worker2` avec **vagrant ssh worker1** OU **worker2**), exécuter la commande `docker swarm join ...` fournie après l'init.

#### 🔹 **4. Déployer l'application sur le cluster**  
Depuis `manager1` (vagrant ssh manager1) et dans le répertoire  `/vagrant/voting-app `:  
```sh
vagrant shh manager1
vagrant@manager1:~$ docker stack deploy -c docker-compose.yml vote-app
```

#### 🔹 **5. Vérifier le déploiement**  
```sh
vagrant shh manager1
vagrant@manager1:~$ docker service ls
```

#### 🔹 **6. Aller voter**  
Avec votre navigateur préféré, rendez-vous sur `http://192.168.99.100:8080/` pour voter. 

#### 🔹 **7. Voir le résultat des votes**  
Avec ce même navigateur, rendez-vous sur `http://192.168.99.100:8888/` afin de voir le résultat des votes.

**Remarque** : Afin d'actualiser les votes et également pour voir les vote une fois remi à zéro, **relancer** les services :  
```sh
vagrant shh manager1 
vagrant@manager1:~$ docker stack deploy -c /vagrant/voting-app/docker-compose.yml vote-app
```

#### 🔹 **8. Réinitialiser les votes**  
```sh
vagrant ssh manager1
vagrant@manager1:~$ cd /vagrant/voting-app
vagrant@manager1:/vagrant/voting-app$ chmod +x ./reset.bash
vagrant@manager1:/vagrant/voting-app$ ./reset.bash
```

## 📜 **Structure du projet**  
```
VoteApp/ 
│── .gitignore

│── README.md

│── Vagrantfile-Virtualbox # ! À renommer "Vagrantfile" avant de faire "vagrant up" si vous utilisez Virtualbox !

│── Vagrantfile-VMware # ! À renommer "Vagrantfile" avant de faire "vagrant up" si vous utilisez VMware !

│── voting-app/ 
    │── vote/       # Code source de l'application Vote (Python)
    │── result/     # Code source de l'application Result (Node.js)
    │── worker/     # Code source du Worker (.NET)
    │── docker-compose.yml      # Configuration des conteneurs
    │── Vagrantfile     # Configuration du cluster Swarm
```

## 🖊 **Auteurs**  
- **Claude Boulay** - [GitHub](https://github.com/claude-boulay)  
- **Steven Coublant** - [GitHub](https://github.com/StevenCsth)  
