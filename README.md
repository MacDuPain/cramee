<img src="app/assets/images/full_logo.svg" alt="Logo">

# Les M'Ondes de Miss Cramée
"Les M'Ondes de Miss Cramée" représente une enseigne française spécialisée dans la vente de bijoux artisanaux confectionnés à partir de fils en polyester ciré et ornés de pierres naturelles. Fondée par Christelle Bobichon en 2014, cette boutique était jusqu'à présent exclusivement présente sur la plateforme Facebook. Afin de donner davantage de visibilité à Miss Cramée, [Thomas Bobichon](https://github.com/ZealRa/), [Céline Brezin](https://github.com/linexploit), [Sacha Godel ](https://github.com/MacDuPain) et [Xavier Kerleau](https://github.com/xv1106), dans le cadre du projet final de [THP (The Hacking Project)](https://www.thehackingproject.org/), ont proposé le développement d'une application web, dont nous vous mettons le code source en open-source.

# Useful links
- [Product Brief (PRD)](https://carnation-plane-2c9.notion.site/Product-Brief-PRD-cf70fd0175df4969b96136d624d58367)
- [Trello](https://trello.com/b/DTak0NdU/projet-final)
- [Schema de la database](https://www.figma.com/board/Uz8RzqJXWkn1pYHt5ZyXZT/Untitled?node-id=0-1&t=AqopS2rj0IW8LMHn-1)


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
