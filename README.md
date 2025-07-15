## Automatisation de déploiment d'un environnement WordPress via Kubernetes avec CAPI & k0smotron
#### Fonctionne sur Fedora42 -> Suite test, minimum 8Go de RAM et 2vCPU requis pour une infrastructure fonctionnelle
### 1. Installer le cluster de seed
Pour installer le cluster de seed, merci de commencer par executer le fichier "pre-install.sh" (sudo requis)
Une fois terminé, logout et reconnexion sur votre session utilisateur pour prendre en compte les ajout de groupe
Pour terminer, executer le fichier "post-install.sh" (sudo requis)
### 2. Déployer les deux charts helm
helm dependency build charts/wordpress
helm dependency build charts/monitoring-stack
helm install wp charts/wordpress --create-namespace --namespace wordpress
helm install wp charts/monitoring-stack --create-namespace --namespace monitoring-stack
