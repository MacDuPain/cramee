# README

# Title
Les Mondes de Miss Cramée

# Useful links

- Product Brief (PRD) -> https://carnation-plane-2c9.notion.site/Product-Brief-PRD-cf70fd0175df4969b96136d624d58367
- Trello -> https://trello.com/b/DTak0NdU/projet-final
- Schema de la database -> 

## Description
Dans le cadre de notre projet final pour THP, nous avons pour objectif de développer et livrer un site web fonctionnel pour la mère de Thomas (la cliente), lui permettant de présenter et vendre ses produits, ainsi que de fournir des informations sur son activité globale de créatrice de bijoux.


## Fonctionnalités
- Inscription et connexion des utilisateurs
- Catalogue de produits avec des images de haute qualité et des descriptions détaillées
- Gestion du panier et processus de paiement sécurisé
- Contact facile avec la vendeuse
- Compatibilité mobile
- Optimisation SEO de base

## Installation
### Prérequis
- Ruby 3.0.0
- Rails 6.1.4
- PostgreSQL

### Étapes
1. Clonez le repository :
    ```sh
    git clone https://github.com/username/MyMarketplace.git
    ```
2. Installez les dépendances :
    ```sh
    cd MyMarketplace
    bundle install
    yarn install
    ```
3. Configurez la base de données :
    ```sh
    rails db:create
    rails db:migrate
    rails db:seed
    ```

## Utilisation
1. Lancez le serveur :
    ```sh
    rails server
    ```
2. Ouvrez votre navigateur et allez à `http://localhost:3000`
