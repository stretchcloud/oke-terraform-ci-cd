terraform {
   backend "http" {
     address = "https://objectstorage.us-phoenix-1.oraclecloud.com/p/QzYuhAnBu9zyz7l6QEtmQVz6diPCn0HtgEzWDYf81J4/n/intprasenjits/b/oke-bucket/o/" 
     update_method = "PUT" 
   }
}
