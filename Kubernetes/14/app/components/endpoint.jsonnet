local p = import '../params.libsonnet';
local params = p.components.endpoint;
[
    {
        "apiVersion": "v1",
        "kind": "Service",
        "metadata": {
            "name": "mail-ru"
        },
        "spec": {
            "ports": [
                {
                    "protocol": "TCP",
                    "port": 8080,
                    "targetPort": 80
                }
            ]
        }
    },

    {
        "apiVersion": "v1",
        "kind": "Endpoints",
        "metadata": {
            "name": "mail-ru"
        },
        "subsets": [
            {
                "addresses": [
                    {
                    "ip": "217.69.139.200"
                    },
                    {
                    "ip": "94.100.180.200"
                    },
                    {
                    "ip": "217.69.139.202"
                    },
                    {
                    "ip": "94.100.180.201"
                    }
                ],
                "ports": [
                    {
                    "port": 80
                    }
                ]
            }
        ]
    }
]
