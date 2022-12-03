local p = import '../params.libsonnet';
local params = p.components.db;

[
   {
      "apiVersion": "apps/v1",
      "kind": "StatefulSet",
      "metadata": {
         "name": "db",
         "labels": {
            "app": "db"
         }
      },
      "spec": {
         "serviceName": "postgres",
         "replicas": params.replicas,
         "selector": {
            "matchLabels": {
               "app": "db"
            }
         },
         "template": {
            "metadata": {
               "labels": {
                  "app": "db"
               }
            },
            "spec": {
               "containers": [
                  {
                     "image": params.image,
                     "name": "db",
                     "env": [
                        {
                           "name": "POSTGRES_DB",
                           "value": "news"
                        },
                        {
                           "name": "POSTGRES_PASSWORD",
                           "value": "postgres"
                        },
                        {
                           "name": "POSTGRES_USER",
                           "value": "postgres"
                        },
                        {
                           "name": "PGDATA",
                           "value": "/data/pgdata"
                        }
                     ],
                     "ports": [
                        {
                           "containerPort": 5432
                        }
                     ],
                     "volumeMounts": [
                        {
                           "name": "postgres-pv-prod",
                           "mountPath": "/data"
                        }
                     ]
                  }
               ],
               "volumes": [
                  {
                     "name": "postgres-pv-prod",
                     "persistentVolumeClaim": {
                        "claimName": "postgres-claim-prod"
                     }
                  }
               ]
            }
         }
      }
   },
         
   {
      "apiVersion": "v1",
      "kind": "Service",
      "metadata": {
         "labels": {
            "app": "db"
         },
         "name": "postgres",
      },
      "spec": {
         "ports": [
            {
               "name": "postgres",
               "port": 5432,
               "targetPort": 5432
            }
         ],
         "selector": {
            "app": "db"
         },
         "type": "ClusterIP"
      }
   },
   {
      "kind": "PersistentVolumeClaim",
      "apiVersion": "v1",
      "metadata": {
         "name": "postgres-claim-prod",
         "labels": {
            "app": "postgres"
         }
      },
      "spec": {
         "storageClassName": "manual",
         "accessModes": [
            "ReadWriteMany"
         ],
         "resources": {
            "requests": {
               "storage": "1Gi"
            }
         }
      }
   },
   {
      "kind": "PersistentVolume",
      "apiVersion": "v1",
      "metadata": {
         "name": "postgres-pv-prod",
         "labels": {
            "type": "local",
            "app": "postgres"
         }
      },
      "spec": {
         "storageClassName": "manual",
         "capacity": {
            "storage": "1Gi"
         },
         "accessModes": [
            "ReadWriteMany"
         ],
         "hostPath": {
            "path": "/mnt/pv/data"
         }
      }
   }
]