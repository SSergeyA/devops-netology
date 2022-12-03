local p = import '../params.libsonnet';
local params = p.components.backend;

[
    {
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
            "name": "backend",
            "labels": {
            "app": "backend"
            }
        },
        "spec": {
            "replicas": params.replicas,
            "selector": {
            "matchLabels": {
                "app": "backend"
            }
            },
            "template": {
            "metadata": {
                "labels": {
                "app": "backend"
                }
            },
            "spec": {
                "containers": [
                {
                    "name": "backend",
                    "image": params.image,
                    "ports": [
                    {
                        "containerPort": 9000
                    }
                    ],
                    "env": [
                    {
                        "name": "DATABASE_URL",
                        "value": "postgres://postgres:postgres@bd:5432/news"
                    }
                    ]
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
                "app": "backend"
            },
            "name": "backend"
        },
        "spec": {
            "ports": [
                {
                    "name": "backend",
                    "port": 9000,
                    "targetPort": 9000
                }
            ],
            "selector": {
                "app": "backend"
            },
            "type": "ClusterIP"
        }
    }
]