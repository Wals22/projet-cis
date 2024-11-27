# Construction d'infrastructures sécurisées

Pour lister les AMI disponibles, exécuter la commande suivante :

```bash
aws ec2 describe-images --owners "amazon" --filters "Name=name,Values=amzn2-ami-hvm-2.*-x86_64-gp2" --query "Images[*].{ID:ImageId,Name:Name}" --output table
```
