
// this file has the baseline default parameters
{
  components: {

    "frontend": {
      "replicas": 1,
      "image": "ssergeya/frontend:1.0.5"
    },
    
    "backend": {
      "replicas": 1,
      "image": "ssergeya/backend:1.0.5",
    },
 

    "db": {
      "replicas": 1,
      "image": "postgres:13-alpine",
    },
    
  }
}
