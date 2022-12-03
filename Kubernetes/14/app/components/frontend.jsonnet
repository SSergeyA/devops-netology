local p = import '../params.libsonnet';
local params = p.components.frontend;

[
    {
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
            "name": "frontend",
            "labels": {
            "app": "frontend"
            }
        },
        "spec": {
            "replicas": params.replicas,
            "selector": {
            "matchLabels": {
                "app": "frontend"
            }
            },
            "template": {
            "metadata": {
                "labels": {
                "app": "frontend"
                }
            },
            "spec": {
                "containers": [
                {
                    "name": "frontend",
                    "image": params.image,
                    "ports": [
                    {
                        "containerPort": 80
                    }
                    ],
                    "env": [
                    {
                        "name": "BASE_URL",
                        "value": "http://backend:9000"
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
                "app": "frontend"
            },
            "name": "frontend",
        },
        "spec": {
            "ports": [
                {
                    "name": "frontend",
                    "port": 8000,
                    "targetPort": 80
                }
            ],
            "selector": {
                "app": "frontend"
            },
            "type": "ClusterIP"
        }
    }
]