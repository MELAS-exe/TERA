# Étape 1 : Utiliser une image de base officielle
FROM node:alpine3.11

# Étape 2 : Définir le répertoire de travail
WORKDIR /usr/code

# Étape 3 : Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Étape 4 : Installer les dépendances
RUN npm install


# Étape 5 : Copier tout le reste du projet
COPY . .

# Étape 6 : Exposer le port sur lequel l'application s'exécute
EXPOSE 3003

# Étape 7 : Définir la commande de démarrage
CMD ["node", "app.js"]
