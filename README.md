<img src="app/assets/images/full_logo.svg" alt="Logo">

# Les M'Ondes de Miss Cramée
*Les M'Ondes de Miss Cramée* représente une enseigne française spécialisée dans la vente de bijoux artisanaux confectionnés à partir de fils en polyester ciré et ornés de pierres naturelles. Fondée par Christelle Bobichon en 2014, cette boutique était jusqu'à présent exclusivement présente sur la plateforme Facebook. Afin de donner davantage de visibilité à Miss Cramée, [Thomas Bobichon](https://github.com/ZealRa/), [Céline Brezin](https://github.com/linexploit), [Sacha Godel](https://github.com/MacDuPain) et [Xavier Kerleau](https://github.com/xv1106), dans le cadre du projet final de [THP (The Hacking Project)](https://www.thehackingproject.org/), ont proposé le développement d'une application web, dont nous vous mettons le code source en open-source.

# Liens utiles
- [Product Brief (PRD)](https://carnation-plane-2c9.notion.site/Product-Brief-PRD-cf70fd0175df4969b96136d624d58367)
- [Trello](https://trello.com/b/DTak0NdU/projet-final)
- [Schema de la database](https://www.figma.com/board/Uz8RzqJXWkn1pYHt5ZyXZT/Untitled?node-id=0-1&t=AqopS2rj0IW8LMHn-1)

# Fonctionnalités
- Inscription et connexion des utilisateurs
- Catalogue de produits avec des images de haute qualité et des descriptions détaillées
- Gestion du panier et processus de paiement sécurisé
- Contact facile avec la vendeuse
- Compatibilité mobile
- Optimisation SEO de base

# Installation
## Prérequis
- Ruby 3.2.2
- Rails 7.1.3
- PostgreSQL

## Utilisation
1. Clonez le repository :

    ```sh
    git clone git@github.com:MacDuPain/cramee.git
    ```

2. Déplacez vous dans le dossier cloné et installez les dépendances :

    ```sh
    bundle install
    ```

3. Configurez la base de données :

    ```sh
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4. Lancez le serveur :

    ```sh
    rails server
    ```

5. Ouvrez votre navigateur et allez à `http://localhost:3000`

## Intégration des clés API
Pour intégrer les fonctionnalités de Stripe et SendGrid dans notre application, il est crucial d'intégrer correctement les clés API correspondantes. Voici comment procéder :

Pour utiliser Stripe et SendGrid dans l'application, vous devez intégrer vos propres clés API. Voici les étapes à suivre :

**Stripe**
1. Obtenir une clé API Stripe :
    - Créez un compte sur [Stripe](https://stripe.com/fr).
    - Accédez à votre tableau de bord Stripe et obtenez vos clés d'API (clé secrète et clé publique).

2. Configurer l'application Rails :
     Dans votre application Rails, configurez Stripe en utilisant votre clé secrète. Habituellement, cela se fait dans un fichier de configuration ou via des variables d'environnement pour des raisons de sécurité.

Exemple de configuration dans config/initializers/stripe.rb :

    ```sh
  Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_SECRET_KEY']
  
  Stripe.api_key = Rails.configuration.stripe[:secret_key]
    ```

Assurez-vous de définir STRIPE_PUBLISHABLE_KEY et STRIPE_SECRET_KEY dans vos variables d'environnement (par exemple, dans un fichier .env).

**SendGrid**
1. Obtenir une clé API SendGrid :
    - Créez un compte sur [SendGrid](https://sendgrid.com/en-us).
    - Accédez à votre tableau de bord SendGrid et générez une clé API.

2. Configurer l'application Rails :
     Utilisez la clé API SendGrid pour configurer l'envoi d'e-mails depuis votre application Rails.

Exemple de configuration dans config/initializers/sendgrid.rb :

    ```sh
ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => ENV['SENDGRID_API_KEY'],
  :domain => 'yourdomain.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
    ```
Assurez-vous de définir SENDGRID_API_KEY dans vos variables d'environnement.

**Remarque importante**

- Sécurité des clés API : Ne jamais inclure directement vos clés API dans votre code source (par exemple, ne pas les hardcoder). Utilisez plutôt des variables d'environnement pour les protéger. Cela évite les risques de compromission de la sécurité.

- Environnements multiples : Pour les environnements de développement, test et production, assurez-vous de configurer correctement vos clés API dans chaque environnement, en utilisant des configurations spécifiques à chaque environnement si nécessaire.

En suivant ces étapes, vous pouvez intégrer de manière sécurisée et efficace les fonctionnalités de paiement via Stripe et d'envoi d'e-mails via SendGrid dans votre application Rails *Les M'Ondes de Miss Cramée*.

# Contribution
Nous accueillons favorablement les contributions pour améliorer *Les M'Ondes de Miss Cramée*. Si vous souhaitez contribuer, veuillez ouvrir une pull request. Assurez-vous que votre proposition soit conforme aux bonnes pratiques de développement et respecte le code de conduite.
