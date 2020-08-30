terraform {
   backend "http" {
     address = "https://objectstorage.us-phoenix-1.oraclecloud.com/p/lsH5fDi9X5vQZxgO7ubemT7NnUw4G1_MVEpWBuinqsc/n/intprasenjits/b/oke-bucket/o/terraform.tfstate" 
     update_method = "PUT" 
   }
}
